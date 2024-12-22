package tool;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;

import common.CNPath;
import common.JDBConnect;
import dao.PerformDAO;
import dao.PerformDetailDAO;
import dao.TheaterDAO;
import dto.PerformDTO;
import dto.PerformDetailDTO;
import dto.TheaterDTO;
import utils.Downloader;
import utils.JSFunction;

public class DBLoaderFromKOPIS {

	private List<PerformDTO> performList = new ArrayList<PerformDTO>();
	private List<PerformDetailDTO> performDetailList = new ArrayList<PerformDetailDTO>();
	private Map<String, TheaterDTO> theaterMap = new HashMap<String, TheaterDTO>();

	// jhk가 KOPIS에서 발급 받은 키이다.
	private final String serviceKey = "322865f10ae143ada307e2720251a5c6";
	private JSONObject jsonPerformList = null;

	private static DBLoaderFromKOPIS instance = null;

	public static DBLoaderFromKOPIS getInstance() {
		if (instance == null) {
			instance = new DBLoaderFromKOPIS();
		}
		return instance;
	}

	private DBLoaderFromKOPIS() {
		// 외부에서 생성하지 못하게 private
	}

	// =====================================================================================================
	// KOPIS
	private JSONObject makeJsonFromKOPIS(String strUrl) throws MalformedURLException, IOException {

		System.out.println("[makeJsonFromKOPIS] : " + strUrl);

		HttpURLConnection urlConn = (HttpURLConnection) new URL(strUrl).openConnection();
		urlConn.connect();

		BufferedReader reader = new BufferedReader(
		    new InputStreamReader(new BufferedInputStream(urlConn.getInputStream()), "UTF-8"));

		String returnLine;
		StringBuffer resultBuffer = new StringBuffer();

		while ((returnLine = reader.readLine()) != null) {
			resultBuffer.append(returnLine);
		}

		return XML.toJSONObject(resultBuffer.toString());
	}

	public JSONObject getJsonPerformListFromKOPIS(String uri) throws MalformedURLException, IOException {

		String strUrl = "http://www.kopis.or.kr/openApi/restful/pblprfr?service=%s" + uri;

		strUrl = String.format(strUrl, serviceKey);

		System.out.println("[getJsonPerformListFromKOPIS] : " + strUrl);

		jsonPerformList = makeJsonFromKOPIS(strUrl);

		return jsonPerformList;

	}

	public JSONObject getJsonDetailFromKOPIS(String performDetailId) throws MalformedURLException, IOException {

		String strUrl = "http://www.kopis.or.kr/openApi/restful/pblprfr/%s?service=" + serviceKey;

		strUrl = String.format(strUrl, performDetailId);

		System.out.println("[getJsonDetailFromKOPIS] : " + strUrl);

		JSONObject jsonDetailList = makeJsonFromKOPIS(strUrl);

		return jsonDetailList;

	}

	public JSONObject getJsonTheaterFromKOPIS(String theaterId) throws MalformedURLException, IOException {

		String strUrl = "http://www.kopis.or.kr/openApi/restful/prfplc/%s?service=" + serviceKey;

		strUrl = String.format(strUrl, theaterId);

		System.out.println("[getJsonTheaterFromKOPIS] : " + strUrl);

		JSONObject jsonTheaterList = makeJsonFromKOPIS(strUrl);

		return jsonTheaterList;
	}

	private String getStrValue(JSONObject target, String key) {
		if (target == null) {
			System.err.println("[getStrValue] target is null : key <- " + key);
			return "";
		}

		String value = "";

		Object obj = target.get(key);
		if (obj instanceof Integer) {
			value = String.valueOf(obj);
			System.err.format("[getStrValue] %s is Integer : String.valueOf > %s <- ", key, value);
		} else {
			value = target.getString(key);
			if (value == null) {
				System.err.println("[getStrValue] value is null : key <- " + key);
				return "";
			}
		}

		return value;
	}

	private int loadAllFromKOPIS(String realPath) throws MalformedURLException, IOException {

		if (jsonPerformList == null) {
			System.out.println("[loadAllFromKOPIS] jsonPerformList is null");
			return -1;
		}

		JSONArray dbArray = jsonPerformList.getJSONObject("dbs").getJSONArray("db");
		Downloader downloader = new Downloader(realPath);

		performList.clear();
		performDetailList.clear();
		theaterMap.clear();

		for (Object item : dbArray) {
			JSONObject db = (JSONObject) item;

			String performDetailId = getStrValue(db, "mt20id");
			String posterURL = getStrValue(db, "poster");
			String posterFileName = posterURL.substring(posterURL.lastIndexOf("/") + 1);

			PerformDTO perform = new PerformDTO();

			perform.setPerform_Detail_id(performDetailId);
			perform.setName(getStrValue(db, "prfnm"));
			perform.setStart(getStrValue(db, "prfpdfrom"));

			perform.setEnd(getStrValue(db, "prfpdto"));
			perform.setImg_path(posterFileName);
			perform.setState(getStrValue(db, "prfstate"));

			performList.add(perform);

			downloader.download(posterURL, CNPath.IMG_ROOT + performDetailId + "/");

			loadDetailFromKOPIS(realPath, performDetailId);
		}

		if (performList.size() == 0) {
			System.out.println("[loadAllFromKOPIS] performList is empty");
			return -2;
		}

		if (performDetailList.size() == 0) {
			System.out.println("[loadAllFromKOPIS] performDetailList is empty");
			return -3;
		}

		if (theaterMap.size() == 0) {
			System.out.println("[loadAllFromKOPIS] theaterList is empty");
			return -4;
		}

		return 1;
	}

	private void loadDetailFromKOPIS(String realPath, String performDetailId) throws MalformedURLException, IOException {

		String url = "http://www.kopis.or.kr/openApi/restful/pblprfr/%s?service=" + serviceKey;
		url = String.format(url, performDetailId);

		JSONObject jsonDetail = makeJsonFromKOPIS(url);
		JSONObject db = jsonDetail.getJSONObject("dbs").getJSONObject("db");

		Downloader downloader = new Downloader(realPath);

		List<String> storyImgList = new ArrayList<String>();

		Object styurl = db.getJSONObject("styurls").get("styurl");
		if (styurl instanceof JSONArray) {
			// [스토리 이미지] 둘 이상일 경우
			JSONArray styurlArray = (JSONArray) styurl;
			for (Object o : styurlArray) {
				String strPath = o.toString();
				String strFileName = strPath.substring(strPath.lastIndexOf("/") + 1);
				storyImgList.add(strFileName);
				// 상세 페이지에서 요청시 로드하게 변경, 여기서는 주석처리함
				// downloader.download(strPath, imagePath + performDetailId + "/");
			}
		} else {
			// [스토리 이미지] 하나일 경우
			String strPath = styurl.toString();
			String strFileName = strPath.substring(strPath.lastIndexOf("/") + 1);
			storyImgList.add(strFileName);
			// 상세 페이지에서 요청시 로드하게 변경, 여기서는 주석처리함
			// downloader.download(strPath, imagePath + performDetailId + "/");
		}

		PerformDetailDTO detail = new PerformDetailDTO();

		detail.setId(performDetailId);
		detail.setTheater_id(db.getString("mt10id")); // 공연장ID
		detail.setAverage_rate(0f); // 서버에서 계산
		detail.setPrice(db.getString("pcseguidance"));
		detail.setCast(db.getString("prfcast"));
		detail.setImg_path(String.join(",", storyImgList));
		detail.setRuntime(db.getString("prfruntime"));
		detail.setVenue_name(db.getString("fcltynm"));
		
		Object relate = db.getJSONObject("relates").get("relate");
		if (relate instanceof JSONArray) {
			JSONArray relateArray = (JSONArray) relate;
			
			for (Object o : relateArray) {
				JSONObject relateObject = (JSONObject)o;
				String reservationLink = relateObject.getString("relateurl");
				detail.setReservation_link(reservationLink);
				break;
			}
		} else {
			JSONObject relateObject = (JSONObject) relate;
			String reservationLink = relateObject.getString("relateurl");
			detail.setReservation_link(reservationLink);
		}
		
		performDetailList.add(detail);

		loadTheaterFromKOPIS(detail.getTheater_id());

		System.out.println("[loadDetailFromKOPIS] done");
	}

	private void loadTheaterFromKOPIS(String theaterId) throws MalformedURLException, IOException {

		String url = "http://www.kopis.or.kr/openApi/restful/prfplc/%s?service=" + serviceKey;
		url = String.format(url, theaterId);

		JSONObject jsonDetail = makeJsonFromKOPIS(url);
		JSONObject db = jsonDetail.getJSONObject("dbs").getJSONObject("db");

		String key_theaterId = db.getString("mt10id");
		if (!key_theaterId.equals(theaterId)) {
			System.err.println(
			    "[loadTheaterFromKOPIS] dismatch (key_theaterId != theaterId) : " + key_theaterId + ", " + theaterId);
		}

		if (theaterMap.containsKey(theaterId) == false) {

			TheaterDTO theater = new TheaterDTO();

			theater.setId(theaterId);
			theater.setAddress(db.getString("adres"));
			theater.setTotal_seats(db.getInt("seatscale"));
			theater.setVenue_name(db.getString("fcltynm"));

			theaterMap.put(theaterId, theater);

			System.out.println("[DBLoaderFromKOPIS] loadTheaterFromKOPIS - done");
		} else {
			// 한 공연장에서 여러 공연이 있는경우
			System.err.println("[DBLoaderFromKOPIS] 한 공연장에서 여러 공연이 있는경우");
		}
	}

	public int clearDB() throws ClassNotFoundException, SQLException {
		// -----------------------------------------------
		// perform
		{
			PerformDAO dao = new PerformDAO();
			int result = dao.deleteAll();
			if (result != 1) {
				dao.close();
				return result;
			}
			dao.close();
		}
		// -----------------------------------------------
		// perform_detail
		{
			PerformDetailDAO dao = new PerformDetailDAO();
			int result = dao.deleteAll();
			if (result != 1) {
				dao.close();
				return result;
			}
			dao.close();
		}
		// -----------------------------------------------
		// theater
		{
			TheaterDAO dao = new TheaterDAO();
			int result = dao.deleteAll();
			if (result != 1) {
				dao.close();
				return result;
			}
			dao.close();
		}

		return 1;
	}

	public int insertDBFromJson(String realPath)
	    throws ClassNotFoundException, SQLException, MalformedURLException, IOException {

		int result = loadAllFromKOPIS(realPath);
		if (1 != result) {
			return -1;
		}

		// -----------------------------------------------
		// theaterMap
		{
			TheaterDAO dao = new TheaterDAO();
			result = dao.insertMap(theaterMap);
			dao.close();
			if (result == 1)
				System.out.println("[DBLoaderFromKOPIS] theater Map 데이터가 성공적으로 삽입되었습니다.");
			else {
				System.out.println("[DBLoaderFromKOPIS] theater Map 데이터 insert failed.");
				return -6;
			}
		}
		// -----------------------------------------------
		// performDetailList
		{
			PerformDetailDAO dao = new PerformDetailDAO();
			result = dao.insertList(performDetailList);
			dao.close();
			if (result == 1)
				System.out.println("[DBLoaderFromKOPIS] performDetail List 데이터가 성공적으로 삽입되었습니다.");
			else {
				System.out.println("[DBLoaderFromKOPIS] performDetail List 데이터 insert failed.");
				return -5;
			}
		}
		// -----------------------------------------------
		// performList
		{
			PerformDAO dao = new PerformDAO();
			result = dao.insertList(performList);
			dao.close();
			if (result == 1)
				System.out.println("[DBLoaderFromKOPIS] perform List 데이터가 성공적으로 삽입되었습니다.");
			else {
				System.err.println("[DBLoaderFromKOPIS] perform List 데이터 insert failed.");
				return -4;
			}
		}

		return 1;
	}
}

package dto;

import org.json.JSONObject;

public class ViewPerformDTO {
	// 테이블 필드명을 정의해서 여기저기 사용 한다.
	public static final String EMAIL = "email";
	public static final String PERFORM_DETAIL_ID = "perform_detail_id";
	public static final String NAME = "name";
	public static final String START = "start";
	public static final String END = "end";
	public static final String IMG = "img_path";
	public static final String STATE = "state";
	public static final String VENUE_NAME = "venue_name";

	private String email;
	private String perform_detail_id;
	private String name; // 공연명
	private String start; // 시작일
	private String end; // 종료일
	private String img_path; // 포스트
	private String state; // 상태
	private String venue_name;
	
	
	public JSONObject toJSONObject() {
	    JSONObject jsonObject = new JSONObject();

	    jsonObject.put(EMAIL, this.email);
	    jsonObject.put(PERFORM_DETAIL_ID, this.perform_detail_id);
	    jsonObject.put(NAME, this.name);
	    jsonObject.put(START, this.start);
	    jsonObject.put(END, this.end);
	    jsonObject.put(IMG, this.img_path);
	    jsonObject.put(STATE, this.state);
	    jsonObject.put(VENUE_NAME, this.venue_name);  // Perform_Detail_id 추가

	    return jsonObject;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPerform_detail_id() {
		return perform_detail_id;
	}
	public void setPerform_detail_id(String perform_detail_id) {
		this.perform_detail_id = perform_detail_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getVenue_name() {
		return venue_name;
	}
	public void setVenue_name(String venue_name) {
		this.venue_name = venue_name;
	}
	
	
}

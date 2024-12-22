package dto;

import org.json.JSONObject;

import common.CNPath;

public class PerformDTO {

	// 테이블 필드명을 정의해서 여기저기 사용 한다.
	public static final String ID = "id";
	public static final String NAME = "name";
	public static final String START = "start";
	public static final String END = "end";
	public static final String IMG = "img_path";
	public static final String STATE = "state";
	public static final String DETAIL_ID = "Perform_Detail_id";

	private int id; // 자동증가 ID
	private String name; // 공연명
	private String start; // 시작일
	private String end; // 종료일
	private String img_path; // 포스트
	private String state; // 상태
	private String Perform_Detail_id; // 공연세부 ID
	private PerformDetailDTO detail;

	public static String makeRelativeImagePath(String fileName, String rootPath) {
		String[] fileNameSplit = fileName.split("_");
		return rootPath + "/" + CNPath.IMG_ROOT + fileNameSplit[1] + "/" + fileName;
	}

	public JSONObject toJSONObject() {
	    JSONObject jsonObject = new JSONObject();

	    jsonObject.put(ID, this.id);
	    jsonObject.put(NAME, this.name);
	    jsonObject.put(START, this.start);
	    jsonObject.put(END, this.end);
	    jsonObject.put(IMG, this.img_path);
	    jsonObject.put(STATE, this.state);
	    jsonObject.put(DETAIL_ID, this.Perform_Detail_id);  // Perform_Detail_id 추가

	    return jsonObject;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getPerform_Detail_id() {
		return Perform_Detail_id;
	}

	public void setPerform_Detail_id(String perform_Detail_id) {
		Perform_Detail_id = perform_Detail_id;
	}

	@Override
	public String toString() {
		return "PerformDTO [id=" + id + ", name=" + name + ", start=" + start + ", end=" + end + ", img_path="
				+ img_path + ", state=" + state + ", Perform_Detail_id=" + Perform_Detail_id + "]";
	}

	public PerformDetailDTO getDetail() {
        return detail;
    }

    public void setDetail(PerformDetailDTO detail) {
        this.detail = detail;
    }

}

package dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.json.JSONObject;

public class ReportDTO {
	
	public static final String ID 					= "id";
	public static final String DATE 				= "date";
	public static final String REASON 			= "reason";
	public static final String TYPE 				= "type";
	public static final String REPORT_ID 		= "reported_id";
	public static final String USER_EMAIL 	= "User_email";

	private int id; //
	private LocalDateTime date; // 신고일
	private String reason; // 신고사유
	private ReportType type; // 신고타입
	private int reportedId; // 신고된 곳의 아이디(review, comment, board)
	private String userEmail; // 신고자 이메일

	public JSONObject toJson() {
		JSONObject json = new JSONObject();
		json.put(ID, id);
		json.put(DATE, date.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
		json.put(REASON, reason);
		json.put(TYPE, type.toString());
		json.put(REPORT_ID, reportedId);
		json.put(USER_EMAIL, userEmail);
		return json;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDateTime getDate() {
		return date;
	}

	public void setDate(LocalDateTime date) {
		this.date = date;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public ReportType getType() {
		return type;
	}

	public void setType(ReportType type) {
		this.type = type;
	}

	public int getReportedId() {
		return reportedId;
	}

	public void setReportedId(int reportedId) {
		this.reportedId = reportedId;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	@Override
	public String toString() {
		return "ReportDTO [id=" + id + ", date=" + date + ", reason=" + reason + ", type=" + type + ", reportedId="
				+ reportedId + ", userEmail=" + userEmail + "]";
	}

}

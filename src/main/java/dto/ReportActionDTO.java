package dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.json.JSONObject;

public class ReportActionDTO {

	public static final String ID 					= "id";
	public static final String DATE 				= "date";
	public static final String STATES 			= "states";
	public static final String REASON 			= "reason";
	public static final String REPORT_ID 		= "Report_id";

	private int id; 							// 
	private LocalDateTime date; 	// 신고 처리 일
	private ReportStates states; 	// 신고 처리 상태
	private String reason; 				// 신고 처리 사유
	private int Report_id; 				// report table id
	
	
	public JSONObject toJson() {
		JSONObject json = new JSONObject();
		json.put(ID, id);
		json.put(DATE, date.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
		json.put(STATES, states.toString());
		json.put(REASON, reason);
		json.put(REPORT_ID, Report_id);
		return json;
	}
	
	@Override
	public String toString() {
		return "ReportActionDTO [id=" + id + ", date=" + date + ", states=" + states + ", reason=" + reason + ", Report_id="
				+ Report_id + "]";
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
	public ReportStates getStates() {
		return states;
	}
	public void setStates(ReportStates states) {
		this.states = states;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getReport_id() {
		return Report_id;
	}
	public void setReport_id(int report_id) {
		Report_id = report_id;
	}

	
}

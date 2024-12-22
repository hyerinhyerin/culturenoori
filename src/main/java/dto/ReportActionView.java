package dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.json.JSONObject;

public class ReportActionView {

	private int reportActionId; 					//
	private ReportActionDTO reportAction;	// 
	private ReportDTO report;							// 
	private String writerName;						// 신고당한 닉네임 : table report.reported_id-> 대상 게시글,댓글, 답글의 작성자->table user 
	private String reporterName;					// 신고자 닉네임 : table report
	private String reason;								// 처리 내용
	private ReportType reportType;				// 신고대상 : table report
	private LocalDateTime reportDate; 		// 신고일 : table report
	private LocalDateTime actionDate; 		// 처리일 : table report_action
	
	public JSONObject toJson() {
		JSONObject json = new JSONObject();
		
		json.put("reportActionId", reportActionId);
		json.put("reportAction", reportAction.toJson());
		json.put("report", report.toJson());
		json.put("writerName", writerName);
		json.put("reporterName", reporterName);
		json.put("reason", reason);
		json.put("reportType", reportType.toString());
		json.put("reportDate", reportDate.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
		json.put("actionDate", actionDate.format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));

		return json;
	}

	@Override
	public String toString() {
		return "ReportActionView [reportActionId=" + reportActionId + ", reportAction=" + reportAction + ", report="
		    + report + ", writerName=" + writerName + ", reporterName=" + reporterName + ", reason=" + reason
		    + ", reportType=" + reportType + ", reportDate=" + reportDate + ", actionDate=" + actionDate + "]";
	}
	public ReportDTO getReport() {
		return report;
	}
	public void setReport(ReportDTO report) {
		this.report = report;
	}
	public ReportActionDTO getReportAction() {
		return reportAction;
	}
	public void setReportAction(ReportActionDTO reportAction) {
		this.reportAction = reportAction;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public int getReportActionId() {
		return reportActionId;
	}
	public void setReportActionId(int reportActionId) {
		this.reportActionId = reportActionId;
	}
	public String getWriterName() {
		return writerName;
	}
	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}
	public String getReporterName() {
		return reporterName;
	}
	public void setReporterName(String reporterName) {
		this.reporterName = reporterName;
	}
	public ReportType getReportType() {
		return reportType;
	}
	public void setReportType(ReportType reportType) {
		this.reportType = reportType;
	}
	public LocalDateTime getReportDate() {
		return reportDate;
	}
	public void setReportDate(LocalDateTime reportDate) {
		this.reportDate = reportDate;
	}
	public LocalDateTime getActionDate() {
		return actionDate;
	}
	public void setActionDate(LocalDateTime actionDate) {
		this.actionDate = actionDate;
	}

	
	
}

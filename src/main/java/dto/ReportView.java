package dto;

import org.json.JSONObject;

public class ReportView {
	
	private ReportDTO report;
	private String writerName;
	private String reporterName;
	
	// 신고된 곳이 review 인경우 소속된 detailId를 넣어준다.
	// 신고된 곳이 comment, reply 인경우 소속된 boardId를 넣어준다.
	// 신고된 곳이 board 인경우에도 일관된 사용을 위해서 소속된 boardId를 넣어준다.
	private String linkId; 
		
	public JSONObject toJson() {
		JSONObject json = new JSONObject();
		
		json.put("report", report.toJson());
		json.put("writerName", writerName);
		json.put("reporterName", reporterName);
		json.put("linkId", linkId);

		return json;
	}
	
	public String getLinkId() {
		return linkId;
	}
	public void setLinkId(String boardId) {
		this.linkId = boardId;
	}
	public ReportDTO getReport() {
		return report;
	}
	public void setReport(ReportDTO report) {
		this.report = report;
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
	
	

}

package dto;

import java.sql.Date;

public class CommentDTO {
	private int id; //댓글 ID
	private String content; //댓글 내용
	private Date date; // 작성일 
	private int parentCommentId; //대댓글 ID
	private int likeCount; //좋아요 수
	private String UserEmail; //작성자
	private int reportState; // 신고 상태 
	private int boardId; //게시판 ID
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getParentCommentId() {
		return parentCommentId;
	}
	public void setParentCommentId(int parentCommentId) {
		this.parentCommentId = parentCommentId;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public String getUserEmail() {
		return UserEmail;
	}
	public void setUserEmail(String userEmail) {
		UserEmail = userEmail;
	}
	public int getReportState() {
		return reportState;
	}
	public void setReportState(int reportState) {
		this.reportState = reportState;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	@Override
	public String toString() {
		return "CommentDTO [id=" + id + ", content=" + content + ", date=" + date + ", parentCommentId="
				+ parentCommentId + ", likeCount=" + likeCount + ", UserEmail=" + UserEmail + ", reportState="
				+ reportState + ", boardId=" + boardId + "]";
	}

	
	
}

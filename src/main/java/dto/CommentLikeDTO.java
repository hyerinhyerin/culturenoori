package dto;

import java.sql.Date;

public class CommentLikeDTO {
	private Date date;
	private int commentId;
	private String userEmail;
	

	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	

	@Override
	public String toString() {
		return "CommentLikeDTO [date=" + date + ", commnetId=" + commentId + ", userEmail=" + userEmail + "]";
	}
	
}
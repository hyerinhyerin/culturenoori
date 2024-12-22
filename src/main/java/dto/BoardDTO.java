package dto;

import java.sql.Date;

public class BoardDTO {

	public static final String ID="id";
	public static final String TITLE="title";
	public static final String DATE="date";
	public static final String VIEWS="views";
	public static final String TYPE="type";
	public static final String CONTENTS="contents";
	public static final String LIKECOUNT="like_count";
	public static final String USEREMAIL="user_email";
	public static final String IMGPATH="img_path";
	public static final String REPORTSTATE="report_state";
	
	private int id;
	private String title;
	private Date date;
	private int views;
	private String type;
	private String contents;
	private int like_count;
	private String user_email;
	private String img_path;
	private int report_state;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getLike_count() {
		return like_count;
	}
	public void setLike_count(int like_count) {
		this.like_count = like_count;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	public int getReport_state() {
		return report_state;
	}
	public void setReport_state(int report_state) {
		this.report_state = report_state;
	}
	public BoardDTO() {
		super();
	}
	
	@Override
	public String toString() {
		return "BoardDTO [id=" + id + ", title=" + title + ", date=" + date + ", views=" + views + ", type=" + type
				+ ", contents=" + contents + ", like_count=" + like_count + ", user_email=" + user_email + ", img_path="
				+ img_path + ", report_state=" + report_state + "]";
	}
	
	
	
	
}

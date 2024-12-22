package dto;

import java.util.Date;

public class NoticeDTO {
	
	public static final String ID= "id";
	public static final String TITLE= "title";
	public static final String CONTENTS= "contents";
	public static final String DATE= "date";
	public static final String PRIORITY= "priority";
	
	
	private int id;
	private String title;
	private String contents;
	private Date date;
	private int priority;
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
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	@Override
	public String toString() {
		return "NoticeDTO [id=" + id + ", title=" + title + ", contents=" + contents + ", date=" + date + ", priority="
				+ priority + "]";
	}
	
	
}

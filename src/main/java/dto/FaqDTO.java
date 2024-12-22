package dto;

public class FaqDTO {
 private int id;
 private String title;
 private String contents;
 private String date;
 private String comment;
 private String comDate;
 private String userEmail;
 public int getId() {
 return id;
}
 public void setId(int id) {
 this.id= id;
}
 public String getTitle() {
 return title;
}
 public void setTitle(String title) {
 this.title= title;
}
 public String getContents() {
 return contents;
}
 public void setContents(String contents) {
 this.contents= contents;
}
 public String getDate() {
 return date;
}
 public void setDate(String date) {
 this.date= date;
}
 public String getComment() {
 return comment;
}
 public void setComment(String comment) {
 this.comment= comment;
}
 public String getComDate() {
 return comDate;
}
 public void setComDate(String comDate) {
 this.comDate= comDate;
}
 public String getUserEmail() {
 return userEmail;
}
 public void setUserEmail(String userEmail) {
 this.userEmail= userEmail;
}
 
 
 @Override
 public String toString() {
 return "FaqDTO [id="+ id+ ", title="+ title+ ", contents="+ contents+ ", date="+ date+ ", comment="
+ comment+ ", comDate="+ comDate+ ", userEmail="+ userEmail+ "]";
}
 
 
 
 
}

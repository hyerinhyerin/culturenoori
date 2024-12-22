package dto;

import java.sql.Date;

public class WishDTO {
    private Date wish_dt; // wish_dt는 datetime 타입
    private String perform_detail_id; // perform_detail_id는 varchar 타입
    private String user_email; // user_email은 varchar 타입
    
    public Date getWish_dt() {
        return wish_dt;
    }
    
    public void setWish_dt(Date wish_dt) {
        this.wish_dt = wish_dt;
    }
    
    public String getPerform_detail_id() {
        return perform_detail_id;
    }
    
    public void setPerform_detail_id(String perform_detail_id) {
        this.perform_detail_id = perform_detail_id;
    }
    
    public String getUser_email() {
        return user_email;
    }
    
    public void setUser_email(String user_email) {
        this.user_email = user_email;
    }
    
    @Override
    public String toString() {
        return "WishDTO [wish_dt=" + wish_dt + ", perform_detail_id=" + perform_detail_id + ", user_email=" + user_email + "]";
    }
}

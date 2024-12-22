package dto;

import java.util.Date;

import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.sql.Timestamp;

public class ReviewDTO {

	private int id;				//한줄평 ID
	private String contents;		//한줄평 내용
	private Timestamp create_at;		//한줄평 작성날짜
	private int star_num;		//평점
	private String email;			//작성자 email
	private String perform_detail_id;		//한줄평 해당 Perform
	private int repot_state;		//신고여부(?)
	private String nickname;
	private String img_path;

	
	// toJSON() 메서드
    public JSONObject toJSON() {
        JSONObject json = new JSONObject();
        json.put("id", this.id);
        json.put("contents", this.contents);
// [수정] 추후처리 필요         
        
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String formattedDate = sdf.format(this.create_at);
//        json.put("create_at", formattedDate);
        
        json.put("create_at", this.create_at);
        json.put("star_num", this.star_num);
        json.put("email", this.email);
        json.put("perform_detail_id", this.perform_detail_id);
        json.put("repot_state", this.repot_state);
        json.put("nickname", this.nickname);
        json.put("img_path", this.img_path);
        
        return json;
    }
    
    
    
//	public String getFormattedCreateAt() {
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 원하는 포맷으로 변경 가능
//        return sdf.format(this.create_at);
//    }
	
	@Override
		public String toString() {
			return "ReviewDTO [id=" + id + ", contents=" + contents + ", create_at=" + create_at + ", star_num=" + star_num
			    + ", email=" + email + ", perform_detail_id=" + perform_detail_id + ", repot_state=" + repot_state
			    + ", nickname=" + nickname + ", img_path=" + img_path + "]";
		}



	public int getId() {
		return id;
	}
	public String getImg_path() {
		return img_path;
	}


	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}


	public void setId(int id) {
		this.id = id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Timestamp getCreate_at() {
		return create_at;
	}
	public void setCreate_at(Timestamp create_at) {
		this.create_at = create_at;
	}

	public int getStar_num() {
		return star_num;
	}
	public void setStar_num(int star_num) {
		this.star_num = star_num;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	

	public String getPerform_detail_id() {
		return perform_detail_id;
	}


	public void setPerform_detail_id(String perform_detail_id) {
		this.perform_detail_id = perform_detail_id;
	}


	public int getRepot_state() {
		return repot_state;
	}
	public void setRepot_state(int repot_state) {
		this.repot_state = repot_state;
	}	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	

	
}
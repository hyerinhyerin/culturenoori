package dto;

public class UserDTO {
	
	// 테이블 필드명을 정의해서 여기저기 사용 한다.
	public static final String EMAIL = "email";
	public static final String PW = "password";
	public static final String NICK = "nickname";
	public static final String IMG = "img_path";

	private String email;		
	private String password;
	private String nickname;
	private String img_path;
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	@Override
	public String toString() {
		return "UserDTO [email=" + email + ", password=" + password + ", nickname=" + nickname + ", img_path="
				+ img_path + "]";
	}
	
	
	
}

package dto;

public class BoardLikeDTO {
	public static final String BOARDID="board_id";
	public static final String USEREMAIL="user_email";
	
	private int board_id;
	private String user_email;
	
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	
	@Override
	public String toString() {
		return "BoardLikeDTO [board_id=" + board_id + ", user_email=" + user_email + "]";
	}
	
	
}

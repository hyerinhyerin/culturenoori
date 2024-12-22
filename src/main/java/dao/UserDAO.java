package dao;

import org.json.JSONObject;

import common.JDBConnect;
import common.LoginManager;
import dto.UserDTO;

public class UserDAO extends JDBConnect {

	public Object[] checkAccount(String account) {
		
		UserDTO user = null;
		JSONObject resultJson = new JSONObject();
		
		boolean isEmail = LoginManager.isEmail(account);
		if(isEmail){
			resultJson.put("type", UserDTO.EMAIL);
	    }else{
	    	resultJson.put("type", UserDTO.NICK);
	    }
		
	    try {
	        String sql = "SELECT * FROM user WHERE %s = ?";
	        
	        if(isEmail){
	        	sql = String.format(sql, UserDTO.EMAIL);
	        }else{
	        	sql = String.format(sql, UserDTO.NICK);
	        }

	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setString(1, account);
	    	rs = pstmt.executeQuery();

			if(rs.next()){
				user = new UserDTO();
				
				user.setNickname(rs.getString(UserDTO.NICK));
				user.setPassword(rs.getString(UserDTO.PW));
				user.setEmail(rs.getString(UserDTO.EMAIL));
				user.setImg_path(rs.getString(UserDTO.IMG));
				
				resultJson.put("result", "already");
				System.out.println("UserDAO checkAccount already.!!");
			}else{
				resultJson.put("result", "possible");
				System.out.println("UserDAO checkAccount possible.!!");
			}
				        
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO checkAccount Exception : " + e.toString());
	    }

	    return new Object[] { resultJson, user };
	}
	
	public int insertUser(UserDTO user) {
	   try {
	        String sql = "INSERT INTO user (%s, %s, %s) VALUES (?, ?, ?)";
	        sql = String.format(sql, UserDTO.NICK, UserDTO.EMAIL, UserDTO.PW);
	        
	        pstmt = conn.prepareStatement(sql);
	        
	        pstmt.setString(1, user.getNickname());
	        pstmt.setString(2, user.getEmail());
	        pstmt.setString(3, user.getPassword());
	        
	        int result = pstmt.executeUpdate();
	        
	        System.out.println("UserDAO insertUser result : " + result);

	        return 1;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO insertUser Exception : " + e.toString());
	    }
	   
	   return 0;
	}
	
	//로그인 > 계정찾기 > 비밀번호 변경
	public boolean changePassword(String account, String newPassword) {
	    boolean updateSuccess = false;
	    JSONObject resultJson = new JSONObject();
	    
	    boolean isEmail = LoginManager.isEmail(account);  // 입력된 값이 이메일인지 닉네임인지 확인
	    String sql = "UPDATE user SET password = ? WHERE %s = ?";
	    
	    try {
            // SQL 쿼리에서 이메일 또는 닉네임을 기반으로 설정
            if (isEmail) {
                sql = String.format(sql, UserDTO.EMAIL);
            } else {
                sql = String.format(sql, UserDTO.NICK);
            }
            
            // 비밀번호 업데이트 실행
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newPassword);
            pstmt.setString(2, account);
            
            int result = pstmt.executeUpdate();  // 업데이트된 행의 수를 확인
            
            if (result > 0) {
                updateSuccess = true;
                resultJson.put("result", "password_changed");
                System.out.println("UserDAO changePassword success.!!");
            } else {
                resultJson.put("result", "failed_to_change_password");
                System.out.println("UserDAO changePassword failed.!!");
            }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO changePassword Exception : " + e.toString());
	    }
	    
	    return updateSuccess;
	}
	
	public UserDTO getUserByEmail(String email) {
		UserDTO user = new UserDTO();
		String sql = "SELECT * FROM user WHERE email = ?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				user.setEmail(rs.getString("email"));
				user.setImg_path(rs.getString("img_path"));
				user.setNickname(rs.getString("nickname"));
				user.setPassword(rs.getString("password"));
			}
		}catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO getUserByEmail Exception : " + e.toString());
	    }
		return user;
	}

	public String findEmailByNickname(String nickname) {
	    String email = null;
	    
	    try {
	        // SQL 쿼리 작성
	        String sql = "SELECT email FROM user WHERE nickname = ?";
	        
	        // PreparedStatement 생성 및 값 설정
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, nickname);
	        
	        // SQL 실행 및 결과 처리
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            // 이메일을 결과에서 가져오기
	            email = rs.getString("email");
	            System.out.println("UserDAO findEmailByNickname success.!!");
	        } else {
	            System.out.println("UserDAO findEmailByNickname: No email found for this nickname.!!");
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO findEmailByNickname Exception : " + e.toString());
	    } 
	    
	    return email;
	}

	public String findNicknameByEmail(String email) {
	    String nickname = null;

	    try {
	        String sql = "SELECT nickname FROM user WHERE email = ?";

	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, email);

	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            nickname = rs.getString("nickname");
	            System.out.println("UserDAO findNicknameByEmail success. Nickname: " + nickname);
	        } else {
	            System.out.println("UserDAO findNicknameByEmail: No nickname found for this email.");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO findNicknameByEmail Exception: " + e.toString());
	    } 

	    return nickname;
	}
	
	public boolean updateUser(UserDTO user) {
		String sql = "UPDATE user SET nickname=?, password=?, img_path=? WHERE email=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, user.getNickname());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getImg_path());
			pstmt.setString(4, user.getEmail());
			
			int result = pstmt.executeUpdate();
			
			System.out.println("UserDAO updateUser success.");
			return result > 0;
		} catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO updateUser Exception: " + e.toString());
	    }
		return false;
	}
	
	public boolean checkNick(String nickname) {
		String sql = "SELECT COUNT(*) FROM user WHERE nickname=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1) > 0;
			}
		}catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO checkNick Exception: " + e.toString());
	    }
		return false;
	}

	public boolean deleteUserByEmail(String email) {
		String sql = "DELETE FROM user WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1 , email);
			int result = pstmt.executeUpdate();
			
			return result > 0;
		}catch (Exception e) {
	        e.printStackTrace();
	        System.out.println("UserDAO deleteUserByEmail Exception: " + e.toString());
	    }
		return false;
	}
}

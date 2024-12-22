package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import dto.NoticeDTO;

public class NoticeDAO extends JDBConnect{
	public int insertNotice(NoticeDTO notice) {
		String sql = "INSERT INTO notice (title, contents, date, priority) VALUES (?, ?, ?, ?)";
		int result = 0;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getContents());
			pstmt.setTimestamp(3, new java.sql.Timestamp(notice.getDate().getTime()));
			pstmt.setInt(4, notice.getPriority());
			
			result = pstmt.executeUpdate();
			System.out.println("NoticeDAO insertNotice success");

		}catch(SQLException e) {
			System.out.println("NoticeDAO insertNotice exception: "+e.toString());
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean updateNotice(NoticeDTO notice) {
        String sql = "UPDATE notice SET title = ?, contents = ?, date = ?, priority = ? WHERE id = ?";
        boolean result = false;

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, notice.getTitle());
            pstmt.setString(2, notice.getContents());
			pstmt.setTimestamp(3, new java.sql.Timestamp(notice.getDate().getTime()));
            pstmt.setInt(4, notice.getPriority());
            pstmt.setInt(5, notice.getId()); 

            int rowsUpdated = pstmt.executeUpdate();
			System.out.println("NoticeDAO updateNotice success");
            result = rowsUpdated > 0;  // 수정된 행 수가 1 이상이면 true
        } catch (SQLException e) {
			System.out.println("NoticeDAO updateNotice exception: "+e.toString());
            e.printStackTrace();
        }

        return result;
    }
	
	public boolean deleteNotice(int noticeId) {
        boolean result = false;
        String sql = "DELETE FROM notice WHERE id = ?"; // 공지사항 ID에 해당하는 레코드 삭제

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, noticeId);
            int rows = pstmt.executeUpdate();
            
            // 삭제 성공 시 true 반환
            if (rows > 0) {
                result = true;
            }
			System.out.println("NoticeDAO deleteNotice success");

        } catch (SQLException e) {
			System.out.println("NoticeDAO deleteNotice exception: "+e.toString());
            e.printStackTrace();
        }

        return result;
    }
	
	public NoticeDTO getNoticeById(int noticeId) {
        NoticeDTO notice = null;
        String sql = "SELECT * FROM notice WHERE id = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, noticeId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                notice = new NoticeDTO();
                notice.setId(rs.getInt("id"));
                notice.setTitle(rs.getString("title"));
                notice.setContents(rs.getString("contents"));
                notice.setDate(new Date(rs.getTimestamp("date").getTime()));
                notice.setPriority(rs.getInt("priority"));
            }
			System.out.println("NoticeDAO getNoticeById success");

        } catch (SQLException e) {
			System.out.println("NoticeDAO getNoticeById exception: "+e.toString());
            e.printStackTrace();
        }
        return notice;
    }
	
	public List<NoticeDTO> getTop3Notice(){
		List<NoticeDTO> notices = new ArrayList<NoticeDTO>();
		String sql = "SELECT * FROM notice ORDER BY priority ASC, date DESC LIMIT 3";
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice = new NoticeDTO();
                notice.setId(rs.getInt("id"));
                notice.setTitle(rs.getString("title"));
                notice.setContents(rs.getString("contents"));
                notice.setDate(new Date(rs.getTimestamp("date").getTime()));
                notice.setPriority(rs.getInt("priority"));
                notices.add(notice);
			}
			System.out.println("NoticeDAO getTop3Notice success");
		}catch(SQLException e) {
			System.out.println("NoticeDAO getTop3Notice exception: "+e.toString());
            e.printStackTrace();
		}
		return notices;
	}
}

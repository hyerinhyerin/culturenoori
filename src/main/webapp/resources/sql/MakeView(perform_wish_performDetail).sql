CREATE VIEW vw_user_wishlist AS
SELECT 
    u.email,               -- 사용자의 이메일
    p.perform_detail_id,         -- 공연의 세부 ID
    p.name,                      -- 공연명
    p.start,                     -- 공연 시작일
    p.end,                       -- 공연 종료일
    p.state,
    p.img_path,                   -- 공연 이미지 경로
    pd.venue_name
FROM 
    wish w
JOIN 
    user u ON w.user_email = u.email
JOIN 
    perform p ON w.perform_detail_id = p.perform_detail_id
JOIN 
	perform_detail pd ON w.Perform_Detail_id = pd.id;
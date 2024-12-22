package dto;

import org.json.JSONObject;

public class TheaterDTO {
	
	// 테이블 필드명을 정의해서 여기저기 사용 한다.
	public static final String ID = "id";
	public static final String ADDRESS = "address";
	public static final String TOTAL_SEATS = "total_seats";
	public static final String VENUE_NAME = "venue_name";
	
	private String id;			// 공연장ID
	private String address;		// 주소
	private int total_seats;	// 좌석수
	private String venue_name;		// 주소

	public JSONObject toJSONObject() {
        JSONObject jsonObject = new JSONObject();
        
        jsonObject.put(ID, this.id);
        jsonObject.put(ADDRESS, this.address);
        jsonObject.put(TOTAL_SEATS, this.total_seats);
        jsonObject.put(VENUE_NAME, this.venue_name);
        
        return jsonObject;
    }
	
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getTotal_seats() {
		return total_seats;
	}
	public void setTotal_seats(int total_seats) {
		this.total_seats = total_seats;
	}

	public String getVenue_name() {
		return venue_name;
	}

	public void setVenue_name(String venue_name) {
		this.venue_name = venue_name;
	}

	@Override
	public String toString() {
		return "TheaterDTO [id=" + id + ", address=" + address + ", total_seats=" + total_seats + ", venue_name="
				+ venue_name + "]";
	}

	
}

package dto;

import org.json.JSONArray;
import org.json.JSONObject;

public class PerformDetailDTO {
	
	// 테이블 필드명을 정의해서 여기저기 사용 한다.
	public static final String ID 			= "id";
	public static final String AVG_RATE 	= "average_rate";
	public static final String PRICE 		= "price";
	public static final String CAST 		= "cast";
	public static final String THEATER_ID 	= "Theater_id";
	public static final String IMG_PATH 	= "img_path";
	public static final String RUNTIME 		= "runtime";
	public static final String VENUE_NAME 	= "venue_name";
	public static final String RESERV_LINK 	= "reservation_link";
	
	private String id;				// 공연 디테일 ID
	private float average_rate;		// 평균 별점	
	private String price;			// 가격 <- DB도 자료형 변경 필요	
	private String cast;			// 출연진	
	private String Theater_id;		// 공연장 ID
	private String img_path;		// 소계 이미지 배열이여서 Json 형식으로 넣을 것
	private String runtime;			// 공연시간
	private String venue_name;		// 공연장(장소명)
	private String reservation_link;// 예매 링크
	
    public JSONObject toJSONObject() {
        JSONObject jsonObject = new JSONObject();
        
        jsonObject.put(ID , this.id);
        jsonObject.put(AVG_RATE, this.average_rate);
        jsonObject.put(PRICE, this.price);

        jsonObject.put(CAST, this.cast);
        jsonObject.put(THEATER_ID, this.Theater_id);
        jsonObject.put(IMG_PATH, this.img_path);

//	    // img_path를 JSONArray로 변환하여 추가
//	    JSONArray imgPathArray = new JSONArray(this.img_path);
//	    jsonObject.put(IMG_PATH, imgPathArray);

        jsonObject.put(RUNTIME, this.runtime);
        jsonObject.put(VENUE_NAME, this.venue_name);
        jsonObject.put(RESERV_LINK, this.reservation_link);
        
        return jsonObject;
    }
    
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public float getAverage_rate() {
		return average_rate;
	}

	public void setAverage_rate(float average_rate) {
		this.average_rate = average_rate;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getCast() {
		return cast;
	}

	public void setCast(String cast) {
		this.cast = cast;
	}

	public String getTheater_id() {
		return Theater_id;
	}

	public void setTheater_id(String theater_id) {
		Theater_id = theater_id;
	}

	public String getImg_path() {
		return img_path;
	}

	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}

	public String getRuntime() {
		return runtime;
	}

	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}

	public String getVenue_name() {
		return venue_name;
	}

	public void setVenue_name(String venue_name) {
		this.venue_name = venue_name;
	}

	public String getReservation_link() {
		return reservation_link;
	}

	public void setReservation_link(String reservation_link) {
		this.reservation_link = reservation_link;
	}

	@Override
	public String toString() {
		return "PerformDetailDTO [id=" + id + ", average_rate=" + average_rate + ", price=" + price + ", cast=" + cast
				+ ", Theater_id=" + Theater_id + ", img_path=" + img_path + ", runtime=" + runtime + ", venue_name="
				+ venue_name + ", reservation_link=" + reservation_link + "]";
	}

	

	
    

}

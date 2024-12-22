package dto;

import org.json.JSONObject;

public class PerformCardDTO {

	private PerformDTO perform;
	private float average_rate;
	private String venue_name;
	
	public JSONObject toJson() {
		JSONObject json = new JSONObject();
		
		json.put("perform", perform.toJSONObject());
		json.put("average_rate", average_rate);
		json.put("venue_name", venue_name);

		return json;
	}
	
	@Override
	public String toString() {
		return "PerformCardDTO [perform=" + perform.toString() + ", average_rate=" + average_rate + ", venue_name=" + venue_name + "]";
	}
	
	public PerformDTO getPerform() {
		return perform;
	}
	public void setPerform(PerformDTO perform) {
		this.perform = perform;
	}
	public float getAverage_rate() {
		return average_rate;
	}
	public void setAverage_rate(float average_rate) {
		this.average_rate = average_rate;
	}
	public String getVenue_name() {
		return venue_name;
	}
	public void setVenue_name(String venue_name) {
		this.venue_name = venue_name;
	}

	
}

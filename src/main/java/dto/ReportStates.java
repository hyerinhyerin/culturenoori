package dto;

public enum ReportStates {
	PASS("pass"),
	BLIND("blind");
	
	private final String value;
	
	ReportStates(String value){
		this.value = value;
	}
	public String getValue() {
		return value;
	}
	public static ReportStates fromValue(String value) {
		for(ReportStates type : ReportStates.values()) {
			if(type.value.equals(value)) {
				return type;
			}
		}
		throw new IllegalArgumentException("Unknown enum type " + value);
	}
}

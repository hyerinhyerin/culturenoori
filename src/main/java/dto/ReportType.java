package dto;

public enum ReportType {
  BOARD("board"),
  COMMENT("comment"),
  REPLY("reply"),
  REVIEW("review");

  private final String value;

  ReportType(String value) {
    this.value = value;
  }

  public String getValue() {
    return value;
  }

  public static ReportType fromValue(String value) {
    for (ReportType type : ReportType.values()) {
      if (type.value.equals(value)) {
        return type;
      }
    }
    throw new IllegalArgumentException("Unknown enum type " + value);
  }
}

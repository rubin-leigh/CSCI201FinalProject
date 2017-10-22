package JSONParsingClasses;

public class Date {
	private String week;
	private String day;
	private String month;
	private String year;
	public Date(String week, String day, String month, String year) {
		this.week = week;
		this.day = day;
		this.month = month;
		this.year = year;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	
}

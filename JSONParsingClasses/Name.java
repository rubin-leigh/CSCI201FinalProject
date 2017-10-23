package JSONParsingClasses;

public class Name {
	private String fname;
	private String lname;
	public Name(String fname_, String lname_) {
		fname = fname_;
		lname = lname_;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	
}

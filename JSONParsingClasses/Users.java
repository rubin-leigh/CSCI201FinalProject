package JSONParsingClasses;

public class Users {
	private String type;
	private String username;
	private String password;
	private String email;
	private Name name;
	private Boolean verified;
	public Users(String type_, String username_, String password_, String email_, Name name_, Boolean verified_) {
		type  = type_;
		username = username_;
		password = password_;
		email = email_;
		name = name_;
		verified = verified_;
	}
	public String getType() {
		return type;
	}
	public String getUsername() {
		return username;
	}
	public String getPassword() {
		return password;
	}
	public String getEmail() {
		return email;
	}
	public Name getName() {
		return name;
	}
	public Boolean getVerified() {
		return verified;
	}
	public void setType(String type) {
		this.type = type;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setName(Name name) {
		this.name = name;
	}
	public void setVerified(Boolean verified) {
		this.verified = verified;
	}
	
	
}

	
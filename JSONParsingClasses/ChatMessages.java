package JSONParsingClasses;

public class ChatMessages {
	private String sender;
	private String message;
	private String timestamp;
	public ChatMessages(String sender, String message, String timestamp) {
		this.sender = sender;
		this.message = message;
		this.timestamp = timestamp;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	
	
}

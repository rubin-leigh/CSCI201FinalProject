package JSONParsingClasses;

import java.util.ArrayList;

public class Events {
	private String type;
	private String title;
	private Date date;
	private Time time;
	private String location;
	private String img;
	private String contact;
	private String host;
	private String description;
	private Integer participantsCap;
	private ArrayList<Participants> participants;
	public Events(String type, String title, Date date,Time time, String location, String img, String contact, String host, String description, Integer participantsCap,Participants participants) {
		this.type = type;
		this.title = title;
		this.date = date;
		this.time = time;
		this.location = location;
		this.img = img;
		this.contact = contact;
		this.host = host;
		this.description = description;
		this.participantsCap = participantsCap;
		this.participants.add(participants);
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getParticipantsCap() {
		return participantsCap;
	}
	public void setParticipantsCap(Integer participantsCap) {
		this.participantsCap = participantsCap;
	}
	public ArrayList<Participants> getParticipants() {
		return participants;
	}
	public void setParticipants(ArrayList<Participants> participants) {
		this.participants = participants;
	}
	
	
}

package test;

import java.io.IOException;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
//import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;

import net.thegreshams.firebase4j.demo.Demo;
import net.thegreshams.firebase4j.error.FirebaseException;
import net.thegreshams.firebase4j.error.JacksonUtilityException;

@Path("/test")
public class Test {
	private Demo demo = new Demo();
	
//	@GET
//	@Produces(MediaType.TEXT_XML)
//	public String sayHelloXML() {
//		String response = "<hello>Hello XML</hello>";
//		return response;
//	}
//	
//	@GET
//	@Produces(MediaType.TEXT_HTML)
//	public String sayHelloHTML() {
//		String response = "<h1>Hello HTML</h1>";
//		return response;
//	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String sayHelloJSON() throws JsonParseException, JsonMappingException, IOException, FirebaseException, JacksonUtilityException {
	//	String response = "{\r\n\"Users\": [{\r\n\"type\": \"1\",       \r\n\"username\": \"" + username + "\",\r\n\"password\": \"TommyTrojan\",\r\n\"email\": \"tommy@usc.edu\",\r\n\"name\": [{\r\n  \"fname\": \"Edwin\",\r\n  \"lname\": \"Chan\"\r\n}],\r\n\"verified\": \"true\"\r\n}],\r\n\"Events\": [{\r\n\"type\": \"sports\",   \r\n\"title\": \"This is a test Event!! Have fun!!\",\r\n\"date\": {\r\n\"week\": \"Thursday\",\r\n\"day\": \"12\",\r\n\"month\": \"May\",\r\n\"year\": \"2017\" \r\n},\r\n\"time\": {\r\n\"start\":\"12:30p.m.\",\r\n\"end\": \"1:30p.m.\"\r\n},\r\n\"location\": \"" + location + "\",\r\n\"img\": \"httplink\",\r\n\"Contact\": \"phone number\",\r\n\"host\": \"ClubName(from the acc)\",\r\n\"description\": \"blah blah blah\",\r\n\"chatboxLocation\": \"possibleChatboxinfo\",\r\n\"participantsCap\" : \"100\",\r\n\"participants\":[{\r\n  \"userID\":\"1\"\r\n}]\r\n\r\n  }],\r\n  \"ChatMessages\":[{\r\n    \"sender\": \"name\",\r\n    \"message\" : \"MESSAGE!!!\",\r\n    \"timestamp\": \"10-19-2017 10:29:00 a.m.\"\r\n  }]\r\n}";
		
		return demo.abc();
		
	}

}

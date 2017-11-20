package net.thegreshams.firebase4j.demo;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import net.thegreshams.firebase4j.error.FirebaseException;
import net.thegreshams.firebase4j.error.JacksonUtilityException;
import net.thegreshams.firebase4j.model.FirebaseResponse;
import net.thegreshams.firebase4j.service.Firebase;

import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;

public class Demo {
	//public String abc() {
	//	return "{\r\n\"Users\": [{\r\n\"type\": \"1\",       \r\n\"username\": \"" + "\",\r\n\"password\": \"TommyTrojan\",\r\n\"email\": \"tommy@usc.edu\",\r\n\"name\": [{\r\n  \"fname\": \"Edwin\",\r\n  \"lname\": \"Chan\"\r\n}],\r\n\"verified\": \"true\"\r\n}],\r\n\"Events\": [{\r\n\"type\": \"sports\",   \r\n\"title\": \"This is a test Event!! Have fun!!\",\r\n\"date\": {\r\n\"week\": \"Thursday\",\r\n\"day\": \"12\",\r\n\"month\": \"May\",\r\n\"year\": \"2017\" \r\n},\r\n\"time\": {\r\n\"start\":\"12:30p.m.\",\r\n\"end\": \"1:30p.m.\"\r\n},\r\n\"location\": \""  + "\",\r\n\"img\": \"httplink\",\r\n\"Contact\": \"phone number\",\r\n\"host\": \"ClubName(from the acc)\",\r\n\"description\": \"blah blah blah\",\r\n\"chatboxLocation\": \"possibleChatboxinfo\",\r\n\"participantsCap\" : \"100\",\r\n\"participants\":[{\r\n  \"userID\":\"1\"\r\n}]\r\n\r\n  }],\r\n  \"ChatMessages\":[{\r\n    \"sender\": \"name\",\r\n    \"message\" : \"MESSAGE!!!\",\r\n    \"timestamp\": \"10-19-2017 10:29:00 a.m.\"\r\n  }]\r\n}";
	//}


	public String abc() throws FirebaseException, JsonParseException, JsonMappingException, IOException, JacksonUtilityException {

		FirebaseResponse response = null;
		// get the base-url (ie: 'http://gamma.firebase.com/username')
		String firebase_baseUrl = "https://csci-201finalproject.firebaseio.com/";
		
		if( firebase_baseUrl == null || firebase_baseUrl.trim().isEmpty() ) {
			throw new IllegalArgumentException( "Program-argument 'baseUrl' not found but required" );
		}

		
		// create the firebase
		Firebase firebase = new Firebase( firebase_baseUrl );
		
		
		// "DELETE" (the fb4jDemo-root)
	//	FirebaseResponse response = firebase.delete();
	

		// "PUT" (test-map into the fb4jDemo-root)
	//	Map<String, Object> dataMap = new LinkedHashMap<String, Object>();
	//	dataMap.put( "PUT-root", "This was PUT into the fb4jDemo-root" );
	//	response = firebase.put( dataMap );
	//	System.out.println( "\n\nResult of PUT (for the test-PUT to fb4jDemo-root):\n" + response );
	//	System.out.println("\n");
		
		
		// "GET" (the fb4jDemo-root)
		String str = firebase.get().toString();
	//	response = firebase.get();
	//	System.out.println( "\n\nResult of GET:\n" + response );
	//	System.out.println("\n");
		
		
		
		
		// "PUT" (test-map into a sub-node off of the fb4jDemo-root)
//		dataMap = new LinkedHashMap<String, Object>();
//		dataMap.put( "Key_1", "This is the first value" );
//		dataMap.put( "Key_2", "This is value #2" );
//		Map<String, Object> dataMap2 = new LinkedHashMap<String, Object>();
//		dataMap2.put( "Sub-Key1", "This is the first sub-value" );
//		dataMap.put( "Key_3", dataMap2 );
//		response = firebase.put( "test-PUT", dataMap );
//		System.out.println( "\n\nResult of PUT (for the test-PUT):\n" + response );
//		System.out.println("\n");
		
		
		// "GET" (the test-PUT)
//		response = firebase.get( "test-PUT" );
//		System.out.println( "\n\nResult of GET (for the test-PUT):\n" + response );
//		System.out.println("\n");
//		System.out.println("AYYYYY: " + response);
//		
//		
//		// "POST" (test-map into a sub-node off of the fb4jDemo-root)
//		response = firebase.post( "test-POST", dataMap );
//		System.out.println( "\n\nResult of POST (for the test-POST):\n" + response );
//		System.out.println("\n");
		
		
		// "DELETE" (it's own test-node)
//		dataMap = new LinkedHashMap<String, Object>();
//		dataMap.put( "DELETE", "This should not appear; should have been DELETED" );
//		response = firebase.put( "test-DELETE", dataMap );
//		System.out.println( "\n\nResult of PUT (for the test-DELETE):\n" + response );
//		response = firebase.delete( "test-DELETE");
//		System.out.println( "\n\nResult of DELETE (for the test-DELETE):\n" + response );
//		response = firebase.get( "test-DELETE" );
//		System.out.println( "\n\nResult of GET (for the test-DELETE):\n" + response );
		return str;
	}
	
}





/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.me.directions;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import javax.jws.*;
import javax.ejb.Stateless;
import javax.json.*;

/**
 *
 * @author saura
 */
@WebService(serviceName = "DirectionsWS")
@Stateless()
public class DirectionsWS {

    /**
     * Web service operation
     */
    @WebMethod(operationName = "drivingDirections")
    public List<String> drivingDirections(@WebParam(name = "source") String source, @WebParam(name = "destination") String destination) throws MalformedURLException, IOException {
        //TODO write your implementation code here:

        List<String> directions = new ArrayList<>();
        String apiURL = "https://maps.googleapis.com/maps/api/directions/json?origin=" + source + "&destination=" 
                + destination + "&avoid=tolls&key=<insert-key-here>";

        URL url = new URL(apiURL);
        HttpURLConnection httpUrlConnect = (HttpURLConnection) url.openConnection();
        httpUrlConnect.setRequestMethod("GET");

        InputStream iStream = httpUrlConnect.getInputStream();
        BufferedReader bReader = new BufferedReader(new InputStreamReader(iStream, StandardCharsets.UTF_8));
        
        // BufferedReader bReader2 = new BufferedReader(new FileReader("C:\\Users\\saura\\Documents\\NetBeansProjects\\Directions\\Directions.json"));

        JsonObject jObject;
        try (JsonReader jReader = Json.createReader(bReader)) {
            jObject = jReader.readObject();
        }

        JsonArray jArray1 = jObject.getJsonArray("routes").getJsonObject(0).getJsonArray("legs");

        for (int i = 0; i < jArray1.size(); i++) {
            directions.add("<div class=\"alert alert-info\" role=\"alert\"><h5>Journey from " + jArray1.getJsonObject(i).getJsonString("start_address").getString()
                    + " to " + jArray1.getJsonObject(i).getJsonString("end_address").getString()
                    + " is " + jArray1.getJsonObject(i).getJsonObject("distance").getJsonString("text").getString()
                    + " long and will take " + jArray1.getJsonObject(i).getJsonObject("duration").getJsonString("text").getString()
                    + ".</h5></div><h5>Driving Directions by Car:</h5>");
        }

        JsonArray jArray2 = jObject.getJsonArray("routes").getJsonObject(0).getJsonArray("legs").getJsonObject(0).getJsonArray("steps");

        for (int i = 0; i < jArray2.size(); i++) {
            directions.add(jArray2.getJsonObject(i).getJsonObject("distance").getJsonString("text").getString() + " - "
                    + jArray2.getJsonObject(i).getJsonString("html_instructions").getString());
        }

        return directions;
    }
}

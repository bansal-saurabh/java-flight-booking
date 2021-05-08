<%-- 
    Document   : destination_details
    Created on : 18 Mar, 2019, 10:33:45 AM
    Author     : Saurabh Bansal
--%>

<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.util.List"%>
<%@page import="javax.json.*"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <title>Destination Details</title>
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="index.jsp">Flight Booking System</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="navbar-nav">
                    <a class="nav-item nav-link active" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                    <a class="nav-item nav-link" href="all_flights.jsp">All Flights</a>
                </div>
            </div>
        </nav>

        <div class="container-fluid">

            <br/>

            <%! String detailsCity, attractionType;%>

            <%
                detailsCity = request.getParameter("City");
            %>


            <%
                String apiURL1 = "http://api.geonames.org/searchJSON?q=" + detailsCity + "&maxRows=1&style=LONG&username=saurabh9107";

                URL url1 = new URL(apiURL1);
                HttpURLConnection httpUrlConnect1 = (HttpURLConnection) url1.openConnection();
                httpUrlConnect1.setRequestMethod("GET");

                InputStream iStream1 = httpUrlConnect1.getInputStream();
                BufferedReader bReader1 = new BufferedReader(new InputStreamReader(iStream1));

                // BufferedReader bReader1 = new BufferedReader(new FileReader("C:\\Users\\saura\\Downloads\\Edinburgh2.json"));
                JsonObject jObject1;
                JsonReader jReader1 = Json.createReader(bReader1);
                jObject1 = jReader1.readObject();

                JsonArray jArray1 = jObject1.getJsonArray("geonames");
                int cityPopulation = jArray1.getJsonObject(0).getInt("population");
                String regionName = jArray1.getJsonObject(0).getJsonString("adminName1").getString();
                String countryName = jArray1.getJsonObject(0).getJsonString("countryName").getString();
                String countryCode = jArray1.getJsonObject(0).getJsonString("countryCode").getString();
                String latitude = jArray1.getJsonObject(0).getJsonString("lat").getString();
                String longitude = jArray1.getJsonObject(0).getJsonString("lng").getString();

            %>

            <div class="card text-white bg-info mb-3">
                <h5 class="card-header">Facts about <%= detailsCity%></h5>
                <div class="card-body">
                    <p class="card-text"><b>Population:</b> <%= cityPopulation%></p>
                    <p class="card-text"><b>Region:</b> <%= regionName%></p>
                    <p class="card-text"><b>Country: </b> <%= countryName%></p>
                    <p class="card-text"><b>Latitude:</b> <%= latitude%></p>
                    <p class="card-text"><b>Longitude:</b> <%= longitude%></p>
                </div>
            </div>

            <div class="card bg-light mb-3">
                <h5 class="card-header">List of attractions</h5>
                <div class="card-body">                        
                    <table class="table table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">No.</th>
                                <th scope="col">Name</th>
                                <th scope="col">Image</th>
                                <th scope="col">Type</th>
                                <th scope="col">Description</th>
                            </tr>
                        </thead>

                        <tbody>

                            <%

                                String apiURL2 = "http://api.geonames.org/wikipediaSearchJSON?q="
                                        + detailsCity + "&country=" + countryCode + "&maxRows=10&username=saurabh9107";

                                URL url2 = new URL(apiURL2);
                                HttpURLConnection httpUrlConnect2 = (HttpURLConnection) url2.openConnection();
                                httpUrlConnect2.setRequestMethod("GET");

                                InputStream iStream2 = httpUrlConnect2.getInputStream();
                                BufferedReader bReader2 = new BufferedReader(new InputStreamReader(iStream2));

                                // BufferedReader bReader2 = new BufferedReader(new FileReader("C:\\Users\\saura\\Downloads\\Nearby.json"));
                                JsonObject jObject2;
                                JsonReader jReader2 = Json.createReader(bReader2);
                                jObject2 = jReader2.readObject();

                                JsonArray jArray2 = jObject2.getJsonArray("geonames");

                                for (int i = 0; i < jArray2.size(); i++) {

                                    String attractionName = jArray2.getJsonObject(i).getJsonString("title").getString();
                                    String attractionImage = jArray2.getJsonObject(i).getJsonString("thumbnailImg").getString();
                                    String attractionURL = jArray2.getJsonObject(i).getJsonString("wikipediaUrl").getString();
                                    if (jArray2.getJsonObject(i).containsKey("feature")) {
                                        attractionType = jArray2.getJsonObject(i).getJsonString("feature").getString().toUpperCase();
                                    } else {
                                        attractionType = "NOT AVAILABLE";

                                    }

                                    String attractionDescription = jArray2.getJsonObject(i).getJsonString("summary").getString();
                                    String attractionDescription2 = attractionDescription.replace(" (...)", ".");

                                    out.print("<tr>");
                                    out.print("<th scope=\"row\">" + (i + 1) + ".</th>");
                                    out.print("<td>" + attractionName + "</td>");
                                    out.print("<td>" + "<a href=\"http://" + attractionURL + "\" target=\"_blank\">" + "<img src=" + "\"" + attractionImage + "\">" + "</td>");
                                    out.print("<td>" + attractionType + "</td>");
                                    out.print("<td>" + attractionDescription2 + "</td>");

                                }

                            %>

                            </tr>

                        </tbody>
                    </table>

                </div>
            </div>

            <div class="card bg-light mb-3" style="max-width: 60rem;">
                <h5 class="card-header"><%= detailsCity%> Photo Gallery </h5>
                <div class="card-body"> 


                    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">

                            <%

                                String apiURL3 = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=<insert-key-here>"
                                        + "&text=" + detailsCity + "&sort=relevance&privacy_filter=1&safe_search=1&content_type=1&per_page=40"
                                        + "&format=json&nojsoncallback=1";

                                URL url3 = new URL(apiURL3);
                                HttpURLConnection httpUrlConnect3 = (HttpURLConnection) url3.openConnection();
                                httpUrlConnect3.setRequestMethod("GET");

                                InputStream iStream3 = httpUrlConnect3.getInputStream();
                                BufferedReader bReader3 = new BufferedReader(new InputStreamReader(iStream3));

                                // BufferedReader bReader3 = new BufferedReader(new FileReader("C:\\Users\\saura\\Downloads\\Flickr.json"));
                                JsonObject jObject3;
                                JsonReader jReader3 = Json.createReader(bReader3);
                                jObject3 = jReader3.readObject();

                                JsonArray jArray3 = jObject3.getJsonObject("photos").getJsonArray("photo");

                                for (int i = 0; i < jArray3.size(); i++) {

                                    String photoID = jArray3.getJsonObject(i).getJsonString("id").getString();
                                    String photoOwner = jArray3.getJsonObject(i).getJsonString("owner").getString();
                                    String photoSecret = jArray3.getJsonObject(i).getJsonString("secret").getString();
                                    String photoServer = jArray3.getJsonObject(i).getJsonString("server").getString();

                                    if (i == 0) {

                            %>                                                                                
                            <div class="carousel-item active">
                                <img src="https://farm5.staticflickr.com/<%= photoServer%>/<%= photoID%>_<%= photoSecret%>_z.jpg" class="d-block w-100">
                            </div>                                        
                            <%
                            } else {

                            %>
                            <div class="carousel-item">
                                <img src="https://farm5.staticflickr.com/<%= photoServer%>/<%= photoID%>_<%= photoSecret%>_z.jpg" class="d-block w-100">
                            </div>
                            <%
                                    }
                                }
                            %> 
                        </div>
                        <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>

                </div>
            </div>

        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </body>
</html>

<%-- 
    Document   : all_flights
    Created on : 20 Mar, 2019, 8:46:25 PM
    Author     : Saurabh Bansal
--%>

<%@page import="org.netbeans.xml.schema.offers.OfferDetails"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <title>All Flights</title>
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

            <%! String originCity, originAirport, destinationCity, destinationAirport, airline, date, fareString, source, currency; %> 
            <%! String flightType, originAirportCountry, destinationAirportCountry; %> 
            <%! int availableSeats, noOfConnections, flightID, flightID2; %>
            <%! double fareValue;%>

            <br/>

            <%
                try {
                    org.me.flightbooking.FlightBookingWS_Service service = new org.me.flightbooking.FlightBookingWS_Service();
                    org.me.flightbooking.FlightBookingWS port = service.getFlightBookingWSPort();
                    // TODO process result here
                    List<OfferDetails> result = port.allOffers();

                    if (result.size() != 0) {

            %>

            <div class="alert alert-primary" role="alert">
                <h4 class="alert-heading">List of all the flights:</h4>
            </div>

            <table class="table table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Origin City</th>
                        <th scope="col">Destination City</th>
                        <th scope="col">Date</th>
                        <th scope="col">Airlines</th>
                        <th scope="col">Available Seats</th>
                        <th scope="col">Connections</th>
                        <th scope="col">Fare (Per Seat)</th>  
                        <th scope="col">Select Seats</th>
                        <th scope="col">Booking</th>
                        <th scope="col">Directions</th>
                    </tr>
                </thead>  

                <%                            
                    for (OfferDetails results : result) {
                        flightID = results.getID();

                        originCity = results.getOriginCity();
                        originAirport = results.getOriginAirport();
                        String[] originValues = originAirport.split("\\s*,\\s*");
                        originAirportCountry = originValues[2];

                        destinationCity = results.getDestinationCity();
                        destinationAirport = results.getDestinationAirport();
                        String[] destinationValues = destinationAirport.split("\\s*,\\s*");
                        destinationAirportCountry = destinationValues[2];
                        
                        date = results.getDate();

                        airline = results.getAirline();
                        availableSeats = results.getAvailableSeats();
                        noOfConnections = results.getNoOfConnections();

                        fareValue = results.getFare().getValue();
                        fareString = Double.toString(fareValue) + " GBP";

                %>

                <tbody>

                    <%                        
                        out.print("<tr>");
                        out.print("<th scope=\"row\">" + flightID + "</th>");
                        out.print("<td>" + originCity + "<br/><br/><b>Airport:</b> " + originAirport + "</td>");
                        out.print("<td>" + "<a href=\"destination_details.jsp?City=" + destinationCity + "\">" + destinationCity + "</a><br/><br/><b>Airport:</b> " + destinationAirport + "</td>");
                        out.print("<td>" + date + "</td>");
                        out.print("<td>" + airline + "</td>");
                        out.print("<td>" + availableSeats + "</td>");
                        out.print("<td>" + noOfConnections + "</td>");
                        out.print("<td>" + fareString + "</td>");
                    %>

                <form method="POST" action="booking_success.jsp" id="form">

                    <td><input type="hidden" value=<%= flightID%> name="ID" class="flight1">
                        <input type="hidden" value=<%= originCity%> name="Origin" class="flight1">
                        <input type="hidden" value="<%= originAirport%>" name="OriginAirport" class="flight1">
                        <input type="hidden" value=<%= destinationCity%> name="Destination" class="flight1">
                        <input type="hidden" value="<%= destinationAirport%>" name="DestinationAirport" class="flight1">
                        <input type="hidden" value="<%= airline%>" name="Airline" class="flight1">
                        <input type="hidden" value=<%= fareValue%> name="FareValue" class="flight1">
                        <input type="hidden" value=<%= currency%> name="Currency" class="flight1">
                        <input class="form-control" type="number" name="Seats" value=1  min="1" max="<%=availableSeats%>" class="flight1">
                    </td>

                    <td><button type="submit" class="btn btn-primary">Book Flight</button></td>

                </form>

                <form method="POST" action="driving_directions.jsp" id="form">

                    <td><input type="hidden" value=<%= originCity%> name="Origin" class="flight2">
                        <input type="hidden" value=<%= destinationCity%> name="Destination" class="flight2">
                        <% if (originAirportCountry.equalsIgnoreCase(destinationAirportCountry)) { %>
                        <button type="submit" class="btn btn-primary">Drive</button>
                        <%
                            } else {
                                out.print("Not Available");
                            }
                        %>

                    </td>

                </form>

                <%
                        out.print("</tr>");

                    }

                    out.print("</tbody>");
                    out.print("</table>");

                } else {

                %>

                <div class="alert alert-danger" role="alert">
                    <h4 class="alert-heading">No flights found. <a href="index.jsp" class="alert-link">Try again!</a></h4>
                </div>

                <%                    
                    if ((originCity.equalsIgnoreCase("London") & destinationCity.equalsIgnoreCase("Edinburgh"))
                            || (originCity.equalsIgnoreCase("London") & destinationCity.equalsIgnoreCase("Manchester"))
                            || (originCity.equalsIgnoreCase("London") & destinationCity.equalsIgnoreCase("Nottingham"))
                            || (originCity.equalsIgnoreCase("Delhi") & destinationCity.equalsIgnoreCase("Mumbai"))
                            || (originCity.equalsIgnoreCase("Marseille") & destinationCity.equalsIgnoreCase("Paris"))
                            || (originCity.equalsIgnoreCase("Beijing") & destinationCity.equalsIgnoreCase("Shanghai"))
                            || (originCity.equalsIgnoreCase("Osaka") & destinationCity.equalsIgnoreCase("Tokyo"))) {
                %>

                <div class="alert alert-warning" role="alert">
                    <h4 class="alert-heading">You can instead follow the 
                        <a href="driving_directions.jsp?Origin=<%= originCity%>&Destination=<%= destinationCity%>" class="alert-link">
                            driving directions</a> from <%= originCity%> to <%= destinationCity%>.</h4>

                </div>

                <%

                    }

                %>

                <%                        }

                    } catch (Exception ex) {
                        // TODO handle custom exceptions here
                    }
                %>

                <br/>

        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </body>
</html>

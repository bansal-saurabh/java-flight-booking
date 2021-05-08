<%-- 
    Document   : booking_success
    Created on : 16 Mar, 2019, 1:15:09 PM
    Author     : Saurabh Bansal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <title>Flight Booking Status</title>
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

            <%! String originCityValue, destinationCityValue, airline, fare, currency = "GBP"; %>
            <%! String originAirportValue, destinationAirportValue; %> 
            <%! int availableSeats, noOfConnections, flightID, seatsValue;%>
            <%! double fareValue;%>

            <br/>

            <%

                try {

                    flightID = Integer.parseInt(request.getParameter("ID"));
                    originCityValue = request.getParameter("Origin");
                    originAirportValue = request.getParameter("OriginAirport");
                    destinationCityValue = request.getParameter("Destination");
                    destinationAirportValue = request.getParameter("DestinationAirport");
                    airline = request.getParameter("Airline");
                    seatsValue = Integer.parseInt(request.getParameter("Seats"));

                    fareValue = Double.parseDouble(request.getParameter("FareValue"));
                    currency = request.getParameter("Currency");

                } catch (Exception e) {
            %>

            <div class="alert alert-danger" role="alert">
                <h4 class="alert-heading">Unfortunately, an error has occurred! <a href="index.jsp" class="alert-link">Go to homepage.</a></h4>
            </div>

            <%
                    return;
                }

                if (currency.equalsIgnoreCase("Null")) {
                    currency = "GBP";
                }

            %>



            <%-- start web service invocation --%>
            <%                try {
                    org.me.flightbooking.FlightBookingWS_Service service = new org.me.flightbooking.FlightBookingWS_Service();
                    org.me.flightbooking.FlightBookingWS port = service.getFlightBookingWSPort();
                    // TODO initialize WS operation arguments here
                    int id = flightID;
                    String originCity = originCityValue;
                    String destinationCity = destinationCityValue;
                    int seats = seatsValue;
                    // TODO process result here
                    String result = port.bookSeats(id, originCity, destinationCity, seats);

                    if (result.equalsIgnoreCase("Success")) {%>
            <div class="alert alert-success" role="alert">
                <h4 class="alert-heading">Your flight from <b><%= originCityValue%></b> to <b><%= destinationCityValue%></b> has been successfully booked!</h4>
            </div>
            <div class="card text-white bg-info mb-3">
                <h5 class="card-header">Booking Details</h5>
                <div class="card-body">
                    <p class="card-text"><b>Origin:</b> <%= originCityValue + " (Airport: " + originAirportValue + ")"%></p>
                    <p class="card-text"><b>Destination:</b> <%= destinationCityValue + " (Airport: " + destinationAirportValue + ")"%></p>
                    <p class="card-text"><b>Airline: </b> <%= airline%></p>
                    <p class="card-text"><b>Seats Booked:</b> <%= seatsValue%></p>
                    <p class="card-text"><b>Total Cost:</b> <%= fareValue * seatsValue + " " + currency%></p>
                    <a href="index.jsp" class="btn btn-light">Return to Homepage</a>
                    <a href="destination_details.jsp?City=<%= destinationCityValue%>" class="btn btn-warning">Explore <%= destinationCityValue%></a>
                </div>
            </div>
            <% } else { %>
            <div class="alert alert-danger" role="alert">
                <h4 class="alert-heading">Unfortunately, an error has occurred. Booking not successful!</h4>
                <a href="index.jsp" class="btn btn-light">Return to Homepage</a>
            </div>
            <% }

            } catch (Exception ex) {
                // TODO handle custom exceptions here

            %>

            <div class="alert alert-danger" role="alert">
                <h4 class="alert-heading">Unfortunately, an error has occurred! <a href="index.jsp" class="alert-link">Go to homepage.</a></h4>
            </div>

            <%    }
            %>
            <%-- end web service invocation --%>

            <% %>

        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


    </body>
</html>

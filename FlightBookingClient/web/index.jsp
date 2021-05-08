<%-- 
    Document   : index
    Created on : 15 Mar, 2019, 6:51:47 PM
    Author     : Saurabh Bansal
--%>

<%@page import="org.netbeans.xml.schema.offers.OfferDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*, java.lang.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

        <title>Flight Booking System</title>
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


            <%! String originCity, destinationCity, airline, fare; %>  
            <%! int availableSeats, noOfConnections, flightID;%>  

            <br>

            <form method="POST" action="available_offers.jsp">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="SourceSelect">Origin City</label>
                        <select class="form-control" id="src" name="source">
                            <option name="London">London</option>
                            <option name="Marseille">Marseille</option>
                            <option name="Delhi">Delhi</option>                            
                            <option name="Beijing">Beijing</option>
                            <option name="Osaka">Osaka</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="DestinationSelect">Destination City</label>
                        <select class="form-control" id="dst" name="destination">
                            <option name="Edinburgh">Edinburgh</option>
                            <option name="Edinburgh">Nottingham</option>
                            <option name="Edinburgh">Manchester</option>
                            <option name="Paris">Paris</option>
                            <option name="Mumbai">Mumbai</option>
                            <option name="Shanghai">Shanghai</option>
                            <option name="Shanghai">Dubai</option>
                            <option name="Shanghai">Bangkok</option>
                            <option name="Shanghai">Tokyo</option>
                            <option name="Shanghai">Seoul</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="CurrencySelect">Preferred Currency</label>
                        <select class="form-control" id="cur" name="currency">
                            <%-- start web service invocation --%>
                            <%
                                try {
                                    modulewebservices.CurrencyConversionWSService service = new modulewebservices.CurrencyConversionWSService();
                                    modulewebservices.CurrencyConversionWS port = service.getCurrencyConversionWSPort();
                                    // TODO process result here
                                    List<String> codes = port.getCurrencyCodes();

                                    for (String code : codes) {
                                        out.print("<option value=" + code + ">" + code + "</option>");
                                    }

                                } catch (Exception ex) {
                                    // TODO handle custom exceptions here
                                }
                            %>
                            <%-- end web service invocation --%>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <label for="Date">Date</label>
                        <input class="form-control" type="date" name="date" value="2019-03-24">
                    </div>
                </div>
                <div class="form-row">                    
                    <div class="form-group col-md-6">
                        <label for="FlightType">Flight Type</label>
                        <select class="form-control" id="fltyp" name="flighttype">
                            <option name="NonStop">Non-Stop</option>
                            <option name="Connecting">Connecting</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form>

            <br>
            <br>

        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </body>
</html>

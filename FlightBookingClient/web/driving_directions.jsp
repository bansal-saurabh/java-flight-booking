<%-- 
    Document   : driving_directions
    Created on : 16 Mar, 2019, 5:02:15 PM
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

        <title>Driving Directions</title>
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

            <%

                String originCity = request.getParameter("Origin");
                String destinationCity = request.getParameter("Destination");

            %>

            <table class="table table-striped table-bordered">

                <%-- start web service invocation --%>
                <%                    try {
                        org.me.directions.DirectionsWS_Service service = new org.me.directions.DirectionsWS_Service();
                        org.me.directions.DirectionsWS port = service.getDirectionsWSPort();

                        // TODO process result here
                        java.util.List<java.lang.String> result = port.drivingDirections(originCity, destinationCity);

                        String[] path = result.toArray(new String[0]);

                        for (int i = 0; i < path.length; i++) {
                            if (i == 0) {
                                out.print("<thead>");
                                out.print("<tr>");
                                out.print("<th>" + path[i] + "</th>");
                                out.print("</tr>");
                                out.print("</thead>");
                            } else {
                                out.print("<tr>");
                                out.print("<td>" + path[i] + "</td>");
                                out.print("</tr>");
                            }

                        }

                    } catch (Exception ex) {
                        // TODO handle custom exceptions here
                    }
                %>
                <%-- end web service invocation --%>
            </table>

            <div class="alert alert-success" role="alert">
                <h5 class="alert-heading">You have reached your destination!</h5>
            </div>

        </div>

        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </body>
</html>

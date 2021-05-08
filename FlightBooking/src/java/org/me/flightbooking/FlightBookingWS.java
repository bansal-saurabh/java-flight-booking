/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.me.flightbooking;

import flightOrder.*;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.ejb.Stateless;

/**
 *
 * @author saura
 */
@WebService(serviceName = "FlightBookingWS")
@Stateless()
public class FlightBookingWS {

    /**
     * Web service operation
     *
     * @param originCity
     * @param destinationCity
     * @param date
     */
    @WebMethod(operationName = "AvailableOffers")
    public List<OfferDetails> AvailableOffers(@WebParam(name = "originCity") String originCity, @WebParam(name = "destinationCity") String destinationCity,
            @WebParam(name = "date") String date, @WebParam(name = "flighttype") String flightType) {
        //TODO write your implementation code here:

        AvailableFlights availFlights = new AvailableFlights();
        List<OfferDetails> offer_details = null;
        List<OfferDetails> filtered_offer_details = null;

        // OfferDetails offer;
        try {
            javax.xml.bind.JAXBContext jaxbCtx = javax.xml.bind.JAXBContext.newInstance(availFlights.getClass().getPackage().getName());
            javax.xml.bind.Unmarshaller unmarshaller = jaxbCtx.createUnmarshaller();
            availFlights = (AvailableFlights) unmarshaller.unmarshal(new java.io.File("C:\\Users\\saura\\Documents\\NetBeansProjects\\FlightBooking\\Flight_Offers_List.xml")); //NOI18N

            offer_details = availFlights.getFlightDetails();

            if (flightType.equalsIgnoreCase("Non-Stop")) {
                filtered_offer_details = offer_details.stream()
                        .filter(s -> s.getOriginCity().equalsIgnoreCase(originCity))
                        .filter(d -> d.getDestinationCity().equalsIgnoreCase(destinationCity))
                        .filter(dt -> dt.getDate().equalsIgnoreCase(date))
                        .filter(ft -> ft.getNoOfConnections() == 0)
                        .collect(Collectors.toList());
            } else {
                filtered_offer_details = offer_details.stream()
                        .filter(s -> s.getOriginCity().equalsIgnoreCase(originCity))
                        .filter(d -> d.getDestinationCity().equalsIgnoreCase(destinationCity))
                        .filter(dt -> dt.getDate().equalsIgnoreCase(date))
                        .filter(ft -> ft.getNoOfConnections() > 0)
                        .collect(Collectors.toList());
            }

        } catch (javax.xml.bind.JAXBException ex) {
            // XXXTODO Handle exception
            java.util.logging.Logger.getLogger("global").log(java.util.logging.Level.SEVERE, null, ex); //NOI18N
        }

        return filtered_offer_details;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "bookSeats")
    public String bookSeats(@WebParam(name = "id") int id, @WebParam(name = "originCity") String originCity, @WebParam(name = "destinationCity") String destinationCity, @WebParam(name = "seats") int seats) {
        //TODO write your implementation code here:

        AvailableFlights availFlights2 = new AvailableFlights();
        List<OfferDetails> offer_details2 = null;

        try {
            javax.xml.bind.JAXBContext jaxbCtx = javax.xml.bind.JAXBContext.newInstance(availFlights2.getClass().getPackage().getName());
            javax.xml.bind.Unmarshaller unmarshaller = jaxbCtx.createUnmarshaller();
            availFlights2 = (AvailableFlights) unmarshaller.unmarshal(new java.io.File("C:\\Users\\saura\\Documents\\NetBeansProjects\\FlightBooking\\Flight_Offers_List.xml")); //NOI18N

            offer_details2 = availFlights2.getFlightDetails();

        } catch (javax.xml.bind.JAXBException ex) {
            // XXXTODO Handle exception
            java.util.logging.Logger.getLogger("global").log(java.util.logging.Level.SEVERE, null, ex); //NOI18N
        }

        int originalSeats;

        OfferDetails nextOffer2 = new OfferDetails();
        Iterator itr = offer_details2.iterator();
        while (itr.hasNext()) {
            nextOffer2 = (OfferDetails) itr.next();
            originalSeats = nextOffer2.getAvailableSeats();
            if (nextOffer2.getID() == id) {
                nextOffer2.setAvailableSeats(originalSeats - seats);
            }

        }

        try {
            javax.xml.bind.JAXBContext jaxbCtx = javax.xml.bind.JAXBContext.newInstance(availFlights2.getClass().getPackage().getName());
            javax.xml.bind.Marshaller marshaller = jaxbCtx.createMarshaller();
            marshaller.setProperty(javax.xml.bind.Marshaller.JAXB_ENCODING, "UTF-8"); //NOI18N
            marshaller.setProperty(javax.xml.bind.Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);

            //Writing the whole XML document to file
            File storeOffers = new File("C:\\Users\\saura\\Documents\\NetBeansProjects\\FlightBooking\\Flight_Offers_List.xml");
            marshaller.marshal(availFlights2, storeOffers);

        } catch (javax.xml.bind.JAXBException ex) {
            // XXXTODO Handle exception
            java.util.logging.Logger.getLogger("global").log(java.util.logging.Level.SEVERE, null, ex); //NOI18N
        }

        return "Success";
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "AllOffers")
    public List<OfferDetails> AllOffers() {
        //TODO write your implementation code here:
        
        AvailableFlights availFlights = new AvailableFlights();
        List<OfferDetails> offer_details = null;

        // OfferDetails offer;
        try {
            javax.xml.bind.JAXBContext jaxbCtx = javax.xml.bind.JAXBContext.newInstance(availFlights.getClass().getPackage().getName());
            javax.xml.bind.Unmarshaller unmarshaller = jaxbCtx.createUnmarshaller();
            availFlights = (AvailableFlights) unmarshaller.unmarshal(new java.io.File("C:\\Users\\saura\\Documents\\NetBeansProjects\\FlightBooking\\Flight_Offers_List.xml")); //NOI18N

            offer_details = availFlights.getFlightDetails();

        } catch (javax.xml.bind.JAXBException ex) {
            // XXXTODO Handle exception
            java.util.logging.Logger.getLogger("global").log(java.util.logging.Level.SEVERE, null, ex); //NOI18N
        }

        System.out.println("Hello");
        return offer_details;
    }
}

<%-- 
    Document   : search_maintenance_request
    Created on : 11 22, 23, 3:19:17 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Maintenance Request</title>
    </head>
    <body>
        <jsp:useBean id="A" class="MaintenanceRequest.JMaintenanceRequest" scope="session"/>

    <%
        String action = request.getParameter("action");
     %>   

      <%  
        if ("Next".equals(action)) {
            // Retrieve form parameters
            String s_requestid = request.getParameter("requestid");
            

            // Check if both values are provided
            if (s_requestid == null  || s_requestid.isEmpty()) {
    %>
                <p>Property ID is required. <a href="updatemaintenance.html">Go back</a></p>
    <%
            } else {
                // Check if values are of the correct data type
                try {
                    int requestid = Integer.parseInt(s_requestid);

                    // Retrieve specific house unit record
                    A.retrieve_request(requestid);

                    // Display old values and update form
    %>
                    <p>Search successful!</p>
                    <p>Request ID: <%= A.requestid %></p>
                    <p>Date Requested: <%= A.daterequested %></p>
                    <p>Date Fulfilled <%= A.datefulfilled %></p>
                    <p>Request Status: <%= A.requeststatus %></p>
                    <p>Property ID: <%= A.propertyid %></p>
                    <p>Personnel ID: <%= A.personnelid %></p>
                    <p>Officer ID: <%= A.officerid %></p>
                    <p>Type of Work: <%= A.typeofwork %></p>
                        <!-- Add other fields as needed -->
                        
                        
                        <a href="searchmaintenance.html">Search Again</a>
                        <a href="maintenance.html">Back to Main</a>
                <!-- Display old and new values if needed -->
                
                
                
    <%
                } catch (NumberFormatException e) {
    %>
                    <p>Values must be in the correct data type. <a href="searchmaintenance.html">Go back</a></p>
    <%
                }
            }
        } 
    %>
    </body>
</html>

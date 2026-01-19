<%-- 
    Document   : delete_housingunit
    Created on : 11 22, 23, 3:06:40 AM
    Author     : ccslearner
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, HousingUnit.JHousingUnit" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Housing Unit Processing</title>
</head>
<body>
    <jsp:useBean id="A" class="HousingUnit.JHousingUnit" scope="session"/>

    <%
        String action = request.getParameter("action");
        %>
        <p>Action: <%= action %></p>
      <%  if ("view".equals(action)) {
            // Retrieve form parameter
            String s_propertyid = request.getParameter("propertyid");

            // Check if propertyid is provided
            if (s_propertyid == null || s_propertyid.isEmpty()) {
    %>
                <p>Property ID is required. <a href="deletehousing.html">Go back</a></p>
    <%
            } else {
                // Check if propertyid is of the correct data type
                try {
                    int propertyid = Integer.parseInt(s_propertyid);

                    // Retrieve specific house unit record
                    A.retrieve_houseunit(propertyid);

                    // If the record is not found, display an error message
                    if (A.propertyid == 0) {
    %>
                        <p>Housing Unit not found. <a href="deletehousing.html">Go back</a></p>
    <%
                    } else {
    %>
                        <form action="delete_housingunit.jsp?action=delete" method="post">
                            <input type="hidden" name="action" value="delete">
                            <!-- Display retrieved record -->
                            <p> Property ID: <%= A.propertyid %></p>
                            <p> Member ID: <%= A.memberid %></p>
                            <p> Block No: <%= A.blockno %></p>
                            <p> Lot No: <%= A.lotno %></p>
                            <p> Street Name: <%= A.streetname %></p>
                            <p> Barangay: <%= A.barangay %></p>
                            <p> City: <%= A.city %></p>
                            <p> Province: <%= A.province %></p>
                            <p> Region: <%= A.region %></p>
                            <p> Zip Code: <%= A.zipcode %></p>
                            <p> Property Type: <%= A.propertytype %></p>
                            <p> Property Status: <%= A.propertyStatus %></p>
                            <p> Lot Size: <%= A.lotsize %></p> <br>
                            <!-- Add other fields as needed -->

                            <!-- Check if the housing unit is being used in maintenancerequest -->
                            <% if (A.isUsedInMaintenanceRequest()) { %> 
                                <p>Housing Unit is being used in Maintenance Requests or is currently active. Cannot be deleted.</p>
                                <a href="deletehousing.html">Go back</a>
                            <% } else { %>
                                <!-- Buttons -->
                                <input type="submit" value="delete">
                                <a href="housing.html">Back to Main Menu</a>
                            <% } %>
                        </form>
    <%
                    }
                } catch (NumberFormatException e) {
    %>
                    <p>Property ID must be in the correct data type. <a href="deletehousing.html">Go back</a></p>
    <%
                }
            }
        } else if ("delete".equals(action)) {
            // Delete the record from th e database
            int deleteStatus = A.delete_houseunit();

            if (deleteStatus >= 1) {
    %>
                <p>Record is Deleted!</p>
                <a href="housing.html">Back to Main Menu</a>
                <a href="deletehousing.html">Delete Another Housing Unit</a>
    <%
            } else {
    %>
                <p>Deletion failed. <a href="deletehousing.html">Try Again</a></p>
    <%
            }
        }
    %>
</body>
</html>

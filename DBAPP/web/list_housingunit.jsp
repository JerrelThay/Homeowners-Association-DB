<%-- 
    Document   : list_housingunit
    Created on : 11 22, 23, 3:10:50 AM
    Author     : ccslearner
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, HousingUnit.JHousingUnit" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>List Housing Unit Results</title>
</head>
<body>
    <jsp:useBean id="A" class="HousingUnit.JHousingUnit" scope="session"/>

    <%
        String action = request.getParameter("action");

        if (action == null) {
    %>
        <!-- Display the search form -->
        <jsp:include page="listhousing.jsp"/>
    <%

        }else if ("search".equals(action)) {
             // Process the form data
             
            try {
                // Retrieve search criteria from request parameters
                String s_streetname = request.getParameter("streetname");
                String s_city = request.getParameter("city");
                String s_propertyStatus = request.getParameter("propertyStatus");
                String s_propertytype = request.getParameter("propertytype");


                // Call the searchCommunityMember method in the JavaBean to search for community members
                List<JHousingUnit> housingUnitsList = A.list_housingunit(s_city, s_streetname, s_propertyStatus, s_propertytype);

                if (!housingUnitsList.isEmpty()) {
    %>
                    <!-- Display search results as a list -->
                    <table border="1">
                    <tr>
                        <th>Property ID</th>
                        <th>Member ID</th>
                        <th>Block No</th>
                        <th>Lot No</th>
                        <th>Street Name</th>
                        <th>Barangay</th>
                        <th>City</th>
                        <th>Province</th>
                        <th>Region</th>
                        <th>Zip Code</th>
                        <th>Property Type</th>
                        <th>Property Status</th>
                        <th>Lot Size</th>
                        <!-- Add other headers as needed -->
                    </tr>
                    <% for ( JHousingUnit result : housingUnitsList) { %>
                        <tr>
                            <td><%= result.getpropertyID() %></td>
                            <td><%= result.getmemberID() %></td>
                            <td><%= result.getblockNO() %></td>
                            <td><%= result.getlotNO() %></td>
                            <td><%= result.getmemberID() %></td>
                            <td><%= result.getStreetname() %></td>
                            <td><%= result.getBarangay() %></td>
                            <td><%= result.getcity() %></td>
                            <td><%= result.getprovince() %></td>
                            <td><%= result.getregion() %></td>
                            <td><%= result.getzipcode() %></td>
                            <td><%= result.getpropertytype() %></td>
                            <td><%= result.getpropertystatus() %></td>
                            <td><%= result.getlotsize() %></td>
                            <!-- Add other data as needed -->
                        </tr>
                    <% } %>
                </table>

                <!-- Buttons -->
                <a href="housing.html">Main Menu</a>
                <a href="listhousing.jsp">Search Again</a>
    <%
                } else {
    %>
                    <h1>No matching Housing Units found.</h1>
                    <a href="listhousing.jsp">Back to Search Housing Unit Form</a>
    <%
                }
            } catch (Exception e) {
    %>
                <h1>Error Processing Form Data</h1>
                <p><%= e.getMessage() %></p>
                <a href="listhousing.jsp">Go Back</a>
    <%
            }
        }
    %>
</body>
</html>

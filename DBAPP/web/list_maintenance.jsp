<%-- 
    Document   : list_maintenance
    Created on : 11 22, 23, 3:11:38 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="MaintenanceRequest.JMaintenanceRequest" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Maintenance</title>
    </head>
    <body>
        <jsp:useBean id="A" class="MaintenanceRequest.JMaintenanceRequest" scope="session"/>
        
         <%
        String action = request.getParameter("action");

        if (action == null) {
    %>
        <!-- Display the search form -->
        <jsp:include page="listmaintenance.jsp"/>
    <%
        } else if (action.equals("search")) {
            // Process the form data
            try {
                // Retrieve search criteria from request parameters
                String requeststatus = request.getParameter("requeststatus");
                String typeofwork = request.getParameter("typeofwork");


                // Call the searchCommunityMember method in the JavaBean to search for community members
                List<JMaintenanceRequest> searchResults = A.list_maintenance(requeststatus,typeofwork);

                if (!searchResults.isEmpty()) {
    %>
                    <!-- Display search results as a list -->
                    <table border="1">
                        <tr>
                            <th>Request ID</th>
                            <th>Date Requested</th>
                            <th>Date Fulfilled</th>
                            <th>Request Status</th>
                            <th>Property ID</th>
                            <th>Personnel ID</th>
                            <th>Office ID</th>
                            <th>Type of Work</th>   
                        </tr>
                        <%
                            for (JMaintenanceRequest result : searchResults) {
                        %>
                                <tr>
                                    <td><%= result.getRequestid() %></td>
                                    <td><%= result.getDaterequested() %></td>
                                    <td><%= result.getDatefulfilled() %></td>
                                    <td><%= result.getRequeststatus() %></td>
                                    <td><%= result.getPropertyid() %></td>
                                    <td><%= result.getPersonnelid() %></td>
                                    <td><%= result.getOfficerid() %></td>
                                    <td><%= result.getTypeofwork() %></td>
                                </tr>
                        <%
                            }
                        %>
                    </table>

                    <!-- Buttons for navigation -->
                    <a href="listmaintenance.jsp">Search Again</a><br>
                    <a href="maintence.html">Go Back to Functions</a>
    <%
                } else {
    %>
                    <h1>No matching community members found.</h1>
                    <a href="listmaintenance.jsp">Go Back</a>
    <%
                }
            } catch (Exception e) {
    %>
                <h1>Error Processing Form Data</h1>
                <p><%= e.getMessage() %></p>
                <a href="listmaintenance.jsp">Go Back</a>
    <%
            }
        }
    %>
    </body>
</html>

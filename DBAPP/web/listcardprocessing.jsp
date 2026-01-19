<%-- 
    Document   : listcardprocessing
    Created on : 11 21, 23, 8:52:02 PM
    Author     : ccslearner
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="RequestCard.JRequestCard" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>List Request Cards</title>
</head>
<body>
    <jsp:useBean id="requestCard" class="RequestCard.JRequestCard" scope="session"/>

    <%
        String action = request.getParameter("action");

        if (action == null) {
    %>
        <!-- Display the search form -->
        <jsp:include page="listcardprocessing.jsp"/>
    <%
        } else if (action.equals("search")) {
            // Process the form data
            try {
                // Retrieve search criteria from request parameters
                String s_requestdate = request.getParameter("requestdate");
                String s_provideddate = request.getParameter("provideddate");

                // Call the listRequestCard method in the JavaBean to search for request cards
                List<JRequestCard> searchResults = requestCard.list_requestcard(s_requestdate, s_provideddate);

                if (!searchResults.isEmpty()) {
    %>
                    <!-- Display search results as a list -->
                    <table border="1">
                        <tr>
                            <th>Card Number</th>
                            <th>Member ID</th>
                            <th>Status</th>
                            <th>Reason</th>
                            <th>Request Date</th>
                            <th>Provided Date</th>
                            <th>OR Number</th>
                            <th>ID Fee</th>
                            <th>Officer ID</th>
                        </tr>
                        <%
                            for (JRequestCard result : searchResults) {
                        %>
                                <tr>
                                    <td><%= result.getCardno() %></td>
                                    <td><%= result.getmemberID() %></td>
                                    <td><%= result.getStatus() %></td>
                                    <td><%= result.getReasondesc() %></td>
                                    <td><%= result.getRequestdate() %></td>
                                    <td><%= result.getProvideddate() %></td>
                                    <td><%= result.getORnumber() %></td>
                                    <td><%= result.getIdfee() %></td>
                                    <td><%= result.getOfficerid() %></td>
                                </tr>
                        <%
                            }
                        %>
                    </table>

                    <!-- Buttons for navigation -->
                    <a href="listid.html">Search Again</a><br>
                    <a href="requestcard.html">Go Back to Functions</a>
    <%
                } else {
    %>
                    <h1>No matching request cards found.</h1>
                    <a href="listid.html">Go Back</a>
    <%
                }
            } catch (Exception e) {
    %>
                <h1>Error Processing Form Data</h1>
                <p><%= e.getMessage() %></p>
                <a href="listid.html">Go Back</a>
    <%
            }
        }
    %>
</body>
</html>

<%-- 
    Document   : searchcardprocessing
    Created on : 11 21, 23, 7:58:35 PM
    Author     : ccslearner
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date, RequestCard.JRequestCard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Search Requests</title>
</head>
<body>
    <jsp:useBean id="requestCard" class="RequestCard.JRequestCard" scope="session"/>

    <%
        String action = request.getParameter("action");

        if ("retrieve".equals(action)) {
            // Retrieve form parameters
            String s_cardno = request.getParameter("cardno");
            String s_memberid = request.getParameter("memberid");

            // Check if both values are provided
            if (s_memberid == null || s_memberid.isEmpty() || s_cardno == null || s_cardno.isEmpty()) {
    %>
                <p>Both Card Number and Member ID are required. <a href="searchid.html">Go back</a></p>
    <%
            } else {
                try {
                    int cardno = Integer.parseInt(s_cardno);
                    int memberid = Integer.parseInt(s_memberid);

                    // Retrieve specific request card record
                    requestCard.retrieve_requestcard(cardno, memberid);

                    // If the record is not found, display an error message
                    if (requestCard.getCardno() == 0) {
    %>
                        <p>Request Card not found. <a href="validateid.html">Go back</a></p>
    <%
                    } else {
    %>
                        <form action="validatecardprocessing.jsp?action=validate" method="post">
                            <input type="hidden" name="action" value="validate">
                            <!-- Display retrieved record -->
                            <p>Card Number: <%= requestCard.getCardno() %></p>
                            <p>Member ID: <%= requestCard.getmemberID() %></p>
                            <p>Status: <%= requestCard.getStatus() %></p>
                            <p>Reason: <%= requestCard.getReasondesc() %></p>
                            <p>Date of Request: <%= requestCard.getRequestdate() %></p>
                            <p>Date Provided: <%= requestCard.getProvideddate() %></p>
                            <p>OR Number: <%= requestCard.getORnumber() %></p>
                            <p>ID Fee: <%= requestCard.getIdfee() %></p>
                            <p>Officer: <%= requestCard.getOfficerid() %></p>
                            <!-- Add other fields as needed -->

                            <!-- Buttons -->
                            <a href="searchid.html">Search Again</a><br>
                            <a href="requestcard.html">Back to Main Menu</a>
                            
                        </form>
    <%
                    }
                } catch (NumberFormatException e) {
    %>
                    <!-- Display an error message -->
                    <p>Error: Invalid input. Please enter valid numbers for Card Number and Member ID. <a href="searchid.html">Go back</a></p>
    <%
                }
            }
        }
    %>
</body>
</html>

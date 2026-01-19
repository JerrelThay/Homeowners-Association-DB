<%-- 
    Document   : cancelcardprocessing
    Created on : 11 21, 23, 5:02:30 PM
    Author     : ccslearner
--%>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, RequestCard.JRequestCard" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cancel Request</title>
</head>
<body>
    <jsp:useBean id="requestCard" class="RequestCard.JRequestCard" scope="session"/>

    <%
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            // Retrieve form parameters
            String s_cardno = request.getParameter("cardno");
            String s_memberid = request.getParameter("memberid");

            // Check if both cardno and memberid are provided
            if (s_cardno == null || s_cardno.isEmpty() || s_memberid == null || s_memberid.isEmpty()) {
    %>
                <p>Card Number and Member ID are required. <a href="cancelid.html">Go back</a></p>
    <%
            } else {
                // Check if cardno and memberid are of the correct data type
                try {
                    int cardno = Integer.parseInt(s_cardno);
                    int memberid = Integer.parseInt(s_memberid);

                    // Retrieve specific request card record
                    requestCard.retrieve_requestcard(cardno, memberid);

                    // If the record is not found, display an error message
                    if (requestCard.getCardno() == 0) {
    %>
                        <p>Request Card not found. <a href="cancelid.html">Go back</a></p>
    <%
                    } else {
    %>
                        <form action="cancelcardprocessing.jsp?action=cancel" method="post">
                            <input type="hidden" name="action" value="cancel">
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

                            <!-- Display confirmation message -->
                            <p>Do you want to proceed with the cancellation?</p>

                            <!-- Buttons -->
                            <a href="requestcard.html">Back to Main Menu</a>
                            <input type="submit" value="Cancel Request">
                        </form>
    <%
                    }
                } catch (NumberFormatException e) {
    %>
                    <p>Card Number and Member ID must be in the correct data type. <a href="cancelid.html">Go back</a></p>
    <%
                }
            }
        } else if ("cancel".equals(action)) {
            // Cancel the request card
            boolean cancelStatus = requestCard.cancel_requestcard();
            System.out.println("Cancel Status: " + cancelStatus);

            if (cancelStatus) {
    %>
                <p>Request Card Canceled Successfully!</p>
                <a href="cancelid.html">Cancel Another Request Card</a><br>
                <a href="requestcard.html">Back to Functions</a>
    <%
            } else {
    %>
                <p>Cancellation failed. <a href="requestcard.html">Back to Functions</a></p>
    <%
            }
        }
    %>
</body>
</html>
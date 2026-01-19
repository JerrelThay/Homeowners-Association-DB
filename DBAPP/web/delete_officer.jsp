<%-- 
    Document   : delete_officer
    Created on : 11 22, 23, 3:33:42 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, CommunityOfficer.JCommunityOfficer"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Community Officer</title>
    </head>
    <body>
        <jsp:useBean id="A" class="CommunityOfficer.JCommunityOfficer" scope="session"/>

        <%
            String action = request.getParameter("action");

            if ("view".equals(action)) {
                // Retrieve form parameter
                String s_officerid = request.getParameter("officerid");

                // Check if memberid is provided
                if (s_officerid == null || s_officerid.isEmpty()) {
        %>
                    <p>Officer ID is required. <a href="delete_officer.html">Go back</a></p>
        <%
                } else {
                    // Check if officerid is of the correct data type
                    try {
                        int officerid = Integer.parseInt(s_officerid);

                        // Retrieve specific house unit record
                        A.retrieve_communityofficer(officerid);

                        // If the record is not found, display an error message
                        if (A.officerid == 0) {
        %>
                            <p>Community Officer Not Found! <a href="officer.html">Go back</a></p>
        <%
                        } else {
        %>
                            <form action="delete_officer.jsp?action=delete" method="post">
                                <!-- Display retrieved record -->
                                <p>Officer ID: <%= A.officerid%></p>
                                <p>Member ID: <%= A.memberid%></p>
                                <p>Position: <%= A.position%></p>
                                <p>Term Start: <%= A.termstart%></p>
                                <p>Term End: <%= A.termend%></p>
                                <!-- Add other fields as needed -->

                                <% if (A.isUsedinCommunityMember() || A.isUsedinHousingUnit() || A.isUsedinRequestID()) { %>
                                    <p>Cannot delete the Community Officer as it is being used in other entities. </p>
                                    <a href="deleteofficer.html">Go back</a>
                                <% } else { %>
                                    <!-- Display confirmation message -->
                                    <p>Do you want to proceed with the deletion?</p>

                                    <!-- Buttons -->
                                    <input type="submit" value="=delete">
                                    <a href="officer.html">Back to Main Menu</a>
                                <% } %>
                            </form>
        <%
                        }
                    } catch (NumberFormatException e) {
        %>
                        <p>Officer ID must be in the correct data type. <a href="deleteofficer.html">Go back</a></p>
        <%
                    }
                }

            } else if ("delete".equals(action)) {
                // Delete the record from the database
                int deleteStatus = A.delete_communityofficer();

                if (deleteStatus == 1) {
        %>
                    <p>Record Deletion Successful</p>
                    <a href="officer.html">Back to Main Menu</a>
                    <a href="deleteofficer.html">Delete Another Community Officer</a>
        <%
                } else {
        %>
                    <p>Delete Community Officer Failed <a href="officer.html">Back to Main Menu</a></p>
        <%
                }
            }
        %>
    </body>
</html>
<%-- 
    Document   : delete_communitymember
    Created on : 11 20, 23, 8:01:48 AM
    Author     : ccslearner
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, CommunityMember.JCommunityMember" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Delete Community Member</title>
</head>
<body>
    <jsp:useBean id="A" class="CommunityMember.JCommunityMember" scope="session"/>

    <%
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            // Retrieve form parameter
            String s_memberid = request.getParameter("memberid");

            // Check if memberid is provided
            if (s_memberid == null || s_memberid.isEmpty()) {
    %>
                <p>Member ID is required. <a href="deletemember.html">Go back</a></p>
    <%
            } else {
                // Retrieve specific house unit record
                int memberid = Integer.parseInt(s_memberid);

                A.retrieve_communitymember(memberid);

                // If the record is not found, display an error message
                if (A.memberid == 0) {
    %>
                    <p>Community Member not found. <a href="deletemember.html">Go back</a></p>
    <%
                } else {
    %>
                    <form action="deletememberprocessing.jsp?action=delete" method="post">
                        <input type="hidden" name="action" value="delete">
                        <!-- Display retrieved record -->
                        <p>Member ID: <%= A.memberid %></p>
                        <p>Last Name: <%= A.memberlastname %></p>
                        <p>First Name: <%= A.memberfirstname %></p>
                        <p>Mobile Number: <%= A.mobileno%></p>
                        <p>Email: <%= A.email%></p>
                        <p>Birth Day: <%= A.birthdate %></p>
                        <p>Gender: <%= A.gender %></p>
                        <p>Move in Date: <%= A.moveindate %></p>
                        <p>Nationality: <%= A.nationality %></p>

                        <!-- Add other fields as needed -->

                        <% if (A.isUsedinCommunityOfficer() || A.isUsedinHousingUnit() || A.isUsedinRequestCard()) { %>
                        <p><strong>Cannot delete the Community Member as it is being used in other entities.</strong></p>
                            <a href="deletemember.html">Go back</a>
                        <% } else { %>
                            <!-- Display confirmation message -->
                            <p><strong>Do you want to proceed with the deletion?</strong></p>

                            <!-- Buttons -->
                            <input type="submit" value="delete">
                            <a href="member.html">Go Back to Functions</a>
                            
                        <% } %>
                    </form>
    <%
                }
            }
        } else if ("delete".equals(action)) {
            // Delete the record from the database
            int deleteStatus = A.delete_communitymember();
            System.out.println("Delete Status: " + deleteStatus);
            if (deleteStatus > 0) {
    %>
                <p>Record is Deleted!</p>
                
                <a href="deletemember.html">Delete Another </a><br>
                <a href="member.html">Go Back to Functions</a>
    <%
            } else {
    %>
                <p>Deletion failed. <a href="member.html">Go Back to Functions</a></p>
    <%
            }
        }
    %>
</body>
</html>

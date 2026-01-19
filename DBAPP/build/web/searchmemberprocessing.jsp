<%-- 
    Document   : searchmemberprocessing
    Created on : 11 21, 23, 7:35:36 PM
    Author     : ccslearner
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, java.text.DateFormat, java.text.SimpleDateFormat, java.util.Date, CommunityMember.JCommunityMember" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Search Community Member</title>
</head>
<body>
    <jsp:useBean id="A" class="CommunityMember.JCommunityMember" scope="session"/>

    <%
        String action = request.getParameter("action");

        if ("retrieve".equals(action)) {
            // Retrieve form parameters
            String s_memberid = request.getParameter("memberid");

            // Check if both values are provided
            if (s_memberid == null || s_memberid.isEmpty()) {
    %>
                <p>Member ID is required. <a href="searchmember.html">Go back</a></p>
    <%
            } else {
                // Retrieve specific community member record
                int memberid = Integer.parseInt(s_memberid);
                int retrieveStatus = A.retrieve_communitymember(memberid);

                // Check if the member is found
                if (retrieveStatus == 0) {
    %>
                    <p>Community Member not found. <a href="searchmember.html">Go back</a></p>
    <%
                } else {
                    // Display community member details
    %>
                    <h1>Community Member Details</h1>
                    <p>Member ID: <%= A.getmemberID() %></p>
                    <p>Last Name: <%= A.getMemberlastname() %></p>
                    <p>First Name: <%= A.getMemberfirstname() %></p>
                    <p>Mobile Number: <%= A.getMobileno() %></p>
                    <p>Email: <%= A.getEmail() %></p>
                    <p>Birth Day: <%= new SimpleDateFormat("yyyy-MM-dd").format(A.getBirthdate()) %></p>
                    <p>Gender: <%= A.getGender() %></p>
                    <p>Move-in Date: <%= new SimpleDateFormat("yyyy-MM-dd").format(A.getMoveindate()) %></p>
                    <p>Nationality: <%= A.getNationality() %></p>
                    <!-- Add other fields as needed -->

                    <!-- Link to go back to search -->
                    <a href="searchmember.html">Search Another Member</a><br>
    <%
                }
            }
        }
    %>
</body>
</html>

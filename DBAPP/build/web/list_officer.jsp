<%-- 
    Document   : list_officer
    Created on : 11 22, 23, 3:35:23 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="CommunityOfficer.JCommunityOfficer" %>

<html>
    <head>
        <title>List Community Officer Records</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <jsp:useBean id="A" class="CommunityOfficer.JCommunityOfficer" scope="session"/>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        List<JCommunityOfficer> officerList = new ArrayList<>(); // Initialize the list

        try {
            // Establish a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");            

            String action = request.getParameter("action");

            if ("search".equals(action)) {
                // Retrieve form parameters
                String s_position = request.getParameter("position");

                // Retrieve parameters from the request
                String position = request.getParameter("position");

                // Set criteria values in the bean
                A.setPosition(s_position);

                // Perform the search using the Java class
                officerList = JCommunityOfficer.list_communityofficer(position);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Handle exceptions appropriately
        } finally {
            // Close resources (Connection, PreparedStatement, etc.) in a finally block
        }

        if (!officerList.isEmpty()) {
        %>        

            <!-- Display search results as a list -->
            <table border="1">
                <tr>
                    <th>Officer ID</th>
                    <th>Position</th>
                    <th>Term Start</th>
                    <th>Term End</th>
                </tr>
                <%
                for (JCommunityOfficer communityOfficer : officerList) {
                %>
                    <tr>
                        <td><%= communityOfficer.getOfficerID() %></td>
                        <td><%= communityOfficer.getPosition() %></td>
                        <td><%= communityOfficer.getTermStart() %></td>
                        <td><%= communityOfficer.getTermEnd() %></td>
                    </tr>
                <%
                }
                %>
            </table>

            <!-- Buttons for navigation -->
            <a href="listofficer.html">Search Again</a><br>
            <a href="officer.html">Main Menu</a>
        <%
        } else {
        %>
            <h1>No matching community officers found.</h1>
            <a href="listofficer.html">Go Back</a>
        <%
        }
        %>

    </body>
</html>
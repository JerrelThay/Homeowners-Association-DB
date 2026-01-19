<%-- 
    Document   : search_officer
    Created on : 11 22, 23, 3:41:22 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, CommunityOfficer.JCommunityOfficer" %>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Community Officer Results</title>
    </head>
    <body>
        <jsp:useBean id="A" class="CommunityOfficer.JCommunityOfficer" scope="session"/>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        
            // Establish a connection to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");            
            
            String action = request.getParameter("action");

            if ("search".equals(action)) {
                // Retrieve form parameters
                String s_officerid = request.getParameter("officerid");
                String s_position = request.getParameter("position");
                String s_termstart = request.getParameter("termstart");
                String s_termend = request.getParameter("termend");

                // Set criteria values in the bean
                A.setOfficerID(s_officerid);
                A.setPosition(s_position);
                
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                
                try {
                    // Parse the string into a Date object
                    Date termStartDate = dateFormat.parse(s_termstart);
                    Date termEndDate = dateFormat.parse(s_termend);

                    // Set the Date object on your object (assuming A has a method setTermStart(Date date))
                    A.setTermStart(termStartDate);
                    A.setTermEnd(termEndDate);

                } catch (ParseException e) {
                    // Handle the exception (e.g., log it, show an error message, etc.)
                    e.printStackTrace(); // or logger.error("Error parsing date", e);
                }

                // Retrieve list of community officers based on criteria
                ArrayList<HashMap<String, String>> communityOfficersList = A.search_communityofficer();

                // Display the results
        %>
                <table border="1">
                    <tr>
                        <th>Officer ID</th>
                        <th>Position</th>
                        <th>Term Start</th>
                        <th>Term End</th>
                        <!-- Add other headers as needed -->
                    </tr>
                    <% for (HashMap<String, String> communityOfficer : communityOfficersList) { %>
                        <tr>
                            <td><%= communityOfficer.get("officerid") %></td>
                            <td><%= communityOfficer.get("position") %></td>
                            <td><%= communityOfficer.get("termstart") %></td>
                            <td><%= communityOfficer.get("termend") %></td>
                            <!-- Add other data as needed -->
                        </tr>
                    <% } %>
                </table>

                <!-- Buttons -->
                <a href="officer.html">Main Menu </a>
                <a href="searchofficer.html">Search Again</a>
        <%
            }
        %>
    </body>
</html>
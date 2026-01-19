<%-- 
    Document   : communitydemographicsreport
    Created on : 11 22, 23, 3:29:01 AM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report on Community Demographics By Year</title>
</head>
    <body>
    
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
            //Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            // Get the selected year from the HTML form
            String selectedYear = request.getParameter("year");
            
            // Prepare SQL query
            String sql = "SELECT * FROM communitymember WHERE YEAR(moveindate) = ?";

            // Prepare the statement
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, selectedYear);

            // Execute the query
            rs = pstmt.executeQuery();
    %>
    
    <h2>Community Demographics Report - Year <%= selectedYear %></h2>
    
        <table border="1">
            <tr>
                <th>Member ID</th>
                <th>Last Name</th>
                <th>First Name</th>
                <th>Mobile No</th>
                <th>Email</th>
                <th>Birthdate</th>
                <th>Gender</th>
                <th>Move-In Date</th>
                <th>Nationality</th>
            </tr>

            <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("memberid") %></td>
                    <td><%= rs.getString("memberlastname") %></td>
                    <td><%= rs.getString("memberfirstname") %></td>
                    <td><%= rs.getString("mobileno") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getDate("birthdate") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getDate("moveindate") %></td>
                    <td><%= rs.getString("nationality") %></td>
                </tr>
            <% } %>
        </table>

        <%
       // Close the database resources
       rs.close();
       pstmt.close();
       conn.close();
       %>

    <button type="button" onclick="history.back()">Back</button>
    <button type="button" onclick="window.location.href='index.html'">Exit</button>

    </body>
</html>
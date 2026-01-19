<%-- 
    Document   : m_firstnameList
    Created on : 11 21, 23, 9:25:02 PM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>List of Maintenance Personnel Grouped by First Name</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h2>Maintenance Personnel Grouped by First Name</h2>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            String sql = "SELECT personnelid, personnellastname, personnelfirstname, phoneno, skilldesc, hourlyrate, employmentdate, resignationdate FROM maintenancepersonnel ORDER BY personnelfirstname";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            out.println("<table><tr><th>Personnel ID</th><th>Last Name</th><th>First Name</th><th>Phone No</th><th>Skill Desc</th><th>Hourly Rate</th><th>Employment Date</th><th>Resignation Date</th></tr>");
            while (rs.next()) {
                out.println("<tr><td>" + rs.getInt("personnelid") + "</td><td>" + rs.getString("personnellastname") + "</td><td>" + rs.getString("personnelfirstname") + "</td><td>" + rs.getString("phoneno") + "</td><td>" + rs.getString("skilldesc") + "</td><td>" + rs.getDouble("hourlyrate") + "</td><td>" + rs.getDate("employmentdate") + "</td><td>" + rs.getDate("resignationdate") + "</td></tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error occurred: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
        }
    %>
    
    <button type="button" onclick="history.back()">Back</button>
    <button type="button" onclick="window.location.href='index.html'">Exit</button>

</body>
</html>

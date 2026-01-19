<%-- 
    Document   : m_ReportTypeOfWork
    Created on : 11 21, 23, 9:33:33 PM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Maintenance Requests Report by Type of Work</title>
  
</head>
<body>
<h2>Maintenance Requests Report by Type of Work</h2>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

        // SQL query to get the count of maintenance requests by type of work
        String sql = "SELECT typeofwork, COUNT(*) AS TotalRequests FROM maintenancerequest GROUP BY typeofwork";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        // HTML table to display the results
        out.println("<table border='1'><tr><th>Type of Work</th><th>Total Requests</th></tr>");
        while (rs.next()) {
            String typeOfWork = rs.getString("typeofwork");
            int count = rs.getInt("TotalRequests");
            out.println("<tr><td>" + typeOfWork + "</td><td>" + count + "</td></tr>");
        }
        out.println("</table>");
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        // Clean-up environment
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<button type="button" onclick="history.back()">Back</button>
<button type="button" onclick="window.location.href='index.html'">Exit</button>

</body>
</html>

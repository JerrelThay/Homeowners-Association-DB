<%-- 
    Document   : m_ReportPropertyID
    Created on : 11 21, 23, 9:31:55 PM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report on Maintenance Requests per Property ID</title>
   
</head>
<body>
<h2>Report on Maintenance Requests per Property ID</h2>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

        String sql = "SELECT propertyid, COUNT(*) AS RequestCount FROM maintenancerequest GROUP BY propertyid ORDER BY propertyid";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        out.println("<table border='1'><tr><th>Property ID</th><th>Number of Requests</th></tr>");
        while (rs.next()) {
            int propertyId = rs.getInt("propertyid");
            int requestCount = rs.getInt("RequestCount");
            out.println("<tr><td>" + propertyId + "</td><td>" + requestCount + "</td></tr>");
        }
        out.println("</table>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<button type="button" onclick="history.back()">Back</button>
<button type="button" onclick="window.location.href='index.html'">Exit</button>


</body>
</html>
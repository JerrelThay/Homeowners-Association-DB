<%-- 
    Document   : m_ReportDateRequested
    Created on : 11 21, 23, 9:29:08 PM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Count of Maintenance Requests per Year (Date Requested)</title>
</head>
<body>
<h2>Count of Maintenance Requests per Year (Date Requested)</h2>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

        String sql = "SELECT YEAR(daterequested) AS RequestYear, COUNT(*) AS TotalRequests FROM maintenancerequest GROUP BY YEAR(daterequested)";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        out.println("<table border='1'><tr><th>Year</th><th>Total Requests</th></tr>");
        while (rs.next()) {
            int year = rs.getInt("RequestYear");
            int count = rs.getInt("TotalRequests");
            out.println("<tr><td>" + year + "</td><td>" + count + "</td></tr>");
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


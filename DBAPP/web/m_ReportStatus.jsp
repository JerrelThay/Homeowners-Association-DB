<%-- 
    Document   : m_ReportStatus
    Created on : 11 21, 23, 9:32:42 PM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Report on The Frequency of Maintenance Requests by Status</title>
</head>
<body>
<h2>Count of Maintenance Requests by Status</h2>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

        String sql = "SELECT requeststatus, COUNT(*) AS TotalRequests FROM maintenancerequest GROUP BY requeststatus";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        out.println("<table border='1'><tr><th>Status</th><th>Total Requests</th></tr>");
        while (rs.next()) {
            String status = rs.getString("requeststatus");
            int count = rs.getInt("TotalRequests");
            out.println("<tr><td>" + status + "</td><td>" + count + "</td></tr>");
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

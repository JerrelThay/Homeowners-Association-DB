<%-- 
    Document   : m_ReportPersonnelID
    Created on : 11 21, 23, 9:31:07 PM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Maintenance Request Report per Personnel</title>
   
</head>
<body>
    <h2>Maintenance Request Report per Personnel</h2>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            String sql = "SELECT personnelid, COUNT(*) AS RequestCount FROM maintenancerequest GROUP BY personnelid ORDER BY RequestCount DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            out.println("<table border='1'><tr><th>Personnel ID</th><th>Number of Requests</th></tr>");
            while (rs.next()) {
                int personnelID = rs.getInt("personnelid");
                int requestCount = rs.getInt("RequestCount");
                out.println("<tr><td>" + personnelID + "</td><td>" + requestCount + "</td></tr>");
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
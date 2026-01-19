<%-- 
    Document   : m_ReportOfficerID
    Created on : 11 21, 23, 9:30:14 PM
    Author     : ccslearner
--%>


<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Maintenance Requests Report per Officer Who Approved the Request</title>
    
</head>
<body>
<h2>Maintenance Requests Report per Officer</h2>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

        // Prepare SQL query to count maintenance requests per officeID
        String sql = "SELECT officerid, COUNT(*) AS RequestCount FROM maintenancerequest GROUP BY officerid ORDER BY officerid";
        pstmt = conn.prepareStatement(sql);

        // Execute the query
        rs = pstmt.executeQuery();

        // Start the HTML table for the results
        out.println("<table border='1'><tr><th>Officer ID</th><th>Number of Requests</th></tr>");

        // Loop through the result set and populate the table
        while (rs.next()) {
            int officeID = rs.getInt("officerid");
            int requestCount = rs.getInt("RequestCount");
            out.println("<tr><td>" + officeID + "</td><td>" + requestCount + "</td></tr>");
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


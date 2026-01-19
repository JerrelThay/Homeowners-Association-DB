<%-- 
    Document   : m_ReportDateFulfilled
    Created on : 11 21, 23, 9:28:09 PM
    Author     : ccslearner
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Count of Maintenance Requests per Year (Date Fulfilled)</title>
</head>
<body>
<h2>Count of Maintenance Requests per Year (Date Fulfilled)</h2>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    try {
        //Connection conn;
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
        // Create SQL query
        String sql = "SELECT YEAR(datefulfilled) AS FulfillmentYear, COUNT(*) AS TotalRequests FROM maintenancerequest WHERE datefulfilled IS NOT NULL GROUP BY YEAR(datefulfilled) ORDER BY FulfillmentYear";

        // Prepare the statement
        pstmt = conn.prepareStatement(sql);

        // Execute the query
        rs = pstmt.executeQuery();

        // Start the table to display results
        out.println("<table border='1'><tr><th>Year</th><th>Total Requests Fulfilled</th></tr>");

        // Loop through the result set and populate the table
        while (rs.next()) {
            int year = rs.getInt("FulfillmentYear");
            int count = rs.getInt("TotalRequests");
            out.println("<tr><td>" + year + "</td><td>" + count + "</td></tr>");
        }

        // Close the table
        out.println("</table>");

    } catch (Exception e) {
        // Handle any exceptions and display an error message
        e.printStackTrace();
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
    } finally {
        // Close all resources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<button type="button" onclick="history.back()">Back</button>
<button type="button" onclick="window.location.href='index.html'">Exit</button>


</body>
</html>


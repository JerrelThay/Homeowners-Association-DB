<%-- 
    Document   : createMaintenance
    Created on : 11 21, 23, 9:14:21 PM
    Author     : ccslearner
--%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>List of Maintenance Personnel</title>
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
    <%
        String lastName = request.getParameter("personnellastname");
        String firstName = request.getParameter("personnelfirstname");
        String phoneNo = request.getParameter("phoneno");
        String skillDesc = request.getParameter("skilldesc[]"); // Note: Handle multiple selections appropriately if required
        double hourlyRate = Double.parseDouble(request.getParameter("hourlyRate"));
        String employmentDateString = request.getParameter("employmentDate");
        String resignationDateString = request.getParameter("resignationDate");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Insert new record
            String insertSQL = "INSERT INTO maintenancepersonnel (personnellastname, personnelfirstname, phoneno, skilldesc, hourlyrate, employmentdate, resignationdate) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSQL);
            pstmt.setString(1, lastName);
            pstmt.setString(2, firstName);
            pstmt.setString(3, phoneNo);
            pstmt.setString(4, skillDesc);
            pstmt.setDouble(5, hourlyRate);

            // Handle employment date
            if (employmentDateString != null && !employmentDateString.isEmpty()) {
                pstmt.setDate(6, java.sql.Date.valueOf(employmentDateString));
            } else {
                pstmt.setNull(6, Types.DATE);
            }

            // Handle resignation date
            if (resignationDateString != null && !resignationDateString.isEmpty()) {
                pstmt.setDate(7, java.sql.Date.valueOf(resignationDateString));
            } else {
                pstmt.setNull(7, Types.DATE);
            }
            
            pstmt.executeUpdate();

            // Display all records
            pstmt = conn.prepareStatement("SELECT * FROM maintenancepersonnel");
            rs = pstmt.executeQuery();
            
            out.println("<h2>Maintenance Personnel Grouped by Last Name</h2>");
            out.println("<table><tr><th>Personnel ID</th><th>Last Name</th><th>First Name</th><th>Phone No</th><th>Skill Desc</th><th>Hourly Rate</th><th>Employment Date</th><th>Resignation Date</th></tr>");
            while (rs.next()) {
                out.println("<tr><td>" + rs.getInt("personnelid") + "</td><td>" + rs.getString("personnellastname") + "</td><td>" + rs.getString("personnelfirstname") + "</td><td>" + rs.getString("phoneno") + "</td><td>" + rs.getString("skilldesc") + "</td><td>" + rs.getDouble("hourlyrate") + "</td><td>" + rs.getDate("employmentdate") + "</td><td>" + rs.getDate("resignationdate") + "</td></tr>");
            }
            out.println("</table>");
        } catch (SQLException e) {
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
S
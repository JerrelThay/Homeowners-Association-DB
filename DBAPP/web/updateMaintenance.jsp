<%-- 
    Document   : updateMaintenance
    Created on : 11 21, 23, 9:36:55 PM
    Author     : ccslearner
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Maintenance Personnel</title>
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
    String personnelId = request.getParameter("personnelid");
    String lastName = request.getParameter("personnellastname");
    String firstName = request.getParameter("personnelfirstname");
    String phoneNo = request.getParameter("phoneno");    
    String skillDesc = request.getParameter("skilldesc");    
    String hourlyRate = request.getParameter("hourlyRate");
    String employmentDate = request.getParameter("employmentDate");
    String resignationDate = request.getParameter("resignationDate");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

        // Check if the personnel exists
        String sqlCheck = "SELECT * FROM maintenancepersonnel WHERE personnelid = ?";
        pstmt = conn.prepareStatement(sqlCheck);
        pstmt.setString(1, personnelId);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
            out.println("Personnel Not Found");
        } else {
            StringBuilder sqlUpdate = new StringBuilder("UPDATE maintenancepersonnel SET ");
            int paramIndex = 1;

            if (lastName != null && !lastName.isEmpty()) {
                sqlUpdate.append("personnellastname = ?, ");
            }
            if (firstName != null && !firstName.isEmpty()) {
                sqlUpdate.append("personnelfirstname = ?, ");
            }
            if (phoneNo != null && !phoneNo.isEmpty()) {
                sqlUpdate.append("phoneno = ?, ");
            }
            if (skillDesc != null && !skillDesc.isEmpty()) {
                sqlUpdate.append("skilldesc = ?, ");
            }
            if (hourlyRate != null && !hourlyRate.isEmpty()) {
                sqlUpdate.append("hourlyrate = ?, ");
            }
            if (employmentDate != null && !employmentDate.isEmpty()) {
                sqlUpdate.append("employmentdate = ?, ");
            }
            if (resignationDate != null && !resignationDate.isEmpty()) {
                sqlUpdate.append("resignationdate = ?, ");
            }

            if (sqlUpdate.length() > 33) { // Check if any fields were appended
                sqlUpdate = new StringBuilder(sqlUpdate.substring(0, sqlUpdate.length() - 2)); // Remove last comma
                sqlUpdate.append(" WHERE personnelid = ?");

                pstmt = conn.prepareStatement(sqlUpdate.toString());

                if (lastName != null && !lastName.isEmpty()) {
                    pstmt.setString(paramIndex++, lastName);
                }
                if (firstName != null && !firstName.isEmpty()) {
                    pstmt.setString(paramIndex++, firstName);
                }
                if (phoneNo != null && !phoneNo.isEmpty()) {
                    pstmt.setString(paramIndex++, phoneNo);
                }
                if (skillDesc != null && !skillDesc.isEmpty()) {
                    pstmt.setString(paramIndex++, skillDesc);
                }
                if (hourlyRate != null && !hourlyRate.isEmpty()) {
                    pstmt.setDouble(paramIndex++, Double.parseDouble(hourlyRate));
                }
                if (employmentDate != null && !employmentDate.isEmpty()) {
                    pstmt.setDate(paramIndex++, Date.valueOf(employmentDate));
                }
                if (resignationDate != null && !resignationDate.isEmpty()) {
                    pstmt.setDate(paramIndex++, Date.valueOf(resignationDate));
                }
                pstmt.setInt(paramIndex, Integer.parseInt(personnelId));

                int updated = pstmt.executeUpdate();

                if (updated > 0) {
                    out.println("Record Updated<br>");

                    // Display the updated record
                    String sqlDisplay = "SELECT * FROM maintenancepersonnel WHERE personnelid = ?";
                    pstmt = conn.prepareStatement(sqlDisplay);
                    pstmt.setString(1, personnelId);
                    rs = pstmt.executeQuery();

                    out.println("<table><tr><th>Personnel ID</th><th>Last Name</th><th>First Name</th><th>Phone No</th><th>Skill Desc</th><th>Hourly Rate</th><th>Employment Date</th><th>Resignation Date</th></tr>");
                    while (rs.next()) {
                        out.println("<tr><td>" + rs.getInt("personnelid") + "</td><td>" + rs.getString("personnellastname") + "</td><td>" + rs.getString("personnelfirstname") + "</td><td>" + rs.getString("phoneno") + "</td><td>" + rs.getString("skilldesc") + "</td><td>" + rs.getDouble("hourlyrate") + "</td><td>" + rs.getDate("employmentdate") + "</td><td>" + rs.getDate("resignationdate") + "</td></tr>");
                    }
                    out.println("</table>");
                } else {
                    out.println("No updates were made.");
                }
            } else {
                out.println("No information provided to update.");
            }
        }
    } catch (SQLException e) {
        out.println("<p>SQL Error occurred: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } catch (Exception e) {
        out.println("<p>Error occurred: " + e.getMessage() + "</p>");
        e.printStackTrace();
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

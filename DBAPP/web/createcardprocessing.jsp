<%-- 
    Document   : createcardprocessing
    Created on : 11 21, 23, 4:10:11 PM
    Author     : ccslearner
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Request Processing</title>
    </head>
    <body>
        <jsp:useBean id='A' class='RequestCard.JRequestCard' scope='session'/>
        <%
            try {
                int v_memberid = Integer.parseInt(request.getParameter("memberid"));
                A.memberid = v_memberid;

                // Check if the member ID exists in the database
                if (!isMemberIdExists(A.memberid)) {
        %>
                    <h1>Error: Member ID does not exist</h1>
                    <a href="createid.html">Back to Request Form</a><br>
                    <a href="requestcard.html">Back to Functions</a>
        <%
                } else {
                    String v_reasondesc = request.getParameter("reasondesc");
                    A.reasondesc = v_reasondesc;

                    int status = A.create_requestcard();
                    if (status == 1) {
        %>
                        <h1>Registering Request Successful</h1>
                        <!-- Display request details here -->
                         <h1>New Request Record Saved:</h1>
                         <p>Card Number: <%= A.getCardno() %></p>
                         <p>Member ID: <%= A.getmemberID() %></p>
                         <p>Status: <%= A.getStatus() %></p>
                         <p>Reason: <%= A.getReasondesc() %></p>
                            <%
                                SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                                String formattedRequestdate = outputDateFormat.format(A.getRequestdate());
                            %>
                         <p>Requested Date: <%= formattedRequestdate %></p>
                            <%
                                Date providedDate = A.getProvideddate();
                                String formattedProvideddate = (providedDate != null) ? outputDateFormat.format(providedDate) : "";
                            %>
                         <p>Provided Date: <%= formattedProvideddate %></p>

                         <p>OR Number: <%= A.getORnumber() %></p>
                         <p>ID Fee: <%= A.getIdfee() %></p>
                         <p>Officer: <%= A.getOfficerid() %></p>

                         <a href="createid.html">Register Request Again</a><br>
                         <a href="requestcard.html">Back to Functions</a>
        <%
                    } else {
        %>
                        <h1>Registering Request Failed</h1>
                        <a href="requestcard.html">Back to Functions</a>
        <%
                    }
                }
            } catch (NumberFormatException e) {
        %>
                <h1>Error: Invalid Member ID format</h1>
                <a href="createid.html">Back to Create ID</a><br>
                <a href="requestcard.html">Back to Functions</a>
        <%
            }
        %>

        <%! // Declaration of helper method to check if member ID exists in the database
        private boolean isMemberIdExists(int memberId) {
            try {
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");

                PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM communitymember WHERE memberid = ?");
                pstmt.setInt(1, memberId);
                ResultSet resultSet = pstmt.executeQuery();
                resultSet.next();
                int count = resultSet.getInt("count");

                pstmt.close();
                conn.close();

                return count > 0;
            } catch (Exception e) {
                System.out.println(e.getMessage());
                return false;
            }
        }
        %>

    </body>
</html>

<%-- 
    Document   : search_communitymember
    Created on : 11 20, 23, 12:40:59 PM
    Author     : ccslearner
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="CommunityMember.JCommunityMember" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>List Community Member</title>
</head>
<body>
    <jsp:useBean id= "communityMember" class= "CommunityMember.JCommunityMember" scope="session"/>

    <%
        String action = request.getParameter("action");

        if (action == null) {
    %>
        <!-- Display the search form -->
        <jsp:include page="listmemberprocessing.jsp"/>
    <%
        } else if (action.equals("search")) {
            // Process the form data
            try {
                // Retrieve search criteria from request parameters
                String memberlastname = request.getParameter("memberlastname");
                String memberfirstname = request.getParameter("memberfirstname");
                String gender = request.getParameter("gender");
                String nationality = request.getParameter("nationality");

                // Call the searchCommunityMember method in the JavaBean to search for community members
                List<JCommunityMember> searchResults = communityMember.list_communitymember(memberlastname, memberfirstname, gender, nationality);

                if (!searchResults.isEmpty()) {
    %>
                    <!-- Display search results as a list -->
                    <table border="1">
                        <tr>
                            <th>Member ID</th>
                            <th>Last Name</th>
                            <th>First Name</th>
                            <th>Mobile Number</th>
                            <th>Email</th>
                            <th>Birth Day</th>
                            <th>Gender</th>
                            <th>Move in Date</th>
                            <th>Nationality</th>    
                        </tr>
                        <%
                            for (JCommunityMember result : searchResults) {
                        %>
                                <tr>
                                    <td><%= result.getmemberID() %></td>
                                    <td><%= result.getMemberlastname() %></td>
                                    <td><%= result.getMemberfirstname() %></td>
                                    <td><%= result.getMobileno() %></td>
                                    <td><%= result.getEmail() %></td>
                                    <td><%= result.getBirthdate() %></td>
                                    <td><%= result.getGender() %></td>
                                    <td><%= result.getMoveindate() %></td>
                                    <td><%= result.getNationality() %></td>
                                </tr>
                        <%
                            }
                        %>
                    </table>

                    <!-- Buttons for navigation -->
                    <a href="listmember.jsp">Search Again</a><br>
                    <a href="member.html">Go Back to Functions</a>
    <%
                } else {
    %>
                    <h1>No matching community members found.</h1>
                    <a href="listmember.jsp">Go Back</a>
    <%
                }
            } catch (Exception e) {
    %>
                <h1>Error Processing Form Data</h1>
                <p><%= e.getMessage() %></p>
                <a href="listmember.jsp">Go Back</a>
    <%
            }
        }
    %>
</body>
</html>

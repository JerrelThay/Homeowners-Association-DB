<%-- 
    Document   : update_officer
    Created on : 11 22, 23, 3:42:50 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, CommunityOfficer.JCommunityOfficer"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Community Member</title>
    </head>
    <body>
        <jsp:useBean id="A" class="CommunityOfficer.JCommunityOfficer" scope="session"/>

        <%
            String action = request.getParameter("action");

            if ("retrieve".equals(action)) {
                // Retrieve form parameters
                String s_officerid = request.getParameter("officerid");

                // Check if both values are provided
                if (s_officerid == null || s_officerid.isEmpty()) {
        %>
                    <p>Officer ID is required.<a href="updateofficer.html">Go back</a></p>
        <%
                } else {
                    // Check if values are of the correct data type
                    try {
                        int officerid = Integer.parseInt(s_officerid);

                        // Retrieve specific officer record
                        A.retrieve_communityofficer(officerid);

                        // Display old values and update form
        %>
                        <form action="update_officer.jsp?action=save" method="post">
                            <!-- Display old values -->
                            <p>Old Officer ID: <%= A.officerid%></p>
                            <p>Old Member ID: <%= A.memberid%></p>
                            <p>Old Position: <%= A.position%></p>
                            <p>Old Term Start: <%= A.termstart%></p>
                            <p>Old Term End: <%= A.termend%></p>
                            <!-- Add other fields as needed -->

                            <p>Unchangeable Fields: Officer ID and Member ID</p><br>

                            <!-- Input fields for updates -->
                            
                            <label for="position">New Officer Position:</label>
                            <select id="position" name="position">
                            <option value= "President" >President</option>
                            <option value= "Vice-President" >Vice-President</option>
                            <option value= "Secretary" >Secretary</option>
                            <option value= "Treasurer" >Treasurer</option>
                            <option value= "Village Manager" >Village Manager</option>
                            <option value= "PRO" >PRO</option>
                            <option value= "CRO" >CRO</option>
                            <option value= "Registrar" >Registrar</option>
                            </select><br>
                            <!-- Add other positions as needed -->
                            
                            <label for="termstart">New Term Start:</label>
                            <input type="date" id="termstart" name="termstart"><br>
                            
                            <label for="termstart">New Term End:</label>
                            <input type="date" id="termend" name="termend"><br>
                            
                            <!-- Add other input fields for updates as needed -->

                            <!-- Buttons -->
                            <input type="submit" value="Save">
                            <a href="officer.html">Cancel</a>
                        </form>
        <%
                    } catch (NumberFormatException e) {
        %>
                        <p>Both values must be in the correct data type.<a href="update_officer.jsp">Go back</a></p>
        <%
                    }
                }
            } else if ("save".equals(action)) {
                int v_officerid = Integer.parseInt(request.getParameter("officerid")); //parameter should be same with id in html
                A.memberid = v_officerid;
                // Save updated data to the database
                int updateStatus = A.update_communityofficer();

                if (updateStatus == 1) {
        %>
                    <p>Record Update Successful</p>
                    <!-- Display old and new values if needed -->
                    <h1>Updated Community Officer Record</h1>
                    <table border="1">
                        <tr>
                            <th>Field</th>
                            <th>Old Value</th>
                            <th>New Value</th>
                        </tr>
                        <tr>
                            <td>Officer ID</td>
                            <td><%= A.getOfficerID() %></td>
                            <td><%= A.getOfficerID() %></td>
                        </tr>
                        <tr>
                            <td>Member ID</td>
                            <td><%= A.getMemberID() %></td>
                            <td><%= A.getMemberID() %></td>
                        </tr>
                        <tr>
                            <td>Position</td>
                            <td><%= A.getOldPosition() %></td>
                            <td><%= A.getPosition() %></td>
                        </tr>
                        <tr>
                            <td>Term Start</td>
                            <td><%= A.getOldTermStart() %></td>
                            <td><%= A.getTermStart() %></td>
                        </tr>
                        <tr>
                            <td>Term End</td>
                            <td><%= A.getOldTermEnd() %></td>
                            <td><%= A.getTermEnd() %></td>
                        </tr>                      
                        <!-- Add other fields as needed -->
                    </table>

                    <a href="officer.html">Back to Main Menu</a>
                    <a href="updateofficer.html">Update Another Community Officer</a>
        <%
                } else {
        %>
                    <p>Update Community Officer Failed<br><a href="officer.html">Back to Main Menu</a></p>
        <%
                }
            }
        %>
        
    </body>
</html>
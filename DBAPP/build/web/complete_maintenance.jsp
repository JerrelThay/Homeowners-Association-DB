<%-- 
    Document   : complete_maintenance
    Created on : 11 22, 23, 3:08:53 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, MaintenanceRequest.JMaintenanceRequest" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Housing Unit</title>
</head>
<body>
    <jsp:useBean id="A" class="MaintenanceRequest.JMaintenanceRequest" scope="session"/>

    <%
        String action = request.getParameter("action");
     %>   
      <%  
        if ("Next".equals(action)) {
            // Retrieve form parameters
            String s_requestid = request.getParameter("requestid");
            

            // Check if both values are provided
            if (s_requestid == null  || s_requestid.isEmpty()) {
    %>
                <p>Property ID is required. <a href="updatemaintenance.html">Go back</a></p>
    <%
            } else {
                // Check if values are of the correct data type
                try {
                    int requestid = Integer.parseInt(s_requestid);

                    // Retrieve specific house unit record
                    A.retrieve_request(requestid);

                    // Display old values and update form
    %>
                    <form action="complete_maintenance.jsp?action=save" method="post">
                        <input type="hidden" name="action" value="save">
                        <!-- Display old values -->
                        <p>Request ID: <%= A.requestid %></p>
                        <p>Date Requested: <%= A.daterequested %></p>
                        <p>Request Status: <%= A.requeststatus %></p>
                        <p>Property ID: <%= A.propertyid %></p>
                        <p>Type of Work: <%= A.typeofwork %></p>
                        <!-- Add other fields as needed -->
                        
                        <p>Assign Officer and Maintenance Personnel</p> <br>

                        <!-- Input fields for updates -->
                        <!-- For example, to update propertytype -->
                        
                        <label for="requeststatus">Update Status:</label>
                        <select id="requeststatus" name="requeststatus">
                           <option value= "Completed" >Completed</option>
                           <option value= "Cancelled" >Canceled</option>
                           <option value= "Denied" >Denied</option>
                           <!-- Add other property types as needed -->
                        </select><br>

                        <!-- Add other input fields for updates as needed -->

                        <!-- Buttons -->
                        <input type="submit" value="save">
                        <a href="maintenance.html">Cancel</a>
                    </form>
    <%
                } catch (NumberFormatException e) {
    %>
                    <p>Input values must be in the correct data type. <a href="updatemaintenance.jsp">Go back</a></p>
    <%
                }
            }
        } else if ("save".equals(action)) {
            String s_requestid = request.getParameter("requestid");
            // Retrieve updated values from form parameters
            // Example: String s_newPropertyType = request.getParameter("propertytype");
            // A.propertytype = Integer.parseInt(s_newPropertyType);
            
            String v_requeststatus = request.getParameter("requeststatus");
            A.requeststatus = v_requeststatus;
            // Save updated data to the database
            int updateStatus = A.complete_request();
            //int propertyid = Integer.parseInt(s_propertyid);
    
            //A.retrieve_houseunit(propertyid);

            if (updateStatus >= 1) {
    %>
                <p>Update successful!</p>
                <!-- Display old and new values if needed -->
                <h1>Updated Maintenance Record</h1>

                    <table border="1">
                    <tr>
                        <th>Field</th>
                        <th>Data</th>
                    </tr>
                    <tr>
                        <td>Request ID</td>
                        <td><%= A.getRequestid() %></td>
                    </tr>
                    <tr>
                        <td>Date Requested</td>
                        <td><%= A.getDaterequested() %></td>
                    </tr>
                    <tr>
                        <td>Date Fulfilled</td>
                        <td><%= A.getDatefulfilled() %></td>
                    </tr>
                    <tr>
                        <td>Request Status</td>
                        <td><%= A.getRequeststatus() %></td>
                    </tr>
                    <tr>
                        <td>Property ID</td>
                        <td><%= A.getPropertyid() %></td>
                    </tr>
                    <tr>
                        <td>Personnel</td>
                        <td><%= A.getPersonnelid() %></td>
                    </tr>
                    <tr>
                        <td>Officer</td>
                        <td><%= A.getOfficerid() %></td>
                    </tr>
                    <tr>
                        <td>Type of Work</td>
                        <td><%= A.getTypeofwork() %></td>
                    </tr>
                    <!-- Add other fields as needed -->
                </table>
                
                <a href="maintenance.html">Back to Main Menu</a>
                <a href="updatehousing.html">Update Another House Unit</a>
    <%
            } else {
    %>
                <p>Update failed. <a href="maintenance.html">Back to Main Menu</a></p>
    <%
            }
        }
    %>
</body>
</html>

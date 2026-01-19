<%-- 
    Document   : update_housingunit
    Created on : 11 22, 23, 3:24:11 AM
    Author     : ccslearner
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, HousingUnit.JHousingUnit" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Housing Unit</title>
</head>
<body>
    <jsp:useBean id="A" class="HousingUnit.JHousingUnit" scope="session"/>

    <%
        String action = request.getParameter("action");
     %>   
 
      <%  
        if ("retrieve".equals(action)) {
            // Retrieve form parameters
            String s_propertyid = request.getParameter("propertyid");
            

            // Check if both values are provided
            if (s_propertyid == null  || s_propertyid.isEmpty()) {
    %>
                <p>Property ID is required. <a href="updatehousing.html">Go back</a></p>
    <%
            } else {
                // Check if values are of the correct data type
                try {
                    int propertyid = Integer.parseInt(s_propertyid);

                    // Retrieve specific house unit record
                    A.retrieve_houseunit(propertyid);

                    // Display old values and update form
    %>
                    <form action="update_housingunit.jsp?action=save" method="post">
                        <input type="hidden" name="action" value="save">
                        <!-- Display old values -->
                        <p>Old Property ID: <%= A.propertyid %></p>
                        <p>Old Member ID: <%= A.memberid %></p>
                        <p>Old Block No: <%= A.blockno %></p>
                        <p>Old Lot No: <%= A.lotno %></p>
                        <p>Old Street Name: <%= A.streetname %></p>
                        <p>Old Barangay: <%= A.barangay %></p>
                        <p>Old City: <%= A.city %></p>
                        <p>Old Province: <%= A.province %></p>
                        <p>Old Region: <%= A.region %></p>
                        <p>Old Zip Code: <%= A.zipcode %></p>
                        <p>Old Property Type: <%= A.propertytype %></p>
                        <p>Old Property Status: <%= A.propertyStatus %></p>
                        <p>Old Lot Size: <%= A.lotsize %></p> <br>
                        <!-- Add other fields as needed -->
                        
                        <p>Updatable Fields: Member ID (Owner) and Property Status</p> <br>

                        <!-- Input fields for updates -->
                        <!-- For example, to update propertytype -->
                        
                        <label for="memberid">New Owner:</label>
                        <input type="text" id="memberid" name="memberid" required pattern="\d+" title="Please enter a valid integer for Owner" ><br>
                        
                        <label for="propertyStatus">New Property Status:</label>
                        <select id="propertyStatus" name="propertyStatus">
                            <option value= "Active" >Active</option>
                            <option value= "Inactive" >Inactive</option>
                            <!-- Add other property types as needed -->
                        </select><br>

                        <!-- Add other input fields for updates as needed -->

                        <!-- Buttons -->
                        <input type="submit" value="save">
                        <a href="housing.html">Cancel</a>
                    </form>
    <%
                } catch (NumberFormatException e) {
    %>
                    <p>Input must be correct data type <a href="updatehousing.html">Go back</a></p>
    <%
                }
            }
        } else if ("save".equals(action)) {
            String s_propertyid = request.getParameter("propertyid");
            // Retrieve updated values from form parameters
            // Example: String s_newPropertyType = request.getParameter("propertytype");
            // A.propertytype = Integer.parseInt(s_newPropertyType);
            int v_memberid = Integer.parseInt(request.getParameter("memberid")); //parameter should be same with id in html
            A.memberid = v_memberid;

            //place validation for member id if exist

            String v_propertyStatus = request.getParameter("propertyStatus");
            A.propertyStatus = v_propertyStatus;

            // Save updated data to the database
            int updateStatus = A.update_houseunit();
            //int propertyid = Integer.parseInt(s_propertyid);
    
            //A.retrieve_houseunit(propertyid);

            if (updateStatus >= 1) {
    %>
                <p>Update successful!</p>
                <!-- Display old and new values if needed -->
                <h1>Updated Housing Unit Record</h1>

                    <table border="1">
                    <tr>
                        <th>Field</th>
                        <th>Old Value</th>
                        <th>New Value</th>
                    </tr>
                    <tr>
                        <td>Property ID</td>
                        <td><%= A.getoldpropertyID() %></td>
                        <td><%= A.getpropertyID() %></td>
                    </tr>
                    <tr>
                        <td>Member ID</td>
                        <td><%= A.getoldmemberID() %></td>
                        <td><%= A.getmemberID() %></td>
                    </tr>
                    <tr>
                        <td>Block No</td>
                        <td><%= A.getoldblockNO() %></td>
                        <td><%= A.getblockNO() %></td>
                    </tr>
                    <tr>
                        <td>Lot No</td>
                        <td><%= A.getoldlotNO() %></td>
                        <td><%= A.getlotNO() %></td>
                    </tr>
                    <tr>
                        <td>Street Name</td>
                        <td><%= A.getoldStreetname() %></td>
                        <td><%= A.getStreetname() %></td>
                    </tr>
                    <tr>
                        <td>Barangay</td>
                        <td><%= A.getoldBarangay() %></td>
                        <td><%= A.getBarangay() %></td>
                    </tr>
                    <tr>
                        <td>City</td>
                        <td><%= A.getoldcity() %></td>
                        <td><%= A.getcity() %></td>
                    </tr>
                    <tr>
                        <td>Province</td>
                        <td><%= A.getoldprovince() %></td>
                        <td><%= A.getprovince() %></td>
                    </tr>
                    <tr>
                        <td>Region</td>
                        <td><%= A.getoldregion() %></td>
                        <td><%= A.getregion() %></td>
                    </tr>
                    <tr>
                        <td>Zip Code</td>
                        <td><%= A.getoldzipcode() %></td>
                        <td><%= A.getzipcode() %></td>
                    </tr>
                    <tr>
                        <td>Property Type</td>
                        <td><%= A.getoldpropertytype() %></td>
                        <td><%= A.propertytype %></td>
                    </tr>
                    <tr>
                        <td>Property Status</td>
                        <td><%= A.getoldpropertystatus() %></td>
                        <td><%= A.propertyStatus %></td>
                    </tr>
                    <tr>
                        <td>Lot Size</td>
                        <td><%= A.getoldlotsize() %></td>
                        <td><%= A.getlotsize() %></td>
                    </tr>
                    <!-- Add other fields as needed -->
                </table>
                
                <a href="housing.html">Back to Main Menu</a>
                <a href="updatehousing.html">Update Another House Unit</a>
    <%
            } else {
    %>
                <p>Update failed. <a href="housing.html">Back to Main Menu</a></p>
    <%
            }
        }
    %>
</body>
</html>

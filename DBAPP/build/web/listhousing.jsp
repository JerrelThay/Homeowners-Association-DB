<%-- 
    Document   : listhousing
    Created on : 11 22, 23, 3:13:06 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*, HousingUnit.JHousingUnit" %>
<!DOCTYPE html>

<%
    // Retrieve parameters from the request
    String streetnameParam = request.getParameter("streetname");
    String cityParam = request.getParameter("city");
    String propertytypeParam = request.getParameter("propertytype");
    String propertyStatusParam = request.getParameter("propertyStatus");

    // Perform the search using the Java class
    List<JHousingUnit> housingList = JHousingUnit.list_housingunit(streetnameParam, cityParam, propertytypeParam, propertyStatusParam);
    // Extract distinct nationalities from the memberList using a Set
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Housing Unit</title>
    </head>
    <body>
        <form action="list_housingunit.jsp" method="post">
        

        <label for="streetname">Street Name:</label>
       	<input type="text" id="streetname" name="streetname"><br>
        
        <label for="city">City:</label>
       	<input type="text" id="city" name="city"><br>

        <label for="propertytype">Property Type:</label>
        <select id="propertytype" name="propertytype">
           <option value= "" >Select a Type</option>
           <option value= "House"<%= "House".equals(propertytypeParam) ? "selected" : "" %>>House</option>
           <option value= "Town House"<%= "Town House".equals(propertytypeParam) ? "selected" : "" %> >Town House</option>
           <option value= "Condo"<%= "Condo".equals(propertytypeParam) ? "selected" : "" %> >Condo</option>
           <option value= "Apartment"<%= "Apartment".equals(propertytypeParam) ? "selected" : "" %> >Apartment</option>
           <!-- Add other property types as needed -->
        </select><br>
        
        <label for="propertyStatus">Property Status:</label>
        <select id="propertyStatus" name="propertyStatus">
            <option value= "" >Select a Status</option>
            <option value= "Active"<%= "Active".equals(propertyStatusParam) ? "selected" : "" %> >Active</option>
            <option value= "Inactive"<%= "Active".equals(propertyStatusParam) ? "selected" : "" %> >Inactive</option>
            <!-- Add other property types as needed -->
        </select><br>

        <button type="submit" name="action" value="search">Search</button>
        <a href="housing.html">Go Back to Main</a>
    </form>
    </body>
</html>

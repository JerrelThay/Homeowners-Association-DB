<%-- 
    Document   : listmaintenance
    Created on : 11 22, 23, 3:13:46 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="MaintenanceRequest.JMaintenanceRequest" %>
<!DOCTYPE html>

<%
    // Retrieve parameters from the request
    String requeststatusParam = request.getParameter("requeststatus");
    String typeofworkParam = request.getParameter("typeofwork");

    // Perform the search using the Java class
    List<JMaintenanceRequest> maintenanceList = JMaintenanceRequest.list_maintenance(requeststatusParam,typeofworkParam);
    // Extract distinct nationalities from the memberList using a Set
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Maintenance</title>
    </head>
    <body>
        <form action="list_maintenance.jsp" method="post">

        <label for="requeststatus">Request Status:</label>
        <select id="requeststatus" name="requeststatus">
           <option value= "" >Select a Status</option>
           <option value= "Requested"<%= "Requested".equals(requeststatusParam) ? "selected" : "" %>>Requested</option>
           <option value= "On-going"<%= "On-going".equals(requeststatusParam) ? "selected" : "" %> >On-going</option>
           <option value= "Completed"<%= "Completed".equals(requeststatusParam) ? "selected" : "" %> >Completed</option>
           <option value= "Cancelled"<%= "Cancelled".equals(requeststatusParam) ? "selected" : "" %> >Cancelled</option>
           <option value= "Denied"<%= "Denied".equals(requeststatusParam) ? "selected" : "" %> >Denied</option>
           <!-- Add other property types as needed -->
        </select><br>
        
        <label for="typeofwork">Type of Work:</label>
        <select id="typeofwork" name="typeofwork">
            <option value= "" >Select a Type</option>
            <option value= "Plumbing"<%= "Plumbing".equals(typeofworkParam) ? "selected" : "" %> >Plumbing</option>
            <option value= "Electrical"<%= "Electrical".equals(typeofworkParam) ? "selected" : "" %> >Electrical</option>
            <option value= "Carpentry"<%= "Carpentry".equals(typeofworkParam) ? "selected" : "" %> >Carpentry</option>
            <option value= "Gardening"<%= "Gardening".equals(typeofworkParam) ? "selected" : "" %> >Gardening</option>
            <option value= "Others"<%= "Others".equals(typeofworkParam) ? "selected" : "" %> >Others</option>
            <!-- Add other property types as needed -->
        </select><br>

        <button type="submit" name="action" value="search">Search</button>
        <a href="maintenance.html">Go Back to Main</a>
        
        </form>
    </body>
</html>

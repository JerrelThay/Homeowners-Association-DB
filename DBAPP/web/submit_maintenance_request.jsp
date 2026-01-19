<%-- 
    Document   : submit_maintenance_request
    Created on : 11 22, 23, 3:22:04 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Housing Processing</title>
    </head>
    <body>
        <jsp:useBean id = 'A' class = "MaintenanceRequest.JMaintenanceRequest" scope = "session"/> <%-- class is not final --%>
        <%
            int wrong = 0;
            int status = 0;
            try{
                String s_daterequested = request.getParameter("daterequested");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date v_daterequested = dateFormat.parse(s_daterequested);
                A.daterequested = v_daterequested;

                int v_propertyid = Integer.parseInt(request.getParameter("propertyid")); //parameter should be same with id in html
                A.propertyid = v_propertyid;

                String v_typeofwork = request.getParameter("typeofwork");
                A.typeofwork = v_typeofwork;
            }catch(NumberFormatException e){
                wrong = 1;
                %>
                <h1> Wrong Input</h1>              
          <%  }
            
            
            if (wrong == 0){
                status = A.registerMaintenanceRequest();
            }
            if (status == 1){  
        %>
        <h1> Request Successful</h1>
        <h1>Maintenance Request Record</h1>
                <p>Request ID: <%= A.getRequestid() %></p>
                <p>Date Requested: <%= A.getDaterequested() %></p>
                <p>Request Status: <%= A.getRequeststatus() %></p>
                <p>Property ID: <%= A.getPropertyid() %></p>
                <p>Maintenance Personnel: <%= A.getPersonnelid() %></p>
                <p>Officer : <%= A.getOfficerid() %></p>
                
                <a href="submitmaintenance.html"> Request Again</a>
                <a href="maintenance.html"> Back to Main Menu</a>
        <% }else{
        %>
	<h1> Request Failed</h1>
        <a href="maintenance.html"> Request Again</a>
        <% } %>
    </body>
</html>


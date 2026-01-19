<%-- 
    Document   : create_officer
    Created on : 11 22, 23, 3:29:48 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Community Officer</title>
    </head>
    <body>
        <jsp:useBean id = 'A' class = "CommunityOfficer.JCommunityOfficer" scope = "session"/>
        <%
            int v_officerid = Integer.parseInt(request.getParameter("officerid")); //parameter should be same with id in html
            A.officerid = v_officerid;
            
            int v_memberid = Integer.parseInt(request.getParameter("memberid"));
            A.memberid = v_memberid;
            
            String v_position = request.getParameter("position");
            A.position = v_position;
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
            String termstartStr = request.getParameter("termstart");
            Date v_termstart = dateFormat.parse(termstartStr);
            A.termstart = v_termstart;
            
            String termendStr = request.getParameter("termend");           
            Date v_termend = dateFormat.parse(termendStr);
            A.termend = v_termend;

            int status = A.create_communityofficer();
            if (status == 1){  
        %>
        
        <h1>Registering New Community Officer Successful</h1>
        <h1>New Community Officer Record Saved</h1>
                <p>Officer ID: <%= A.getOfficerID() %></p>
                <p>Member ID: <%= A.getMemberID() %></p>
                <p>Position: <%= A.getPosition() %></p>
                <p>Term Start: <%= A.getTermStart() %></p>
                <p>Term End <%= A.getTermEnd() %></p>
        <a href="createofficer.html"> Register Again </a>
        <a href="officer.html"> Back to Main Menu</a>
        
        <% }else{ %> 
	<h1>Registering New Community Officer Failed </h1>
        <a href="officer.html"> Back to Main Menu</a>
        <% } %>
        
    </body>
</html>
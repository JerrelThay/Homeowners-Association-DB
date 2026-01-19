<%-- 
    Document   : creatememberprocessing
    Created on : 11 21, 23, 2:33:45 PM
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
        <title>Register Member Processing</title>
    </head>
    <body>
        <jsp:useBean id = 'A' class = "CommunityMember.JCommunityMember" scope = "session"/>
        <%
            String v_memberlastname = request.getParameter("memberlastname");
            A.memberlastname = v_memberlastname;
            
            String v_memberfirstname = request.getParameter("memberfirstname");
            A.memberfirstname = v_memberfirstname;
            
            String v_mobileno = request.getParameter("mobileno");
            A.mobileno = v_mobileno;
            
            String v_email = request.getParameter("email");
            A.email = v_email;
            
            String birthdateStr = request.getParameter("birthdate");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date v_birthdate = dateFormat.parse(birthdateStr);
            A.birthdate = v_birthdate;
            
            String v_gender = request.getParameter("gender");
            A.gender = v_gender;
            
            String moveindateStr = request.getParameter("moveindate");
            Date v_moveindate = dateFormat.parse(moveindateStr);
            A.moveindate = v_moveindate;
            
            String v_nationality = request.getParameter("nationality");
            A.nationality = v_nationality;
                    
            int status = A.create_communitymember();
            if (status == 1){  
        %>
        <h1> Registering Community Member Successful</h1>
        <h1>New Community Member Record Saved:</h1>
                <p>Member ID: <%= A.getmemberID() %></p>
                <p>Last Name: <%= A.getMemberlastname() %></p>
                <p>First Name: <%= A.getMemberfirstname() %></p>
                <p>Mobile Number: <%= A.getMobileno() %></p>
                <p>Email: <%= A.getEmail() %></p>
                <%
                     SimpleDateFormat outputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                     String formattedBirthdate = outputDateFormat.format(A.getBirthdate());
                %>
                <p>Birth Day: <%= formattedBirthdate %></p>
                <p>Gender: <%= A.getGender() %></p>
                <%
                     String formattedMoveindate = outputDateFormat.format(A.getMoveindate());
                %>
                <p>Birth Day: <%= formattedMoveindate %></p>
                <p>Nationality: <%= A.getNationality() %></p>
        
        <a href="createmember.html"> Register Another Community Member</a><br>
        <a href="member.html"> Go Back to Functions</a>
        
        <% }else{
        %>
	<h1> Registering Community Member Failed</h1>
        <a href="member.html"> Go Back to Functions</a>
        <% } %>
    </body>
</html>

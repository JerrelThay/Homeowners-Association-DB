
<%-- 
    Document   : updatememberprocessing
    Created on : 11 21, 23, 2:45:26 PM
    Author     : ccslearner
--%>
<%-- 
    Document   : update_communitymember
    Created on : 11 20, 23, 6:35:18 AM
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
    <title>Update Community Member Record</title>
</head>
<body>
    <jsp:useBean id="A" class="CommunityMember.JCommunityMember" scope="session"/>

    <%
        String action = request.getParameter("action");

        if ("retrieve".equals(action)) {
            // Retrieve form parameters
            String s_memberid = request.getParameter("memberid");

            // Check if both values are provided
            if (s_memberid == null || s_memberid.isEmpty()) {
    %>
                <p> Member ID is required. <a href="updatememberprocessing.jsp">Go back</a></p>
    <%
            } else {
                // Retrieve specific house unit record
                int memberid = Integer.parseInt(s_memberid);
                A.retrieve_communitymember(memberid);

                // Display old values and update form
    %>
                <form action="updatememberprocessing.jsp?action=save" method="post">
                    <!-- Display old values -->
                    <p>Old Member ID: <%= A.memberid %></p>
                    <p>Old Last Name: <%= A.memberlastname %></p>
                    <p>Old First Name: <%= A.memberfirstname %></p>
                    <p>Old Mobile Number: <%= A.mobileno %></p>
                    <p>Old Email: <%= A.email %></p>
                    <p>Old Birth Day: <%= A.birthdate %></p>
                    <p>Old Gender: <%= A.gender %></p>
                    <p>Old Move in date: <%= A.moveindate %></p>
                    <p>Old Nationality: <%= A.nationality %></p>

                    <!-- Add other fields as needed -->

                    <p>Unchangeable Fields: Member ID and Birth Day</p> <br>

                    <!-- Input fields for updates -->
                    <label for="memberlastname">New Last Name (First Letter Must Be Capitalized):</label>
                    <input type="text" id="memberlastname" name="memberlastname"><br>

                    <label for="memberfirstname">New First Name (First Letter Must Be Capitalized):</label>
                    <input type="text" id="memberfirstname" name="memberfirstname"><br>

                    <label for="mobileno">New Mobile Number:</label>
                    <input type="text" id="mobileno" name="mobileno"><br>

                    <label for="email">New Email:</label>
                    <input type="text" id="email" name="email"><br>

                    <label for="gender">New Gender:</label>
                    <select id="gender" name="gender">
                        <option value=""></option>
                        <option value= "Male" >Male</option>
                        <option value= "Female" >Female</option>
                        <option value= "Not Specified" >Not Specified</option>
                        <!-- Add other property types as needed -->
                    </select><br>

                    <label for="moveindate">New Move in Date:</label>
                    <input type="date" id="email" name="moveindate"><br>

                    <label for="nationality">New Nationality (First Letter Must Be Capitalized):</label>
                    <input type="text" id="nationality" name="nationality"><br>

                    <!-- Add other input fields for updates as needed -->

                    <!-- Buttons -->
                    <input type="submit" value="Save">
                    <a href="member.html">Cancel</a>
                </form>
    <%
            }
        } else if ("save".equals(action)) {
 
            String v_memberlastname = request.getParameter("memberlastname");
            A.memberlastname = (v_memberlastname != null && !v_memberlastname.isEmpty()) ? v_memberlastname : A.memberlastname;
            
            String v_memberfirstname = request.getParameter("memberfirstname");
            A.memberfirstname = (v_memberlastname != null && !v_memberfirstname.isEmpty()) ? v_memberfirstname : A.memberfirstname;
            
            String v_mobileno = request.getParameter("mobileno");
            A.mobileno = (v_mobileno != null && !v_mobileno.isEmpty()) ? v_mobileno : A.mobileno;
            
            String v_email = request.getParameter("email");
            A.email = (v_email != null && !v_email.isEmpty()) ? v_email : A.email;

            String v_gender = request.getParameter("gender");
            A.gender = (v_gender != null && !v_gender.isEmpty()) ? v_gender : A.gender;
            
            String moveindateStr = request.getParameter("moveindate");
            if (moveindateStr != null && !moveindateStr.isEmpty()) {
                SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date v_moveindate = inputDateFormat.parse(moveindateStr);
                A.moveindate = v_moveindate;
            } else {
              // Retain the old value if no new value is provided
                A.moveindate = A.moveindate;
            }
            
            String v_nationality = request.getParameter("nationality");
            A.nationality = (v_nationality != null && !v_nationality.isEmpty()) ? v_nationality : A.nationality;
            

            // Save updated data to the database
            boolean updateStatus = A.update_communitymember();

            if (updateStatus) {
    %>
                <p>Update successful!</p>
    <!-- Display old and new values -->
    <h1>Updated Community Member Record</h1>
    <table border="1">
        <tr>
            <th>Field</th>
            <th>Old Value</th>
            <th>New Value</th>
        </tr>
        <tr>
            <td>Member ID</td>
            <td><%= A.getmemberID() %></td>
            <td><%= A.getmemberID() %></td>
        </tr>
        <tr>
            <td>Last Name</td>
            <td><%= A.oldmemberlastname %></td>
            <td><%= A.memberlastname %></td>
        </tr>
        <tr>
            <td>First Name</td>
            <td><%= A.oldmemberfirstname %></td>
            <td><%= A.memberfirstname %></td>
        </tr>
        <tr>
            <td>Mobile Number</td>
            <td><%= A.oldmobileno %></td>
            <td><%= A.mobileno %></td>
        </tr>
        <tr>
            <td>Email</td>
            <td><%= A.oldemail %></td>
            <td><%= A.email %></td>
        </tr>
        <tr>
            <td>Birth Day</td>
            <td><%= A.getBirthdate() %></td>
            <td><%= A.getBirthdate() %></td>
        </tr>
        <tr>
            <td>Gender</td>
            <td><%= A.oldgender %></td>
            <td><%= A.gender %></td>
        </tr>
        <tr>
            <td>Move in Date</td>
            <td><%= A.oldmoveindate %></td>
            <td><%= new SimpleDateFormat("yyyy-MM-dd").format(A.getMoveindate()) %></td>
        </tr>
        <tr>
            <td>Nationality</td>
            <td><%= A.oldnationality %></td>
            <td><%= A.nationality %></td>
        </tr>
        <!-- Add other fields as needed -->
    </table>
                                
                <a href="updatemember.html">Update Another Record</a><br>
                <a href="member.html">Go Back to Functions</a>
    <%
            } else {
    %>
                <p>Update Failed. <a href="member.html">Go Back to Functions</a></p>
    <%
            }
        }
    %>
</body>
</html>


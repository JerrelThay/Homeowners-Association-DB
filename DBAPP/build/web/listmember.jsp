<%-- 
    Document   : searchmember
    Created on : 11 21, 23, 3:48:28 PM
    Author     : ccslearner
--%>
<%@ page import="java.util.*" %>
<%@ page import="CommunityMember.JCommunityMember" %>

<%
    // Retrieve parameters from the request
    String lastnameParam = request.getParameter("lastname");
    String firstnameParam = request.getParameter("firstname");
    String genderParam = request.getParameter("gender");
    String nationalityParam = request.getParameter("nationality");

    // Perform the search using the Java class
    List<JCommunityMember> memberList = JCommunityMember.list_communitymember(lastnameParam, firstnameParam, genderParam, nationalityParam);
    // Extract distinct nationalities from the memberList using a Set
    Set<String> uniqueNationalities = new HashSet<>();
    for (JCommunityMember member : memberList) {
        uniqueNationalities.add(member.getNationality());
    }
    
    Set<String> uniqueLastNames = new HashSet<>();
    for (JCommunityMember member : memberList) {
        uniqueLastNames.add(member.getMemberlastname());
    }
    
    Set<String> uniqueFirstNames = new HashSet<>();
    for (JCommunityMember member : memberList) {
        uniqueFirstNames.add(member.getMemberfirstname());
    }
%>

<html>
<head>
    <title>List Community Member Records</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <form action="listmemberprocessing.jsp" method="post">
       <label for="memberlastname">Last Name:</label>
        <select id="memberlastname" name="memberlastname">
            <option value="">Select Last Name</option>
            <%-- Populate this dropdown with nationalities retrieved from the Set --%>
            <% 
                for (String memberlastname : uniqueLastNames) {
            %>
                <option value="<%= memberlastname %>" <%= memberlastname.equals(lastnameParam) ? "selected" : "" %>><%= memberlastname %></option>
            <%
                }
            %>
        </select><br>

        <label for="memberfirstname">First Name:</label>
        <select id="memberfirstname" name="memberfirstname">
            <option value="">Select First Name</option>
            <%-- Populate this dropdown with nationalities retrieved from the Set --%>
            <% 
                for (String memberfirstname : uniqueFirstNames) {
            %>
                <option value="<%= memberfirstname %>" <%= memberfirstname.equals(firstnameParam) ? "selected" : "" %>><%= memberfirstname %></option>
            <%
                }
            %>
        </select><br>

        <label for="gender">Gender:</label>
        <select id="gender" name="gender">
            <option value=""></option>
            <option value="Male" <%= "Male".equals(genderParam) ? "selected" : "" %>>Male</option>
            <option value="Female" <%= "Female".equals(genderParam) ? "selected" : "" %>>Female</option>
            <option value="Not Specified" <%= "Not Specified".equals(genderParam) ? "selected" : "" %>>Not Specified</option>
            <!-- Add other gender options as needed -->
        </select><br>

        <label for="nationality">Nationality:</label>
        <select id="nationality" name="nationality">
            <option value="">Select Nationality</option>
            <%-- Populate this dropdown with nationalities retrieved from the Set --%>
            <% 
                for (String nationality : uniqueNationalities) {
            %>
                <option value="<%= nationality %>" <%= nationality.equals(nationalityParam) ? "selected" : "" %>><%= nationality %></option>
            <%
                }
            %>
        </select><br>

        <a href="member.html"> Go Back to Functions</a>
        <button type="submit" name="action" value="search">Search</button>
    </form>
</body>
</html>

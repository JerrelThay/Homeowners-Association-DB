<%-- 
    Document   : register_housingunit
    Created on : 11 22, 23, 3:17:35 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Housing Processing</title>
    </head>
    <body>
        <jsp:useBean id = 'A' class = "HousingUnit.JHousingUnit" scope = "session"/> <%-- class is not final --%>
        <%
            int wrong = 0;
            int status = 0;
            try{
                int v_memberid = Integer.parseInt(request.getParameter("memberid")); //parameter should be same with id in html
                A.memberid = v_memberid;

                int v_blockno = Integer.parseInt(request.getParameter("blockno"));
                A.blockno = v_blockno;

                int v_lotno = Integer.parseInt(request.getParameter("lotno"));
                A.lotno = v_lotno;

                String v_streetname = request.getParameter("streetname");
                A.streetname = v_streetname;

                String v_barangay = request.getParameter("barangay");
                A.barangay = v_barangay;

                String v_city = request.getParameter("city");
                A.city = v_city;

                String v_province = request.getParameter("province");
                A.province = v_province;

                String v_region = request.getParameter("region");
                A.region = v_region;

                int v_zipcode = Integer.parseInt(request.getParameter("zipcode"));
                A.zipcode = v_zipcode;

                String v_propertytype = request.getParameter("propertytype");
                A.propertytype = v_propertytype;

                double v_lotsize = Double.parseDouble(request.getParameter("lotsize"));
                A.lotsize = v_lotsize;
            }catch(NumberFormatException e){
                wrong = 1;
                %>
                <h1> Wrong Input</h1>              
          <%  }
           
            
            if (wrong == 0){
                status = A.register_houseunit();
            }
            if (status == 1 && wrong == 0){  
        %>
        <h1> Registering Housing Unit Successful</h1>
        <h1>New Housing Unit Record Saved</h1>
                <p>Property ID: <%= A.getpropertyID() %></p>
                <p>Member ID: <%= A.getmemberID() %></p>
                <p>Block No: <%= A.getblockNO() %></p>
                <p>Lot No: <%= A.getlotNO() %></p>
                <p>Street Name: <%= A.getStreetname() %></p>
                <p>Barangay: <%= A.getBarangay() %></p>
                <p>City : <%= A.getcity() %></p>
                <p>Province: <%= A.getprovince() %></p>Back to Main Menu
                <p>Region: <%= A.getregion() %></p>
                <p>ZipCode: <%= A.getzipcode() %></p>
                <p>Property Type: <%= A.getpropertytype() %></p>
                <p>Property Status: <%= A.getpropertystatus() %></p>
                <p>Lot Size: <%= A.getlotsize() %></p>
        <a href="createhousing.html"> Register Again</a>
        <a href="housing.html"> Back to Main Menu</a>
        <% }else{
        %>
	<h1> Registering Housing Unit Failed</h1>
        <a href="createhousing.html"> Register Again</a>
        <% } %>
    </body>
</html>

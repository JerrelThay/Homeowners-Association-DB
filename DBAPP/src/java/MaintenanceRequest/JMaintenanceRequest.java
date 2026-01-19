/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MaintenanceRequest;

import java.sql.*;
import java.util.Date;
import java.util.*;

/**
 *
 * @author ccslearner
 */
public class JMaintenanceRequest {
    
    public int requestid;
    public Date daterequested;
    public Date datefulfilled;
    public String requeststatus;
    public int propertyid;
    public int personnelid;
    public int officerid;
    public String typeofwork;
    
    public int oldrequestid;
    public Date olddaterequested;
    public Date olddatefulfilled;
    public String oldrequeststatus;
    public int oldpropertyid;
    public int oldpersonnelid;
    public int oldofficerid;
    public String oldtypeofwork;

    
    public int registerMaintenanceRequest() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(requestid) + 1 AS newID FROM maintenancerequest"); //place SQL statment here 30mins in the vid
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()){
                requestid = rst.getInt("newID");
            }

            

            // Save record to the database
            pstmt = conn.prepareStatement("INSERT INTO maintenancerequest (requestid, daterequested, datefulfilled, requeststatus, propertyid, personnelid, officerid, typeofwork) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, requestid);
            pstmt.setDate(2, new java.sql.Date(daterequested.getTime()));
            pstmt.setDate(3, datefulfilled != null ? new java.sql.Date(datefulfilled.getTime()) : null);
            requeststatus = "Requested";
            pstmt.setString(4, requeststatus);
            pstmt.setInt(5, propertyid);
            personnelid = 1;
            pstmt.setInt(6, personnelid);
            officerid = 1;
            pstmt.setInt(7, officerid);
            pstmt.setString(8, typeofwork);
            pstmt.executeUpdate();

            pstmt.close();
            conn.close();
            return 1;
        } catch (SQLException e) {
            //e.printStackTrace();
            return 0; // Return a negative value to indicate failure
        }
    }
    
    public int retrieve_request(int requestid) {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT * FROM maintenancerequest WHERE requestid = ?");
            pstmt.setInt(1, requestid);
            ResultSet rst = pstmt.executeQuery();

            if (rst.next()) {
                // Set fields with old values
                ResultSetMetaData metaData = rst.getMetaData();
                int columnCount = metaData.getColumnCount();
                for (int i = 1; i <= columnCount; i++){
                    String columnName = metaData.getColumnName(i);
                    Object value = rst.getObject(i);
                    System.out.println(columnName + ": " + value);
                }
  
                this.requestid = rst.getInt("requestid");
                daterequested = rst.getDate("daterequested");
                datefulfilled = rst.getDate("datefulfilled");
                requeststatus = rst.getString("requeststatus");
                propertyid = rst.getInt("propertyid");
                personnelid = rst.getInt("personnelid");
                officerid = rst.getInt("officerid");
                typeofwork = rst.getString("typeofwork"); 
                
                oldrequestid = this.requestid;
                olddaterequested = daterequested;
                olddatefulfilled = datefulfilled;
                oldrequeststatus = requeststatus;
                oldpropertyid = propertyid;
                oldpersonnelid = personnelid;
                oldofficerid = officerid;
                oldtypeofwork = typeofwork;
            }

            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e) {
            //System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int accept_request() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Validate updated values and set properties

            // Update data in the database
            PreparedStatement pstmt;
            pstmt= conn.prepareStatement("UPDATE maintenancerequest SET requeststatus = ?, personnelid = ?, officerid = ? WHERE requestid = ?");
            requeststatus = "On-going";
            pstmt.setString(1, requeststatus);
            pstmt.setInt(2, personnelid);
            pstmt.setInt(3, officerid);
            pstmt.setInt(4, requestid);
            int updateStatus = pstmt.executeUpdate();
            //conn.commit();

            pstmt.close();
            conn.close();

            return updateStatus; // Indicate success
        } catch (Exception e) {
            //System.out.println(e.getMessage());
            return 0; // Indicate failure
        }
    }

    public int complete_request() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Validate updated values and set properties

            // Update data in the database
            PreparedStatement pstmt;
            pstmt= conn.prepareStatement("UPDATE maintenancerequest SET requeststatus = ?, datefulfilled = CURRENT_DATE() WHERE requestid = ?");
            pstmt.setString(1, requeststatus);
            pstmt.setInt(2, requestid);
            int updateStatus = pstmt.executeUpdate();
            //conn.commit();

            pstmt.close();
            conn.close();

            return 1; // Indicate success
        } catch (Exception e) {
            //System.out.println(e.getMessage());
            return 0; // Indicate failure
        }
    }
    
    public int getRequestid(){
        return requestid;
    }
    
    public Date getDaterequested(){
        return daterequested;
    }
    
    public Date getDatefulfilled(){
        return datefulfilled;
    }
    
    public int getPropertyid(){
        return propertyid;
    }
    
    public String getRequeststatus(){
        return requeststatus;
    }
    
    public String getTypeofwork(){
        return typeofwork;
    }
    
    public int getPersonnelid(){
        return personnelid;
    }
    
    public int getOfficerid(){
        return officerid;
    }
    
    public int getoldRequestid(){
        return oldrequestid;
    }
    
    public Date getoldDaterequested(){
        return olddaterequested;
    }
    
    public Date getoldDatefulfilled(){
        return olddatefulfilled;
    }
    
    public int getoldPropertyid(){
        return oldpropertyid;
    }
    
    public String getoldRequeststatus(){
        return oldrequeststatus;
    }
    
    public String getoldTypeofwwork(){
        return oldtypeofwork;
    }
    
    public int getoldPersonnelid(){
        return oldpersonnelid;
    }
    
    public int getoldOfficerid(){
        return oldofficerid;
    }
    
    private static boolean isNotEmpty(String value) {
        return value != null && !value.isEmpty();
    }
    
    public static List<JMaintenanceRequest> list_maintenance(String requeststatus, String typeofwork) {
            List<JMaintenanceRequest> maintenanceList = new ArrayList<>();

            try {
                Connection conn ;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Construct the SQL query based on provided parameters
            String sql = "SELECT * FROM maintenancerequest WHERE 1=1";

            if (isNotEmpty(requeststatus)) {
                sql += " AND requeststatus = ?";
            }
            
            if (isNotEmpty(typeofwork)) {
                sql += " AND typeofwork = ?";
            }


            PreparedStatement pstmt;
            pstmt = conn.prepareStatement(sql);

            // Set values for the prepared statement based on provided parameters
            int parameterIndex = 1;
            
            if (requeststatus != null && !requeststatus.isEmpty()) {
                pstmt.setString(parameterIndex++, requeststatus);
            }

            if (typeofwork != null && !typeofwork.isEmpty()) {
                pstmt.setString(parameterIndex++, typeofwork);
            }


            // Execute the query
            ResultSet rs;
            rs = pstmt.executeQuery();

            // Process the results and populate the memberList
            while (rs.next()) {
                JMaintenanceRequest MR = new JMaintenanceRequest();
                MR.requestid = rs.getInt("requestid");
                MR.daterequested = rs.getDate("daterequested");
                MR.datefulfilled = rs.getDate("datefulfilled");
                MR.requeststatus = rs.getString("requeststatus");
                MR.propertyid = rs.getInt("propertyid");
                MR.officerid = rs.getInt("officerid");
                MR.typeofwork = rs.getString("typeofwork");
                

                maintenanceList.add(MR);
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return maintenanceList;
    }

    
    public int generateUniqueRequestId(Connection conn) throws SQLException {
        PreparedStatement pstmt;
        pstmt = conn.prepareStatement("SELECT MAX(requestid) + 1 AS newID FROM maintenancerequest");
        ResultSet rst = pstmt.executeQuery();
        int newID = 1;
        if (rst.next()) {
            newID = rst.getInt("newID");
        }
        pstmt.close();
        return newID;
    }
    
    
    
    public static void main(String[] args) {
        JMaintenanceRequest handler = new JMaintenanceRequest();
        int propertyid = 123; // Replace with actual propertyid
        String typeofwork = "Repair"; // Replace with actual typeofwork
        int requestid = handler.registerMaintenanceRequest();

        if (requestid > 0) {
            System.out.println("Maintenance request registered successfully. Request ID: " + requestid);
        } else {
            System.out.println("Failed to register maintenance request.");
        }
    }
    
   
}
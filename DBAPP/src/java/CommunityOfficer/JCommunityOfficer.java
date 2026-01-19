package CommunityOfficer;
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class JCommunityOfficer {
    // Community Officer Fields
    public int officerid;
    public int memberid;
    public String position;
    public Date termstart;
    public Date termend;
    
    // Old Data For Community Officers
    public int oldofficerid;
    public int oldmemberid;
    public String oldposition;
    public Date oldtermstart;
    public Date oldtermend;
    
    // Community Officer Search Fields
    public String sofficerid;
    public String sposition;
    public Date stermstart;
    public Date stermend;
    
    // List of Community Officers
    public ArrayList<Integer> officerid_list = new ArrayList<>();
    public ArrayList<Integer> memberid_list = new ArrayList<>();
    public ArrayList<String>  position_list = new ArrayList<>();
    public ArrayList<String>  termstart_list = new ArrayList<>();
    public ArrayList<String>  termend_list = new ArrayList<>();
    
    public int create_communityofficer(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            // SQL statments go here
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(officerid) + 1 AS newID FROM communityofficer"); 
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()){
                officerid = rst.getInt("newID");
            }
            
            
            pstmt = conn.prepareStatement("INSERT INTO communityofficer (officerid, memberid, position, termstart, termend) VALUES (?, ?, ?, ?, ?)");
            pstmt.setInt(1, officerid);
            pstmt.setInt(2, memberid);
            pstmt.setString(3, position);
            pstmt.setDate(4, new java.sql.Date(termstart.getTime()));
            pstmt.setDate(5, new java.sql.Date(termend.getTime()));
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            System.out.println("Successful");
            return 1;
        }
        
        catch(Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int retrieve_communityofficer(int memberid){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt;
            pstmt= conn.prepareStatement("SELECT * FROM communityofficer WHERE officerid = ?");
            pstmt.setInt(1, officerid);
            ResultSet rst = pstmt.executeQuery();

            if (rst.next()) {
                // Print ALL retrieved values for debugging
                ResultSetMetaData metaData = rst.getMetaData();
                int columnCount = metaData.getColumnCount();
                
                for (int i = 1; i <= columnCount; i++){
                    String columnName = metaData.getColumnName(i);
                    Object value = rst.getObject(i);
                    System.out.println(columnName + ": " + value);
                }

                // Set fields with old values
                oldposition = rst.getString("position");
                oldtermstart = rst.getDate("termstart");
                oldtermend = rst.getDate("termend");
                // Set other fields with old values as needed
            }

            pstmt.close();
            conn.close();
            return 1;
        }
        
        catch (Exception e){
            return 0;
        }
    }
    
    public int update_communityofficer(){
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Validate updated values and set properties

            // Update data in the database
            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("UPDATE communityofficer SET position = ?, termstart = ?, termend = ? WHERE officerid = ?");
            pstmt.setString(1, position);
            pstmt.setDate(2, new java.sql.Date(termstart.getTime()));
            pstmt.setDate(3, new java.sql.Date(termend.getTime()));
            pstmt.setInt(4, officerid);
            pstmt.executeUpdate();
            
            conn.commit();

            pstmt.close();
            conn.close();

            return 1; // Indicate success
        }
        
        catch (Exception e){
            System.out.println(e.getMessage());
            return 0; // Indicate failure
        }
    }
    
    public int retrieve_communityofficerForDeletion(int officerid){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT * FROM communityofficer WHERE officerid = ?");
            pstmt.setInt(1, officerid);
            ResultSet rst = pstmt.executeQuery();

            if (rst.next()) {
                position = rst.getString("position");
                termstart = rst.getDate("termstart");
                termend = rst.getDate("termend");
                // Set other fields as needed

                pstmt.close();
                conn.close();
                return 1;                
            } else {
                pstmt.close();
                conn.close();
                return 0; // Officer not found
            }            
        } 
        
        catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0; // Indicate failure
        }
    }
    
    public int delete_communityofficer(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Check if the community officer is being used in other entities
            if (isUsedinCommunityMember() || isUsedinHousingUnit() || isUsedinRequestID()) {
                return 0; // Cannot delete because the officer is associated with other entities
            }

            // Delete the community officer from the database
            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("DELETE FROM communityofficer WHERE officerid = ?");
            pstmt.setInt(1, officerid);
            int deleteStatus = pstmt.executeUpdate();

            conn.commit();
            pstmt.close();
            conn.close();

            return deleteStatus; // Return the number of rows affected (1 if successful, 0 if not found)
        }

        catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0; // Indicate failure
        }
    }
    
    public ArrayList<HashMap<String, String>> search_communityofficer(){
        ArrayList<HashMap<String, String>> resultsList = new ArrayList<>();

        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            StringBuilder queryBuilder = new StringBuilder("SELECT officerid, position FROM communityofficer WHERE 1=1");

            if (sofficerid != null && !sofficerid.isEmpty()) {
                queryBuilder.append(" AND officerid = ").append(officerid);
            }

            if (sposition != null && !sposition.isEmpty()) {
                queryBuilder.append(" AND position = ").append(position);
            }

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement(queryBuilder.toString());
            ResultSet rst = pstmt.executeQuery();

            while (rst.next()) {
                HashMap<String, String> result = new HashMap<>();
                result.put("officerid", rst.getString("officerid"));
                // result.put("memberid", rst.getString("memberid"));
                result.put("position", rst.getString("position"));
                // result.put("termstart", rst.getString("termstart"));
                // result.put("termend", rst.getString("termend"));
                // Add other fields as needed
                resultsList.add(result);
            }

            pstmt.close();
            conn.close();
        } 
        
        catch (Exception e) {            
            System.out.println(e.getMessage());
        }

        return resultsList;
    }

    
    public boolean isUsedinCommunityMember(){
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM communitymember WHERE memberid = ?");
            pstmt.setInt(1, memberid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0; // If count is greater than 0, memberid is used in communityofficer
            }

            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    public boolean isUsedinHousingUnit(){
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM housingunit WHERE memberid = ?");
            pstmt.setInt(1, memberid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0; // If count is greater than 0, memberid is used in housingunit
            }

            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    
    public boolean isUsedinRequestID(){
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM requestcard WHERE memberid = ?");
            pstmt.setInt(1, memberid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt("count");
                return count > 0; // If count is greater than 0, memberid is used in request
            }

            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public static List<JCommunityOfficer> list_communityofficer(String position) {
            List<JCommunityOfficer> officerList = new ArrayList<>();

            try {
            Connection conn ;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Construct the SQL query based on provided parameters
            String sql = "SELECT * FROM communityofficer WHERE 1=1";

            if (isNotEmpty(position)) {
                sql += " AND position = ?";
            }

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement(sql);

            // Set values for the prepared statement based on provided parameters
            int parameterIndex = 1;

            if (position != null && !position.isEmpty()) {
                pstmt.setString(parameterIndex++, position);
            }

            // Execute the query
            ResultSet rs;
            rs = pstmt.executeQuery();

            // Process the results and populate the list
            while (rs.next()) {
                JCommunityOfficer communityOfficer = new JCommunityOfficer();
                communityOfficer.officerid = rs.getInt("officerid");
                communityOfficer.position = rs.getString("position");
                communityOfficer.termstart = rs.getDate("termstart");
                communityOfficer.termend = rs.getDate("termstart");

                officerList.add(communityOfficer);
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
            
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return officerList;
    }

    private static boolean isNotEmpty(String value) {
        return value != null && !value.isEmpty();
    }    
    
    public void setTermstartFromString(String termstartStr) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
        this.termstart = dateFormat.parse(termstartStr);
    }
    
    public void setTermendFromString(String termendStr) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
        this.termend = dateFormat.parse(termendStr);
    }
    
    public int getOfficerID(){
        return officerid;
    }
    
    public int getMemberID(){
        return memberid;
    }
    
    public String getPosition(){
        return position;
    }
    
     public Date getTermStart() {
        return termstart;
     }
    
     public Date getTermEnd() {
        return termend;
    }
     
    public String getOldPosition(){
        return oldposition;
    }
    
     public Date getOldTermStart() {
        return oldtermstart;
     }
    
     public Date getOldTermEnd() {
        return oldtermend;
    }
     
    public void setOfficerID(String officerid) {
        this.sofficerid = officerid;
    }

    public void setPosition(String position) {
        this.sposition = position;
    }

    public void setTermStart(Date termstart) {
        this.stermstart = termstart;
    }

    public void setTermEnd(Date termend) {
        this.stermend = termend;
    }
}
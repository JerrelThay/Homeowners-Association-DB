package HousingUnit;

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
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.HashSet;

public class JHousingUnit {
    
    //Housing Unit Fields
    public int propertyid;
    public int memberid;
    public int blockno;
    public int lotno;
    public String streetname;
    public String barangay;
    public String city;
    public String province;
    public String region;
    public int zipcode;
    public String propertytype;
    public String propertyStatus;
    public double lotsize;
    
    //Delete field
    public int dpropertyid;
    
    //Maintenance Status
    public int requestid;
    public String requeststatus;
    
    //Old Housing Unit Fields
    public int oldpropertyid;
    public int oldmemberid;
    public int oldblockno;
    public int oldlotno;
    public String oldstreetname;
    public String oldbarangay;
    public String oldcity;
    public String oldprovince;
    public String oldregion;
    public int oldzipcode;
    public String oldpropertytype;
    public String oldpropertyStatus;
    public double oldlotsize;
    
    //Housing Unit Search Fields
    public String spropertyid;
    public String sstreetname;
    public String spropertytype;
    public String spropertyStatus;

    
    //List of Housing Units
    public ArrayList<Integer> propertyid_list = new ArrayList<>();
    public ArrayList<Integer> memberid_list = new ArrayList<>();
    public ArrayList<Integer> blockno_list = new ArrayList<>();
    public ArrayList<Integer> lotno_list = new ArrayList<>();
    public ArrayList<String> streetname_list = new ArrayList<>();
    public ArrayList<String> barangay_list = new ArrayList<>();
    public ArrayList<String> city_list = new ArrayList<>();
    public ArrayList<String> province_list = new ArrayList<>();
    public ArrayList<String> region_list = new ArrayList<>();
    public ArrayList<Integer> zipcode_list = new ArrayList<>();
    public ArrayList<Integer> propertytype_list = new ArrayList<>();
    public ArrayList<Double> lotsize_list = new ArrayList<>();
    
    public int register_houseunit(){
        
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Successful");
            
            //SQL statments go here
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(propertyid) + 1 AS newID FROM housingunit"); //place SQL statment here 30mins in the vid
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()){
                propertyid = rst.getInt("newID");
            }
            
            pstmt = conn.prepareStatement("INSERT INTO housingunit (propertyid, memberid, blockno, lotno, streetname, barangay, city, province, region, zipcode, propertytype, propertyStatus, lotsize) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, propertyid);
            pstmt.setInt(2, memberid);
            pstmt.setInt(3, blockno);
            pstmt.setInt(4, lotno);
            pstmt.setString(5, streetname);
            pstmt.setString(6, barangay);
            pstmt.setString(7, city);
            pstmt.setString(8, province);
            pstmt.setString(9, region);
            pstmt.setInt(10, zipcode);
            pstmt.setString(11, propertytype);
            propertyStatus = "Active";
            pstmt.setString(12, propertyStatus);
            pstmt.setDouble(13, lotsize);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            
            System.out.println("Sucessful");
            return 1;
            
        }catch(Exception e){
            //System.out.println(e.getMessage());
            return 0;
        }
        
    }
    
   
    
    
    public int retrieve_houseunit(int propertyid) {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT * FROM housingunit WHERE propertyid = ?");
            pstmt.setInt(1, propertyid);
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
  
                this.propertyid = rst.getInt("propertyid");
                memberid = rst.getInt("memberid");
                blockno = rst.getInt("blockno");
                lotno = rst.getInt("lotno");
                streetname = rst.getString("streetname");
                barangay = rst.getString("barangay");
                city = rst.getString("city");
                province = rst.getString("province");
                region = rst.getString("region");
                zipcode = rst.getInt("zipcode");
                propertytype = rst.getString("propertytype");
                propertyStatus = rst.getString("propertyStatus");
                lotsize = rst.getDouble("lotsize"); 
                
                oldpropertyid = this.propertyid;
                oldmemberid = memberid;
                oldblockno = blockno;
                oldlotno = lotno;
                oldstreetname = streetname;
                oldbarangay = barangay;
                oldcity = city;
                oldprovince = province;
                oldregion = region;
                oldzipcode = zipcode;
                oldpropertytype = propertytype;
                oldpropertyStatus = propertyStatus;
                oldlotsize = lotsize;
            }

            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e) {
            //System.out.println(e.getMessage());
            return 0;
        }
    }


    
    public int update_houseunit() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Validate updated values and set properties

            // Update data in the database
            PreparedStatement pstmt;
            pstmt= conn.prepareStatement("UPDATE housingunit SET memberid = ?, propertyStatus = ? WHERE propertyid = ?");
            pstmt.setInt(1, memberid);
            pstmt.setString(2, propertyStatus);
            pstmt.setInt(3, propertyid);
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

    public boolean isUsedInMaintenanceRequest() {
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM maintenancerequest WHERE propertyid = ?");
            pstmt.setInt(1, propertyid);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()){
                int count = rs.getInt("count");
                return count > 0;
            }
            
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
            
        // Check if the housing unit is being used in maintenancerequest
        // Return true if used, false otherwise
        return false;  // Replace with actual logic
    }
    
    /*public boolean isHouseActive(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            
            PreparedStatement pstmt;
            pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM housingunit WHERE propertyid = ? AND propertyStatus = ?");
            pstmt.setInt(1, propertyid);
            propertyStatus = "Active";
            pstmt.setString(2, propertyStatus);
            ResultSet rs = pstmt.executeQuery();
            
            if(rs.next()){
                int count = rs.getInt("count");
                if (count >=1){
                    return true;
                }
                
            }
            
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
            
        // Check if the housing unit is being used in maintenancerequest
        // Return true if used, false otherwise
        return false;  // Replace with actual logic
    }*/
    
    
    

    public int delete_houseunit() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            /*if (isUsedinCommunityOfficer() || isUsedinHousingUnit() || isUsedinRequestID()) {
                return 0; // Cannot delete because the member is associated with other entities
            } */
            
            PreparedStatement pstmt; 
            pstmt = conn.prepareStatement("DELETE FROM housingunit WHERE propertyid = ?");
            pstmt.setInt(1, propertyid);
            int deleteStatus = pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return deleteStatus;
        } catch (Exception e) {
            //System.out.println(e.getMessage());
            return 0;
        }
    }

    private static boolean isNotEmpty(String value) {
        return value != null && !value.isEmpty();
    }
    
    public static List<JHousingUnit> list_housingunit(String streetname, String city, String propertytype, String propertyStatus) {
            List<JHousingUnit> houseList = new ArrayList<>();

            try {
                Connection conn ;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Construct the SQL query based on provided parameters
            String sql = "SELECT * FROM housingunit WHERE 1=1";

            if (isNotEmpty(streetname)) {
                sql += " AND streetname = ?";
            }
            
            if (isNotEmpty(city)) {
                sql += " AND city = ?";
            }

            if (isNotEmpty(propertytype)) {
                sql += " AND propertytype = ?";
            }

            if (isNotEmpty(propertyStatus)) {
                sql += " AND propertyStatus = ?";
            }

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement(sql);

            // Set values for the prepared statement based on provided parameters
            int parameterIndex = 1;
            
            if (streetname != null && !streetname.isEmpty()) {
                pstmt.setString(parameterIndex++, streetname);
            }

            if (city != null && !city.isEmpty()) {
                pstmt.setString(parameterIndex++, city);
            }

            if (propertytype != null && !propertytype.isEmpty()) {
                pstmt.setString(parameterIndex++, propertytype);
            }

            if (propertyStatus != null && !propertyStatus.isEmpty()) {
                pstmt.setString(parameterIndex++, propertyStatus);
            }

            // Execute the query
            ResultSet rs;
            rs = pstmt.executeQuery();

            // Process the results and populate the memberList
            while (rs.next()) {
                JHousingUnit HU = new JHousingUnit();
                HU.propertyid = rs.getInt("propertyid");
                HU.memberid = rs.getInt("memberid");
                HU.blockno = rs.getInt("blockno");
                HU.lotno = rs.getInt("lotno");
                HU.streetname = rs.getString("streetname");
                HU.barangay = rs.getString("barangay");
                HU.city = rs.getString("city");
                HU.province = rs.getString("province");
                HU.region = rs.getString("region");
                HU.zipcode = rs.getInt("zipcode");
                HU.propertytype = rs.getString("propertytype");
                HU.propertyStatus = rs.getString("propertyStatus");

                houseList.add(HU);
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return houseList;
    }

   
    
    
    
    public void setMemberid(int memberid){
        this.memberid = memberid;
    }
    
/*
     public ArrayList<HashMap<String, String>> list_housingunits(String sortOrder) {
        ArrayList<HashMap<String, String>> resultsList = new ArrayList<>();

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            StringBuilder queryBuilder = new StringBuilder("SELECT propertyid, lotno, blockno, propertytype FROM HousingUnit WHERE 1=1");

            if (spropertyid != null && !spropertyid.isEmpty()) {
                queryBuilder.append(" AND propertyid = ").append(propertyid);
            }

            if (slotno != null && !slotno.isEmpty()) {
                queryBuilder.append(" AND lotno = ").append(lotno);
            }

            if (sblockno != null && !sblockno.isEmpty()) {
                queryBuilder.append(" AND blockno = ").append(blockno);
            }

            if (spropertytype != null && !spropertytype.isEmpty()) {
                queryBuilder.append(" AND propertytype = ").append(propertytype);
            }

            queryBuilder.append(" ORDER BY propertyid ").append(sortOrder);

            PreparedStatement pstmt = conn.prepareStatement(queryBuilder.toString());
            ResultSet rst = pstmt.executeQuery();

            while (rst.next()) {
                HashMap<String, String> result = new HashMap<>();
                result.put("propertyid", rst.getString("propertyid"));
                result.put("lotno", rst.getString("lotno"));
                result.put("blockno", rst.getString("blockno"));
                result.put("propertytype", rst.getString("propertytype"));
                // Add other fields as needed
                resultsList.add(result);
            }

            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return resultsList;
    }
*/
    public int getpropertyID(){
        return propertyid;
    }
    
    public int getmemberID(){
        return memberid;
    }
    
    public int getblockNO(){
        return blockno;
    }
    
    public int getlotNO(){
        return lotno;
    }
    
    public String getStreetname(){
        return streetname;
    }
    
    public String getBarangay(){
        return barangay;
    }
    
    public String getcity(){
        return city;
    }
    
    public String getprovince(){
        return province;
    }
    
    public String getregion(){
        return region;
    }
    
    public int getzipcode(){
        return zipcode;
    }
    
    public String getpropertytype(){
        return propertytype;
    }
    
    public String getpropertystatus(){
        return propertyStatus;
    }
    
    public double getlotsize(){
        return lotsize;
    }
    
    public int getoldpropertyID(){
        return oldpropertyid;
    }
    
    public int getoldmemberID(){
        return oldmemberid;
    }
    
    public int getoldblockNO(){
        return oldblockno;
    }
    
    public int getoldlotNO(){
        return oldlotno;
    }
    
    public String getoldStreetname(){
        return oldstreetname;
    }
    
    public String getoldBarangay(){
        return oldbarangay;
    }
    
    public String getoldcity(){
        return oldcity;
    }
    
    public String getoldprovince(){
        return oldprovince;
    }
    
    public String getoldregion(){
        return oldregion;
    }
    
    public int getoldzipcode(){
        return oldzipcode;
    }
    
    public String getoldpropertytype(){
        return oldpropertytype;
    }
    
    public String getoldpropertystatus(){
        return oldpropertyStatus;
    }
    
    public double getoldlotsize(){
        return oldlotsize;
    }

    public void setPropertyid(int propertyid) {
        this.propertyid = propertyid;
    }

    public void setStreetname(String streetname) {
        this.streetname = streetname;
    }

    public void setPropertystatus(String propertyStatus) {
        this.propertyStatus = propertyStatus;
    }

    public void setPropertytype(String propertytype) {
        this.propertytype = propertytype;
    }
    
    public static void main(String args[]){
        
        JHousingUnit A = new JHousingUnit();
        //A.propertyid = 102;
        A.memberid = 1;
        A.blockno = 123;
        A.lotno = 213;
        A.streetname = "Lmao";
        A.barangay = "Mari";
        A.city = "Bruh";
        A.province = "Yea";
        A.region = "That";
        A.zipcode = 1220;
        A.propertytype = "With House";
        A.lotsize = 150.642;
        A.register_houseunit();
    }
    
}
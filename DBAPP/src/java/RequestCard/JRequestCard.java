/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package RequestCard;

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class JRequestCard {
    public int cardno;
    public int memberid;
    public String status;
    public String reasondesc;
    public Date requestdate;
    public Date provideddate;
    public int ornumber;
    public double idfee;
    public int officerid;

   
       public int create_requestcard() {        
        try{
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");
                
                //SQL statments go here
                PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(cardno) + 1 AS newID FROM requestcard"); 
                ResultSet rst = pstmt.executeQuery();
                while (rst.next()){
                    cardno = rst.getInt("newID");
                }
                
                // Check if a record with the same memberid and reasondesc already exists
                if (isDuplicateRecord(conn, memberid, reasondesc)) {
                     System.out.println("Duplicate record found. Not creating a new record.");
                    return 0;
                }
                
                // Get the available officer IDs from the database
                List<Integer> availableOfficerIds = getAvailableRegistrarIds(conn);
                // Set default values
                requestdate = new Date(); // Current date
                provideddate = null; // Set to null
                status = "On-going"; // Set to requested
                idfee = 500.00;
                ornumber = generateUniqueORNumber(conn);
                
                 // SQL statements go here         
                pstmt = conn.prepareStatement("INSERT INTO requestcard (cardno, memberid, status, reasondesc, requestdate, provideddate, ornumber, idfee, officerid) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                pstmt.setInt(1, cardno);
                pstmt.setInt(2, memberid);
                pstmt.setString(3, status);
                pstmt.setString(4, reasondesc);
                pstmt.setDate(5, new java.sql.Date(requestdate.getTime()));
                pstmt.setDate(6, (provideddate != null) ? new java.sql.Date(provideddate.getTime()) : null);
                pstmt.setInt(7, ornumber);
                pstmt.setDouble(8, idfee);

                // Select a random officer ID from the available ones
                int randomOfficerId = availableOfficerIds.get(new Random().nextInt(availableOfficerIds.size()));
                officerid = randomOfficerId;
            
                pstmt.setInt(9, officerid);

                pstmt.executeUpdate();

                pstmt.close();
                conn.close();

                System.out.println("Successful");
                return 1;

            }catch(Exception e){
                System.out.println(e.getMessage());
                return 0;
            }

        }
       
    // Helper method to check if a record with the same memberid and reasondesc already exists
    private boolean isDuplicateRecord(Connection conn, int memberId, String reasonDesc) throws SQLException {
        PreparedStatement pstmt;
        pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM requestcard WHERE memberid = ? AND reasondesc = ?");
        pstmt.setInt(1, memberId);
        pstmt.setString(2, reasonDesc);
        ResultSet resultSet = pstmt.executeQuery();
        resultSet.next();
        int count = resultSet.getInt("count");

        pstmt.close();
        return count > 0;
    }
    

    private List<Integer> getAvailableRegistrarIds(Connection conn) throws SQLException {
        List<Integer> registrarIds = new ArrayList<>();
        PreparedStatement pstmt;
        pstmt = conn.prepareStatement("SELECT officerid FROM communityofficer WHERE  position = 'Registrar'");
        ResultSet resultSet = pstmt.executeQuery();

        while (resultSet.next()) {
            registrarIds.add(resultSet.getInt("officerid"));
        }

        pstmt.close();
        return registrarIds;
    }

    // Helper method to generate a unique OR number
    private int generateUniqueORNumber(Connection conn) throws SQLException {
        int uniqueORNumber;

        do {
            uniqueORNumber = new Random().nextInt(1000000) + 1; // Generate a random number (adjust as needed)
        } while (isORNumberExists(conn, uniqueORNumber));

        return uniqueORNumber;
    }

    // Helper method to check if OR number already exists in the database
    private boolean isORNumberExists(Connection conn, int orNumber) throws SQLException {
        PreparedStatement pstmt;
        pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM requestcard WHERE ornumber = ?");
        pstmt.setInt(1, orNumber);
        ResultSet resultSet = pstmt.executeQuery();
        resultSet.next();
        int count = resultSet.getInt("count");

        pstmt.close();
        return count > 0;
    }

        public void setRequestdateFromString(String requestdateStr) throws ParseException {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            this.requestdate = dateFormat.parse(requestdateStr);
        }

        public void setProvideddateFromString(String provideddateStr) throws ParseException {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            this.provideddate = dateFormat.parse(provideddateStr);
        }

        public int getCardno(){
            return cardno;
        }

        public int getmemberID(){
            return memberid;
        }

        public String getStatus(){
            return status;
        }

        public String getReasondesc(){
            return reasondesc;
        }

        public Date getRequestdate(){
            return requestdate;
        }

        public Date getProvideddate() {
            return provideddate;
        }

        public int getORnumber(){
            return ornumber;
        }

        public double getIdfee() {
            return idfee;
        }

        public int getOfficerid(){
            return officerid;
        }
        
        public void retrieve_requestcard(int cardNumber, int memberID) {
            try {
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                // Retrieve the request card from the database
                PreparedStatement pstmt;
                pstmt = conn.prepareStatement("SELECT * FROM requestcard WHERE cardno = ? AND memberid = ?");
                pstmt.setInt(1, cardNumber);
                pstmt.setInt(2, memberID);
                ResultSet resultSet = pstmt.executeQuery();

                if (resultSet.next()) {
                    // Set values in the JRequestCard object
                    this.cardno = resultSet.getInt("cardno");
                    this.memberid = resultSet.getInt("memberid");
                    this.status = resultSet.getString("status");
                    this.reasondesc = resultSet.getString("reasondesc");
                    this.requestdate = resultSet.getDate("requestdate");
                    this.provideddate = resultSet.getDate("provideddate");
                    this.ornumber = resultSet.getInt("ornumber");
                    this.idfee = resultSet.getDouble("idfee");
                    this.officerid = resultSet.getInt("officerid");
                }

                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                System.out.println(e.getMessage());
            }
        }
        
        public boolean cancel_requestcard() {
            try {
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                // Update the status of the request card to "Cancel"
                PreparedStatement pstmt;
                pstmt = conn.prepareStatement("UPDATE requestcard SET status = 'Cancelled' WHERE cardno = ?");
                pstmt.setInt(1, cardno);
                
                pstmt.executeUpdate();

                pstmt.close();
                conn.close();

            return true; 
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false; // Indicate failure
        }
    }
       public boolean validate_requestcard() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Update the status of the request card and modify the provided date if 'Completed' is chosen
            PreparedStatement pstmt;
            
                pstmt = conn.prepareStatement("UPDATE requestcard SET status = 'Completed', provideddate = CURRENT_DATE WHERE cardno = ?");
                pstmt.setInt(1, cardno);
           

            pstmt.executeUpdate();

            pstmt.close();
            conn.close();

            return true; 
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false; // Indicate failure
        }
    }
       
    // Method to list request cards based on request date and provided date criteria
    public static List<JRequestCard> list_requestcard(String requestdate, String provideddate) {
        List<JRequestCard> requestCardList = new ArrayList<>();

        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Construct the SQL query based on provided parameters
            String sql = "SELECT * FROM requestcard WHERE 1=1";

            if (isNotEmpty(requestdate)) {
                sql += " AND requestdate = ?";
            }

            if (isNotEmpty(provideddate)) {
                sql += " AND provideddate = ?";
            }

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement(sql);

            // Set values for the prepared statement based on provided parameters
            int parameterIndex = 1;

            if (requestdate != null && !requestdate.isEmpty()) {
                pstmt.setString(parameterIndex++, requestdate);
            }

            if (provideddate != null && !provideddate.isEmpty()) {
                pstmt.setString(parameterIndex++, provideddate);
            }

            // Execute the query
            ResultSet rs;
            rs = pstmt.executeQuery();

            // Process the results and populate the requestCardList
            while (rs.next()) {
                JRequestCard requestCard = new JRequestCard();
                requestCard.cardno = rs.getInt("cardno");
                requestCard.memberid = rs.getInt("memberid");
                requestCard.status = rs.getString("status");
                requestCard.reasondesc = rs.getString("reasondesc");
                requestCard.requestdate = rs.getDate("requestdate");
                requestCard.provideddate = rs.getDate("provideddate");
                requestCard.ornumber = rs.getInt("ornumber");
                requestCard.idfee = rs.getDouble("idfee");
                requestCard.officerid = rs.getInt("officerid");

                requestCardList.add(requestCard);
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return requestCardList;
    }

    // Utility method to check if a string is not empty
    private static boolean isNotEmpty(String value) {
        return value != null && !value.isEmpty();
    }




}
        
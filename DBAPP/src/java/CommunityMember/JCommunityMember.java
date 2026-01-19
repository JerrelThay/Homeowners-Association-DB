/*
     * To change this license header, choose License Headers in Project Properties.
     * To change this template file, choose Tools | Templates
     * and open the template in the editor.
     */
    package CommunityMember;

    /**
     *
     * @author ccslearner
     */
    import java.util.*;
    import java.sql.*;
    import java.text.ParseException;
    import java.text.SimpleDateFormat;
    import java.util.Date;

    public class JCommunityMember {
        //Community Member Fields
        public int memberid;
        public String memberlastname;
        public String memberfirstname;
        public String mobileno;
        public String email;
        public Date birthdate;
        public String gender;
        public Date moveindate;
        public String nationality;

        public int oldmemberid;
        public String oldmemberlastname;
        public String oldmemberfirstname;
        public String oldmobileno;
        public String oldemail;
        public Date oldbirthdate;
        public String oldgender;
        public Date oldmoveindate;
        public String oldnationality;

         //List of Community Members
        public ArrayList<Integer> memberid_list = new ArrayList<>();
        public ArrayList<String>  memberlastname_list = new ArrayList<>();
        public ArrayList<String>  memberfirstname_list = new ArrayList<>();
        public ArrayList<String> mobileno_list = new ArrayList<>();
        public ArrayList<String>  email_list = new ArrayList<>();
        public ArrayList<String>  birthdate_list = new ArrayList<>();
        public ArrayList<String>  gender_list = new ArrayList<>();
        public ArrayList<String>  moveindate_list = new ArrayList<>();
        public ArrayList<String>  nationality_list = new ArrayList<>();

        public int create_communitymember(){

            try{
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                System.out.println("Connection Successful");

                //SQL statments go here
                PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(memberid) + 1 AS newID FROM communitymember"); 
                ResultSet rst = pstmt.executeQuery();
                while (rst.next()){
                    memberid = rst.getInt("newID");
                }

                pstmt = conn.prepareStatement("INSERT INTO communitymember (memberid, memberlastname, memberfirstname, mobileno, email, birthdate, gender, moveindate, nationality) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
                pstmt.setInt(1, memberid);
                pstmt.setString(2, memberlastname);
                pstmt.setString(3, memberfirstname);
                pstmt.setString(4, mobileno);
                pstmt.setString(5, email);
                pstmt.setDate(6, new java.sql.Date(birthdate.getTime()));
                pstmt.setString(7, gender);
                pstmt.setDate(8, new java.sql.Date(moveindate.getTime()));
                pstmt.setString(9, nationality);
                pstmt.executeUpdate();

                pstmt.close();
                conn.close();

                System.out.println("Sucessful");
                return 1;

            }catch(Exception e){
                System.out.println(e.getMessage());
                return 0;
            }

        }

        public void setBirthdateFromString(String birthdateStr) throws ParseException {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            this.birthdate = dateFormat.parse(birthdateStr);
        }

        public void setMoveindateFromString(String moveindateStr) throws ParseException {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            this.moveindate = dateFormat.parse(moveindateStr);
        }

        public int getmemberID(){
            return memberid;
        }

        public String getMemberlastname(){
            return memberlastname;
        }

        public String getMemberfirstname(){
            return memberfirstname;
        }

        public String getMobileno(){
            return mobileno;
        }

        public String getEmail(){
            return email;
        }

         public Date getBirthdate() {
            return birthdate;
        }

        public String getGender(){
            return gender;
        }

         public Date getMoveindate() {
            return moveindate;
        }

        public String getNationality(){
            return nationality;
        }

        public int retrieve_communitymember(int memberid) {
            try {
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
                PreparedStatement pstmt;
                pstmt= conn.prepareStatement("SELECT * FROM communitymember WHERE memberid = ?");
                pstmt.setInt(1, memberid);
                ResultSet rst = pstmt.executeQuery();

                if (rst.next()) {
                    // Print all retrieved values for debugging
                    ResultSetMetaData metaData = rst.getMetaData();
                    int columnCount = metaData.getColumnCount();
                    for (int i = 1; i <= columnCount; i++) {
                        String columnName = metaData.getColumnName(i);
                        Object value = rst.getObject(i);
                    System.out.println(columnName + ": " + value);
                }

                    // Set fields with old values
                    this.memberid = rst.getInt("memberid");
                    memberlastname = rst.getString("memberlastname");
                    memberfirstname = rst.getString("memberfirstname");
                    mobileno = rst.getString("mobileno");
                    email = rst.getString("email");
                    birthdate = rst.getDate("birthdate");
                    gender = rst.getString("gender");
                    moveindate = rst.getDate("moveindate");
                    nationality = rst.getString("nationality");



                    oldmemberlastname = memberlastname;
                    oldmemberfirstname = memberfirstname ;
                    oldmobileno = mobileno;
                    oldemail = email;
                    oldgender = gender;
                    oldmoveindate = moveindate;
                    oldnationality = nationality;


                    // Set other fields with old values as needed
                }

                pstmt.close();
                conn.close();
                return 1;
            } catch (Exception e) {
                return 0;
            }
        }

        public boolean update_communitymember() {
            try {
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                // Validate updated values and set properties

                // Update data in the database
                PreparedStatement pstmt;
                pstmt = conn.prepareStatement("UPDATE communitymember SET memberlastname = ?, memberfirstname = ?, mobileno = ?, email = ?, gender = ?, moveindate = ?, nationality = ? WHERE memberid = ?");
                pstmt.setString(1, memberlastname);
                pstmt.setString(2, memberfirstname);
                pstmt.setString(3, mobileno);
                pstmt.setString(4, email);
                pstmt.setString(5, gender);
                pstmt.setDate(6, new java.sql.Date(moveindate.getTime()));
                pstmt.setString(7, nationality);
                pstmt.setInt(8,memberid);

                pstmt.executeUpdate();

                pstmt.close();
                conn.close();

                return true; // Indicate success
            } catch (Exception e) {
                System.out.println(e.getMessage());
                return false; // Indicate failure
            }
        }

        public int delete_communitymember() {
            try {
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                // Check if the community member is being used in other entities
                if (isUsedinCommunityOfficer() || isUsedinHousingUnit() || isUsedinRequestCard()) {
                    return 0; // Cannot delete because the member is associated with other entities
                }

                // Delete the community member from the database
                PreparedStatement pstmt;
                pstmt = conn.prepareStatement("DELETE FROM communitymember WHERE memberid = ?");
                pstmt.setInt(1, memberid);
                int deleteStatus = pstmt.executeUpdate();


                pstmt.close();
                conn.close();

                return deleteStatus; // Return the number of rows affected (1 if successful, 0 if not found)
            } catch (SQLException e) {
                System.out.println(e.getMessage());
                return 0; // Indicate failure
            }
        }

        public boolean isUsedinHousingUnit() {
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

            return false; // Indicate failure or an error
        }

        public boolean isUsedinCommunityOfficer() {
            try {
                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

                PreparedStatement pstmt;
                pstmt = conn.prepareStatement("SELECT COUNT(*) AS count FROM communityofficer WHERE memberid = ?");
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

            return false; // Indicate failure or an error
        }

        public boolean isUsedinRequestCard() {
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

            return false; // Indicate failure or an error
        }
        
        public static List<JCommunityMember> list_communitymember(String memberlastname, String memberfirstname, String gender, String nationality) {
            List<JCommunityMember> memberList = new ArrayList<>();

            try {
                Connection conn ;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbcommunity?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");

            // Construct the SQL query based on provided parameters
            String sql = "SELECT * FROM communitymember WHERE 1=1";

            if (isNotEmpty(memberlastname)) {
                sql += " AND memberlastname = ?";
            }

            if (isNotEmpty(memberfirstname)) {
                sql += " AND memberfirstname = ?";
            }

            if (isNotEmpty(gender)) {
                sql += " AND gender = ?";
            }

            if (isNotEmpty(nationality)) {
                sql += " AND nationality = ?";
            }

            PreparedStatement pstmt;
            pstmt = conn.prepareStatement(sql);

            // Set values for the prepared statement based on provided parameters
            int parameterIndex = 1;

            if (memberlastname != null && !memberlastname.isEmpty()) {
                pstmt.setString(parameterIndex++, memberlastname);
            }

            if (memberfirstname != null && !memberfirstname.isEmpty()) {
                pstmt.setString(parameterIndex++, memberfirstname);
            }

            if (gender != null && !gender.isEmpty()) {
                pstmt.setString(parameterIndex++, gender);
            }

            if (nationality != null && !nationality.isEmpty()) {
                pstmt.setString(parameterIndex++, nationality);
            }

            // Execute the query
            ResultSet rs;
            rs = pstmt.executeQuery();

            // Process the results and populate the memberList
            while (rs.next()) {
                JCommunityMember communityMember = new JCommunityMember();
                communityMember.memberid = rs.getInt("memberid");
                communityMember.memberlastname = rs.getString("memberlastname");
                communityMember.memberfirstname = rs.getString("memberfirstname");
                communityMember.mobileno = rs.getString("mobileno");
                communityMember.email = rs.getString("email");
                communityMember.birthdate = rs.getDate("birthdate");
                communityMember.gender = rs.getString("gender");
                communityMember.moveindate = rs.getDate("moveindate");
                communityMember.nationality = rs.getString("nationality");

                memberList.add(communityMember);
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return memberList;
    }

    private static boolean isNotEmpty(String value) {
        return value != null && !value.isEmpty();
    }

}
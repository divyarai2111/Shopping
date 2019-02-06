<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>

<%	
try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Driver Found");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("Driver not Found");
		}
		String url="jdbc:mysql://localhost/database1";
		String user="root";
		String password="";
		Connection con=null;
		Statement stmt = null;
		try {
			con=DriverManager.getConnection(url,user,password);
			System.out.println("Connected sucessfully");
			 
			System.out.println("Creating statement...");
		      stmt = con.createStatement();
		      
		      // home is the table of under proj databse

		      String sql = "SELECT * FROM login";
		      ResultSet rs = stmt.executeQuery(sql);
		      //STEP 5: Extract data from result set
		      while(rs.next()){
		         //Retrieve by column name
		         String user_id  = rs.getString("username");
		         String pass = rs.getString("pass");

		         //Display values
		         System.out.print("User id: " + user_id);
		         System.out.print(",Password: " + pass);
		         System.out.print("\n");
		      }
		      rs.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Connection not sucessfully");
		}
	
%>
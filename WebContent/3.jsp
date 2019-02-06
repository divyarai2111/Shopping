<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.*" %>
<!-- 
//import java.sql.ResultSet;

//import java.sql.Statement;

-->
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
		
		
		
		int count=0;
		try {
			con=DriverManager.getConnection(url,user,password);
			System.out.println("Connected sucessfully");
			
		      stmt = con.createStatement();
		      
		     
String u1=request.getParameter("e1");
		 
String p1=(request.getParameter("p1"));


//this is hash function which generates the hash of the password which the user enters
byte[] unencodedPassword = p1.getBytes();
MessageDigest md = null;
try {
md = MessageDigest.getInstance("MD5");
} catch (Exception e)
{
	System.out.println("Exception in hash");
}
md.reset();
md.update(unencodedPassword);
byte[] encodedPassword = md.digest();
StringBuffer buf=new StringBuffer();
for (int i = 0; i < encodedPassword.length; i++)
{
	if (((int) encodedPassword[i] & 0xff) < 0x10) 
	{
	buf.append("0");	
	}
	buf.append(Long.toString((int) encodedPassword[i] & 0xff, 16));
}
//passw is the hashed password
String passw=buf.toString(); 


String sql = "SELECT * FROM login";
		      ResultSet rs = stmt.executeQuery(sql);
		      //STEP 5: Extract data from result set
		      while(rs.next())
		      {
		         //Retrieve by column name
		         String user_id  = rs.getString("username");
		         String pass = rs.getString("pass");
		        
		         if(user_id.equals(u1)  &&  pass.equals(passw))
		      
		         {
		        	 
		  			count++;
		         }
		        		         
		      
		     
			
		         }
		      
		     // System.out.println("New  "+count);
		      if(count!=0){
		    	  System.out.println("Login succesfull");
		    	  response.sendRedirect("homepage2.jsp");
		      }
		      else
		    	  {System.out.println("Username or password incorrect");
		    	  response.sendRedirect("warning.html");

		    	  }
		      rs.close();
		      
		      
		     
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Connection not sucessfully");
		}
	
%>
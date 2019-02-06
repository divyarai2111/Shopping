<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.security.*" %>    


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
String n2=request.getParameter("n2");
String c2=(request.getParameter("c2"));
String u2=request.getParameter("e2");
String p2=request.getParameter("p2");
String cp2=request.getParameter("cp2");
try {
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("Driver Found");
	String url="jdbc:mysql://localhost/database1";
	String user="root";
	String password="";
	
	Connection con=null;
	System.out.println("Connected succefuly");

	//hash method for password
	byte[] unencodedPassword = p2.getBytes();
	MessageDigest md = null;
	try
	{
	md = MessageDigest.getInstance("MD5");
	} catch (Exception e)
	{
		System.out.println("Exception in hash");
	}
	md.reset();
	md.update(unencodedPassword);
	byte[] encodedPassword = md.digest();
	StringBuffer buf = new StringBuffer();
	for (int i = 0; i < encodedPassword.length; i++)
	{
		if (((int) encodedPassword[i] & 0xff) < 0x10) 
		{
		buf.append("0");	
		}
		buf.append(Long.toString((int) encodedPassword[i] & 0xff, 16));
	}
	//passw is the hashed password obtained
	String passw=buf.toString(); 


	con=DriverManager.getConnection(url,user,password);
	
	PreparedStatement st=con.prepareStatement("SELECT * from login");
 	ResultSet rs = st.executeQuery();
	Class.forName("com.mysql.jdbc.Driver");
	System.out.println("Driver Found");
		int count=0;
     	while(rs.next())
	      {
	         //Retrieve by column name
	         String user_id  = rs.getString("username");
	         String pass = rs.getString("pass");
	         System.out.println("After pass");
	     	
	         //checks whether user tries to reister using existing username(email) from the database
	         if(user_id.equals(u2))
	      
	         {
	        	 
	  			count++;
	         }
	        		         
	      	         }
     	System.out.println(count);
     	
     	
     		
        if (count==0)//count 0 means no username clashes.i,e, username is unique
        {
        	if(!p2.equals(cp2)&& p2.length()!=cp2.length())//checks whther cconfiremd pass  is same
         	{
        		//condition when pass doesnt matches
         		out.println("<script type=\"text/javascript\">");
         	   out.println("alert('Password do not match!!!!');");
         	   out.println("location='registration.html';");
         	   out.println("</script>");
         	}
        	else
        	{
        		//everything is ok then enter into db(Note insert hashed password)
        	st.executeUpdate("INSERT INTO login " + "VALUES('"+n2+"','"+c2+"','"+u2+"','"+(passw)+"')");
            response.sendRedirect("login_page.html");
            return;
        	}
     	    }
        else
        {
        	   
        	
        	out.println("<script type=\"text/javascript\">");
   out.println("alert('Email already registered !!!!');");
   out.println("location='registration.html';");
   out.println("</script>");
        	   return;
         	   
        	     }
        

	
}
catch (Exception e) {
	// TODO Auto-generated catch block
	System.out.println(e);
	e.printStackTrace();
}





%>

</body>
</html>

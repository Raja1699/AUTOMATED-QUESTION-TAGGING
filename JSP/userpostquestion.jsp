<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  <%@ page import = "com.service.Provider" %>
    <%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
 <%@page import="com.dao.ConnectionProvider"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'userpostquestion.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
 <%
 
 String question = request.getParameter("fname");
	System.out.println("user question");
	
	
	try{
		int status =0;
		Connection con= ConnectionProvider.getCon(); 
		  PreparedStatement ps=con.prepareStatement("insert into userquestion values (?)");		  
	       ps.setString(1,question );
	     
	       status=ps.executeUpdate();
	       
	       
	       String count = "1";
	       PreparedStatement ps1=con.prepareStatement("insert into userquestioncount values (?)");		  
	       ps1.setString(1,count );
	     
	       status=ps1.executeUpdate();
	       
	       
	       
	       
	       
	       
	       
	            
	       System.out.println("Added succes");
	       request.setAttribute("ok", "Question Post Successfully !");
	       RequestDispatcher rd=request.getRequestDispatcher("quesask.jsp");  
	        rd.forward(request, response);  
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	
 
 
 
 %>
  </body>
</html>

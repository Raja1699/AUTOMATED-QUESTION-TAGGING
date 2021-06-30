<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
   <%@ page import = "com.service.Provider" %>
    <%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
 <%@page import="com.dao.ConnectionProvider"%>
 
 
 
 
   <%
   
   try{
		
		
		Connection conssss= ConnectionProvider.getCon();  
		Statement statement=conssss.createStatement();
		String sql ="DELETE FROM userquestioncount ";
		 statement.executeUpdate(sql);
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
   
   
   %>
   
 
 
 
 
 
 
 
 
 
 
 
 
 
 <%


String s1 = "";


try{
	Connection conssss= ConnectionProvider.getCon();  
	Statement statement=conssss.createStatement();
	String sql ="select * from userquestion  ";
	ResultSet resultSet = statement.executeQuery(sql);
	while(resultSet.next()){
		
		
		s1 = resultSet.getString(1);
	
		
		%>
		




<%
}

} catch (Exception e) {
e.printStackTrace();
}
%>
 
 
 
 
 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>My JSP 'index.jsp' starting page</title>
    	<meta charset="utf-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  		<meta name="viewport" content="width=1200">
  		<link href="./resources/main.css" media="all" rel="stylesheet" type="text/css">
  		<link href="./resources/style.css" media="all" rel="stylesheet" type="text/css">
  		<script src="jquery/jquery10.js"></script>
  		<script>
  			$(document).ready(function()
			{
  				/*$("#expid").hide();
  				$("#selexpoptid").hide();*/
				/*$("#createtabledivid").hide();
				$("#finalsubmitid").hide();*/
				
				$("#loginbutid").click(function()
				{
					if(document.getElementById("logininputtextid").value=="" || document.getElementById("logininputpassid").value=="")
					{
						document.getElementById("errorreploginlabid").innerHTML="Fields should not be empty!";
					}
					else
					{
						document.loginform.action="login";
						document.loginform.submit();
					}
					/*$("#maincenterid").hide();
					$("#createtabledivid").fadeIn(500);*/
				});
				
				$("#signupbutid").click(function()
				{
					var user=document.getElementById("reguserid").value;
					var pass=document.getElementById("regpassid").value;
					var conpass=document.getElementById("regconpassid").value;
					var mailid=document.getElementById("regmailid").value;
					var mobno=document.getElementById("regmobnoid").value;
					var city=document.getElementById("regcityid").value;
					var expeid=document.getElementById("expid").value;
					var rad=document.regform.radioreg.value;
					var atpos=mailid.indexOf("@");
					var dotpos=mailid.lastIndexOf(".");
										
					if(rad=="expert")
					{
						if(user=="" || pass=="" || conpass=="" ||  mailid=="" ||  mobno=="" ||  city=="" || expeid=="")
						{
				 			document.getElementById("errorrepreglabid").innerHTML="Fields should not be empty!";
						}
						else
						if(user.match(/\W/))
						{
   							document.getElementById("errorrepreglabid").innerHTML="You have special characters on username field!";
						}
						else
						if(pass.length<4)
						{
							document.getElementById("errorrepreglabid").innerHTML="Password must be atleat 4 in length!";
						}
						else
						if(pass!=conpass)
						{
							document.getElementById("errorrepreglabid").innerHTML="Check your passwords!";	
						}
						else
						if(mobno=="0000000000" || mobno.length>10 || mobno.length<10)
						{
							document.getElementById("errorrepreglabid").innerHTML="Check your contact number!";	
						}
						else
						if(isNaN(mobno))
						{
							document.getElementById("errorrepreglabid").innerHTML="Contact number sholud be a number!";
						}
						else
				    	if(atpos<1 || dotpos<atpos+2 || dotpos+2>=mailid.length)
			    		{
			    			document.getElementById("errorrepreglabid").innerHTML="Check your mail id!";
			    		}
						else
						{
							document.regform.action="register";
							document.regform.submit();
						}
					}
			           else
					{
						if(user=="" || pass=="" || conpass=="" ||  mailid=="" ||  mobno=="" ||  city=="")
						{
				 			document.getElementById("errorrepreglabid").innerHTML="Fields should not be empty!";
						}
						else
						if(user.match(/\W/))
						{
							document.getElementById("errorrepreglabid").innerHTML="You have special characters on username field!";
						}
						else
						if(pass.length<4)
						{
							document.getElementById("errorrepreglabid").innerHTML="Password must be atleat 4 in length!";
						}
						else
						if(pass!=conpass)
						{
							document.getElementById("errorrepreglabid").innerHTML="Check your passwords!";	
						}
						else
						if(mobno=="0000000000" || mobno.length>10 || mobno.length<10)
						{
							document.getElementById("errorrepreglabid").innerHTML="Check your contact number!";	
						}
						else
						if(isNaN(mobno))
						{
							document.getElementById("errorrepreglabid").innerHTML="Contact number sholud be a number!";
						}
						else
				    	if(atpos<1 || dotpos<atpos+2 || dotpos+2>=mailid.length)
			    		{
			    			document.getElementById("errorrepreglabid").innerHTML="Check your mail id!";
			    		}
						else
						{
							document.regform.action="register";
							document.regform.submit();
						}
					}					
				});
			});
  			
  			function hideTextFrm()
  			{
  				$("#expid").hide();
  				$("#selexpoptid").hide();
			}
  			
  			function showTextFrm()
  			{
  				$("#expid").show();
  				$("#selexpoptid").show();
			}
  			function hideTextFrms()
  			{
  			  $("#expid").hide();
  				$("#selexpoptid").hide();
  				
			}
  			
  		</script>
  	</head>
  
	<body class="background-noise">
		
   
   
   
   <h3 align = "center"> Questions </h3>
  
   
   <div align = "center">
    <%
   String o = (String)request.getAttribute("ok");

  if(o != null)
  {
  	
  	out.println("<font color=#159eee  size =4px>"+o+"</font>");
  	
  }
   
   
   %>
   <form  action = "expanswered.jsp" >
 			
 		
 		

<label for="fname">Post Your Answer:</label>
<input type="text" id="fname" name="fname" value ="<%=s1 %>" size="50" >
<br/>
<br/>
<input type="text" id="fname" name="ans"  size="50" >
  <br><br>
  <input type="submit" value="Post">
</form>
                 		<a href="expertuser.jsp" class="button button-login">Back</a>
   
   </div>
 		

   

 

				
	</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
		<header class="background-blue-canvas masthead-container">
  			
  			  <div class="container masthead">
			    <div class="row">
			      <div id="logo" class="span3 center" style="width:350px;">
			        <a href="http://localhost:9999/Bridging" style="font-size: 22px;font-style: normal;color: white;font-weight: bold">Automatic Question Tagging</a>
			      </div>
			      
					
			        <div class="nav-meta-extra pull-right">
			        <ul class="nav">
			        <li class="item">
			        		<label id="actionerroridlab"><s:actionmessage/></label>
				           		<label id="errorreploginlabid" style="color:maroon;font-size:10pt;"></label>
				           	 </li>
			        </ul>
			          <ul class="nav">
			          		
			          		<li class="item">
			            	  
				            </li>	
				            <li class="item">
				       
				            </li>
				            <li class="item">
				               
				            </li>   
			          </ul>
			          
			           <ul class="nav">
			          	 <li class="item">
			           		
			           	 </li>
			             <li class="item">
			           		
			           	 </li>
			             <li class="item">
			           		
			           	 </li>
			           
			           	  <li class="item">
			           	
			           	 </li>
			           	 </div>
			           </ul>			           
			        </div>
				
			    </div>
			  </div>
  
		  	<nav class="nav-sub-container">
				<div class="container">
		      		<div class="nav nav-sub clearfix">
		      	
		      		</div>
    			</div>
  			</nav>
		</header>

	<div align = "center" class="container" data-rails-env="production"">
			<div id="content">
	      		<div id="right-column" class="span4 top5">
	      			<div class="box etiquette roger-at-top" style="padding-top:25px;">
	    				<div class="roger-sticker top-sticker">
	      					<img alt="Roger_green_circle" class="robot-green" src="./resources/images.jfif">
	   	     			</div>	
		    			<p>
		      			<strong></strong>  
						
  					</div> 					
				</div>


   <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
   <script type="text/javascript" src="jquery/ajax.js"></script>
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 		<form name ="form1"   action = "A"   method ="post"">
 			
 		
 		<h3 align = "center"> SEE THE RESULT</h3>

<div   style="text-align:center;">
<input type =  "submit" style="font-size100px" style="height:40px; width:150px" align = "center" value = "FINISH"/>

</div>

   

   </form>

				
	</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.PrintWriter" %>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
 
    <title>My JSP 'Questions.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  
  </head>

  	
  
  <body style="background-color:#ADD8E6;">


  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
   <script type="text/javascript" src="jquery/ajax.js"></script>
   <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   

  
  <form name ="form1"   action = "Questions.jsp"    id ="fullname">
  <%!  
// Counter method for the Number of questions   
   private int hitCount;
   public void init() { 
      // Reset hit counter.
      hitCount = 0;
   } 
 %>
 
<%

Random r = new Random();
HttpSession session1 = request.getSession(true); 


PrintWriter outs = response.getWriter();

ArrayList<String> ll = (ArrayList)session1.getAttribute("Qques");


String s1 = ll.get(r.nextInt(ll.size()));
 


%>

  <% hitCount++; %>
<p><%=hitCount %></p>
<%

if(hitCount != 5)
	{
	
	}
else
	{
	 init();
	 
	 RequestDispatcher rs = request.getRequestDispatcher("Final.jsp");
		 rs.forward(request, response);	
		
	}
%>

 <h2 align ="center" >Welcome to Medical Quizs</h2>
 
   <h3> Domain Quiz</h3>
 <h2>Questions  <%=hitCount %><p>.</p> of 10 </h2>    
 Time : <span id="timer"></span>    
 <p> <%= s1%></p>  
              
         <input type="hidden" name="ques" id="ques" value="<%=s1%>">
<button type="button" onclick="loadDoc()">Request data</button>
 <input type = "text" name="ans" id="ans" style="font-size:15pt;height:60px" size = "30" /><br/>

 <input type = "submit" onclick="loadDoc()"  style="font-size:20px" style="height:40px; width:40px"  value = "Answer" id="bttHello"/>

    <script> 
function loadDoc() {

 var datase=encodeURIComponent(document.getElementById("ques").value)
var dataan=encodeURIComponent(document.getElementById("ans").value)
 var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById("demo").innerHTML = this.responseText;
    }
  };
  xhttp.open("GET", "http://localhost:9999/Bridging/A?ques="+datase+"+&ans="+dataan+"", true);
  xhttp.send();
}
	 



var sec = 120;
var time = setInterval(myTimer, 1000);

function myTimer() {
    document.getElementById('timer').innerHTML = sec + "sec left";
    sec--;
    if (sec == -1) {
        clearInterval(time);
        alert("Time out!! :(");
    }
}





</script>  

   

   </form>

  </body>

</html>

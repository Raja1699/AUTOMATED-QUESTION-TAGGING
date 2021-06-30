<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@taglib uri="/struts-tags" prefix="s"%>
   <%@ page import = "com.service.Provider" %>
    <%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
 <%@page import="com.dao.ConnectionProvider"%>
 
 <%


String s1 = "";


try{
	Connection conssss= ConnectionProvider.getCon();  
	Statement statement=conssss.createStatement();
	String sql ="select * from userquestioncount  ";
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
				$("#loginmodal1").hide();
			});
			var quess;
			function setVal(quesvaid)
			{
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$('#mask').css({'width':maskWidth,'height':maskHeight,backgroundColor:"black"});
				$('#loginmodal1').css({'width':maskWidth/2,'top':'40%','left':'35%'});
			
				$('#mask').fadeIn(400);	
				$("#loginmodal1").fadeIn(600);
				quess=document.getElementById(quesvaid).innerHTML;
				document.getElementById("queslabansid").innerHTML="Question :"+document.getElementById(quesvaid).innerHTML;	
			}
			function subAns()
			{
				document.getElementById("anshidid").value=quess+"="+document.getElementById("textareaid").value;
				document.ansform.submit();
			}
		</script>
  	</head>
  
	<body class="background-noise">
		
		<form name="ansform" method="post" action="expertanssub">
			<input type="hidden" name="anshid" id="anshidid"/>
		</form>
		<div id="loginmodal1">
	    	<center><h4>Answers</h4></center>
	    	<label style="margin-left:45px;font-size:14px;" id="queslabansid">Question : </label> 
			<center><textarea rows="10" style="font-size:13px;width:530px;" id="textareaid"></textarea></center>
			<br/>
			<input type="button" value="Post"  onclick="subAns()" style="float:right;margin-right:66px;font-size:13px;"/>
	  	</div>
	  	
	  	<div id="mask" style="height: 229px; background-color: black; display: none; opacity: 0.5;"></div>
		<header class="background-blue-canvas masthead-container">
  			<div class="container masthead">
    			<div class="row">
	      			<div id="logo" class="span3" style="width:80%;">
	        			<a href="http://localhost:9999/Bridging" style="font-size: 22px;font-style: normal;color: black;font-weight: bold">Automatic Question Tagging</a>
	        			<div style="float:right;"><label style="font-size:20px;color:white;">Hello<s:property value="#session.user"/>...</label>
	        			</div>
	      			</div>
	      			<nav class="span12">
		        		<div class="nav-meta-extra pull-right">
		          			<ul class="nav">
			            		<li class="item">
			                		<a href="logout" class="button button-login">Log Out</a>
			                		<br/>
			                	<a href="expertviewquestion.jsp" class="button button-login">Notification[<%=s1 %>]</a>
			                		<br/>
			            		</li>
		          			</ul>
		        		</div>
	      			</nav>
    			</div>
  			</div>
  
		  	<nav class="nav-sub-container">
				<div class="container">
		      		<div class="nav nav-sub clearfix">
						<div class="item active"><a href="http:localhost:9999/Bridging">Q&amp;A</a></div>
      				</div>
    			</div>
  			</nav>
		</header>


 		<div class="container" data-rails-env="production">
			<div id="content">
	      		<div id="right-column" class="span4 top5">
	      			<div class="box etiquette roger-at-top">
	    				<div class="roger-sticker top-sticker">
	      					<img alt="Roger_green_circle" class="robot-green" src="./resources/bb.jpg">
	   	     			</div>
		    			<p>
		      			<strong></strong> * An apple daily can away doctor but the doctor is cute then forgot the fruit.
		      			<br/>
		      			* The best doctor gives the least medicines
		      			<br/>
		      			* Sometimes, doctors risk their lives just save others
  					</div>
  					
  					<div class="section-group">
	          			<div class="free search-ask">
	            			<div class="search">
	              				<form accept-charset="UTF-8" action="searchuserquery" method="post">
	              					<div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden"></div>
							  		<label class="sans-serif-label" for="query">Have a Question?</label>
									<div class="input-append">
									   	<input class="span3" id="query" name="query" placeholder="Search the Q&amp;A forum" type="text">
									   	<input class="button span1" name="commit" type="submit" value="Search">
									</div>
								</form>
	            			</div>
	          			</div>
	        		</div>
	
	        		<h4> Questions</h4>
	        		<div class="list-filters">
		        		<form accept-charset="UTF-8" action="filtersearch" class="question-filter clearfix" method="post">
		        			<div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden"></div>
		  					<div class="form-body"> 
				      			<div class="filter-row">
				        			<label for="view">Category</label>
			        				<select class="filter span3" id="view" name="view">
			        					<option value="all" selected="selected">All Questions</option>
			        					<s:iterator value="vecques">
			        						<option value="<s:property/>"><s:property/></option>
			        					</s:iterator>
									</select>
				      			</div>
						    	<div class="filter-row">
				        			<label for="from">From</label>
				        			<select class="filter span3" id="from" name="from"><option value="all" selected="selected">All Time</option>
				        				<option value="Last 2 Weeks">Last 2 Weeks</option>
										<option value="Last 1 Month">Last 1 Month</option>
										<option value="Last 3 Months">Last 3 Months</option>
										<option value="Last 6 Months">Last 6 Months</option>
									</select>
				      			</div>			      			
				      			<div class="filter-row">
				        			<label for="sort">Sorted by</label>
				        			<select class="filter span3" id="sort" name="sort"><option value="newest" selected="selected">Latest Questions</option>
										<option value="activity">Recent Activity</option>
										<option value="most_popular">Most Thumbs Up</option>
										<option value="most_responses">Most Responses</option>
									</select>
				      			</div>
			 				</div>
			 				<div class="form-actions">
				    			<input class="button" type="submit" value="Filter questions">
				  			</div>
						</form>
	        		</div>
        		</div>
			
				<div id="main" class="span10 top5">
					<h1 class="h2 thin top0"><a href="http://localhost:9999/Bridging"> Q&amp;A Forum</a></h1>
					<div class="tabs closed">
			  			<ul class="nav nav-tabs box-header">
				    		<li class="item active"><a href="http://localhost:9999/Bridging" rel="bootstrap-tooltip" data-original-title="" title="">Questions</a></li>
						    <li class="item inactive"><a href="http://localhost:9999/Bridging" rel="bootstrap-tooltip" data-original-title="" title="">Search / Browse</a></li>
			  			</ul>
					</div>
					
					<div class="question" id="question_63205">
						<div class="status-banner box-header answered">
				        	<span class="answered-label">Answered</span>
				      	</div>
						
						<%--	 ==================================================   				--%>
						
						<%int co=0; %>
						<s:iterator value="vecquesanssnip">
							
							<div class="box-content clearfix">
		      				<div class="question-header">
	         					<div class="pull-left">
	      							<div rel="bootstrap-tooltip" class="avatar tooltip-html " title="">
		     							<a href="http://localhost:9999/Bridging" class="size-large"><img alt="287253" src="./resources/dox.jfif"></a>
		     							<label style="font-weight:bold; "><s:property value="expertname"/></label>		        						
	    							</div>
	 		 					</div>
	 		 
	            				<aside class="thumbs-group pull-right">
	    		  					<form accept-charset="UTF-8" action="http://localhost:9999/Bridging" class="vote up" method="post">
		    		  					<div style="margin:0;padding:0;display:inline">
			    		  					<input name="utf8" type="hidden">
			    		  					<input name="authenticity_token" type="hidden" value="SaVlMlRmtsNB9rUj14H+1XGKH5Yajp6hXEgKiOewnCE=">
		    		  					</div>
		    		  					<s:property value="date"/>
									</form>
	    						</aside>	
	
		        				<div class="question-header-meta">
			          				<h2 class="top0 bottom0">
			          					<label id="labelquespropid<%=co%>"><s:property value="ques"/></label>
			          					<br/>
										<lable style="font-size:12px;">(<s:property value="quesdomain"/>)</lable>										
			          				</h2>
			          				<p><s:property value="quessnip"/></p>
			          				<p><a href="javascript:void(0)" class="anslinkid" onclick="setVal('labelquespropid<%=co%>')">Click here to post Answers!</a></p>
		        				</div>
	      					</div>
							<hr/>
		      				<div class="question-info">
						        <div class="description">
									<p><s:property value="answer"/></p>
						        </div>
								<div class="edited-time">
		          				</div>
							</div>
	    				</div>
						<%co++;%>
						</s:iterator>
	    				
					<%--	 ==================================================   				--%>
	
		    			<div class="clearfix">
		      				<div class="pull-right">
		      					<a class="button answer-link disabled" rel="bootstrap-tooltip" title="" data-original-title="In order to ask questions, comment, or give thumbs up, you need to be logged in to your Moz Pro account.">+ Respond to Question</a>
		      				</div>
		    			</div>
	
		    			<div class="reply-section">
		  					<div class="compose" id="compose_question_63205-bottom"></div>
		 				</div>	
					</div>
				</div>
			</div>
		</div>
	
		<div id="footer">
	  		<footer class="footer grey">
	    		<div class="container">
		      		<div class="row">
		        		<div class="span4">
	          				<a href="http://localhost:9999/Bridging"><i class="icon-logo-grey">Moz</i></a>
	       				</div>
	        			<div class="span7 center">
	        				<p class="small">Copyright Google© 2021 All Rights Reserved.</p>
	        			</div>
					</div>
	   			</div>
	  		</footer>
		</div>

		<div id="bootstrapModal" class="popup modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
	  		<div class="modal-header">
	    		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			</div>
	  		<div class="modal-body"></div>
	  		<div class="modal-footer">
	    		<button class="button button-small" data-dismiss="modal" aria-hidden="true">Close</button>
	  		</div>
		</div>
	</body>
</html>
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
		<meta http-equiv="description" content="This is my page">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  		<meta name="viewport" content="width=1200">
  		<link href="./resources/main1.css" media="all" rel="stylesheet" type="text/css">
  		<link href="./resources/style.css" media="all" rel="stylesheet" type="text/css">
  		<script src="jquery/jquery10.js"></script>
  		
  		<script>
  			function loadQuesAnsPdf(path)
  			{
  				document.getElementById("pdfiframeid").src=path;
  			}
  		</script>
  		
  		<script>
  			
			$(document).ready(function()
			{
				$("#loginmodal1").hide();
				$("#loginmodalusersnip").hide();
				
				
				$(".closeidh").click(function()
				{
					var maskHeight = $(document).height();
					var maskWidth = $(window).width();
					$('#mask').css({'width':maskWidth,'height':maskHeight,backgroundColor:"black"});
					$('#mask').fadeOut(400);	
					$("#loginmodal1").fadeOut(600);
					$("#loginmodalusersnip").fadeOut(600);
				});
			});
			var quess;
			function setVal()
			{
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$('#mask').css({'width':maskWidth,'height':maskHeight,backgroundColor:"black"});
				$('#loginmodal1').css({'width':maskWidth/2,'top':'40%','left':'35%'});
			
				$('#mask').fadeIn(400);	
				$("#loginmodal1").fadeIn(600);
			}
			
			function setSnip()
			{
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				
				$('#mask').css({'width':maskWidth,'height':maskHeight,backgroundColor:"black"});
				$('#loginmodalusersnip').css({'width':maskWidth/2,'top':'40%','left':'35%'});
			
				$('#mask').fadeIn(400);	
				$("#loginmodalusersnip").fadeIn(600);
			}
			
			function askQue(str)
			{
				if(str=="ask")
				{
					document.getElementById("anshidid").value=document.getElementById("questiontext").value+"="+document.getElementById("textareaid").value;
					document.ansform.submit();
				}
				else
				{
					document.getElementById("anshidid1").value=document.getElementById("textareaidsnip").value;
					document.snipform.submit();
				}
			}
		</script>
  	</head>
  
	<body class="background-noise">
	
		<form name="ansform" method="post" action="useraskques">
			<input type="hidden" name="anshid" id="anshidid"/>
		</form>
		
		<form name="snipform" method="post" action="notsatisf">
			<input type="hidden" name="anshid" id="anshidid1"/>
		</form>
		
		<div id="loginmodal1">
			<h5 style="float:right;" class="closeidh">X</h5>
	    	<center><h4>Queries</h4></center>
	    	<center>
	    		<input type="text" id="questiontext" style="width:530px;font-size:14px;" placeholder="Question..."/>
	    		<br/>
	    	<textarea rows="10" style="font-size:13px;width:530px;" id="textareaid" placeholder="Question Snippet..."></textarea></center>
			<input type="button" value="Post"  onclick="askQue('ask')" style="float:right;margin-right:66px;font-size:13px;"/>
	  	</div>
	  	
	  	
	  	<div id="loginmodalusersnip">
	  		<h5 style="float:right;" class="closeidh">X</h5>
	    	<center><h4>Question Snippet</h4></center>
	    	<center>
	    	<textarea rows="10" style="font-size:13px;width:530px;" id="textareaidsnip" placeholder="Question Snippet..."></textarea></center>
			<input type="button" value="Post" onclick="askQue('snip')" style="float:right;margin-right:66px;font-size:13px;"/>
	  	</div>
	  	
	  	
	  	
		<div id="mask" style="height: 229px; background-color: black; display: none; opacity: 0.5;"></div>
		
		<header class="background-blue-canvas masthead-container">
  			<div class="container masthead">
    			<div class="row">
	      			<div id="logo" class="span3" style="width:80%;">
	        			<a href="userhome" style="font-size: 22px;font-style: normal;color: black;font-weight: bold">Automatic Question Tagging</a>
	        			<div style="float:right;"><label style="font-size:20px;color:white;">Hi <s:property value="#session.user"/>...</label>
	        			</div>
	      			</div>
	      			<nav class="span12">
		        		<div class="nav-meta-extra pull-right">
		          			<ul class="nav">
			            		<li class="item">
			                		<a href="logout" class="button button-login">Log Out</a>
			            		</li>
		          			</ul>
		        		</div>
	      			</nav>
    			</div>
  			</div>
  
		  	<nav class="nav-sub-container">
				<div class="container">
		      		<div class="nav nav-sub clearfix">
						<div class="item active"><a href="userhome">Q&amp;A</a></div>
      				</div>
    			</div>
  			</nav>
		</header>


 		<div class="container" data-rails-env="production">
			<div id="content">
	      		<div id="right-column" class="span4 top5 box-header">	      			
  					
  					<div class="section-group">
	          			<div class="free search-ask" style="float:left">
	            			<div class="search">
	              				<form accept-charset="UTF-8" action="searchuserquery" method="post">
	              					<div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden"></div>
							  		<label class="sans-serif-label" for="query">Have a Question?</label>
									<div class="input-append">
									   	<input class="span3" id="query" name="query" placeholder="Search the Q&amp;A forum" type="text">
									   	<input class="button span1" name="commit" type="submit" value="Search">
									</div>
								</form>
								<iframe width="555px" height="750px" id="pdfiframeid"></iframe>
	            			</div>
	          			</div>
	        		</div>
        		</div>
			
				<div id="main" class="span10 top5">
					<h1 class="h2 thin top0"><a href="userhome"> Q&amp;A Forum</a></h1>
					<div class="tabs closed" style="width:550px;">
			  			<ul class="nav nav-tabs box-header">
			  				<li class="item active"><a href="javascript:void(0)" rel="bootstrap-tooltip" data-original-title="" title="">Resources</a></li>
						    <li class="item inactive"><a href="userhome" rel="bootstrap-tooltip" data-original-title="" title="">Browse</a></li>
		    <li class="item inactive"><a href="javascript:void(0)" onclick="setVal()" rel="bootstrap-tooltip" data-original-title="" title="">Ask Expert</a></li>
			  			</ul>
					</div>
					
					<div class="question" id="question_63205" style="width:550px;">
						<div class="status-banner box-header answered">
				        	<span class="answered-label">Answered</span>
				      	</div>	
		
	    				<div class="box-content clearfix">
		      				<div class="question-header">
	         					<div class="pull-left">
	      							<div rel="bootstrap-tooltip" class="avatar tooltip-html " title="">
		     							<a href="userhome" class="size-large"><img alt="287253" src="./resources/user.png"></a>
		        						<ul class="stars unstyled inline">
		 				 					<li class="star filled"></li><li class="star"></li><li class="star"></li><li class="star"></li><li class="star"></li>
										</ul>
	    							</div>
	 		 					</div>
	 		 
	            				<aside class="thumbs-group pull-right">
	    		  					<form accept-charset="UTF-8" action="userhome" class="vote up" method="post">
		    		  					<div style="margin:0;padding:0;display:inline">
			    		  					<input name="utf8" type="hidden">
			    		  					<input name="authenticity_token" type="hidden" value="SaVlMlRmtsNB9rUj14H+1XGKH5Yajp6hXEgKiOewnCE=">
		    		  					</div>
		    		  					<s:property value="date"/>		    		  					
									</form>
	    						</aside>	
	
		        				<div class="question-header-meta">
			          				<h2 class="top0 bottom0">            
			           					 <s:property value="query"/>
			          				</h2>
			          				<lable style="font-size:18px;font-weight:bold"><s:actionmessage/></lable>
		        				</div>
	      					</div>
	
		      				<div class="question-info">
						        <div class="description">
						        	<h3>Suggested Answers</h3>
						        	<s:iterator value="vecglobal">
						        		<p><a href="javascript:void(0)" onclick="loadQuesAnsPdf('<s:property value="path"/>')"><s:property value="answer"/></a></p>	
						        	</s:iterator>
						        	 <h5><a href="javascript:void(0)" onclick="setSnip()" style="color:red">Not Satisfied with your Answers?</a></h5>
						        </div>
								<div class="edited-time">
		          				</div>
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
	          				<a href="userhome"><i class="icon-logo-grey">Moz</i></a>
	       				</div>
	        			<div class="span7 center">
	        				<p class="small">Copyright Google© 2014 All Rights Reserved.</p>
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
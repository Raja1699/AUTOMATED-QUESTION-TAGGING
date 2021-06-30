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
<%--  		<script src="./resourcesmain.js" type="text/javascript"></script>--%>
  	</head>
  
	<body class="background-noise">
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
	      					<img alt="Roger_green_circle" class="robot-green" src="./resources/x.jpg">
	   	     			</div>
		    			<p>
		      			<strong>The Main Aim</strong>  of this Project is to gap vocabulary gap between health seekers and providers to code the medical records by jointly utilizing local mining
						and global learning approaches.
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
	
	        		<h4>Browse Questions</h4>
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
					<h1 class="h2 thin top0"><a href="userhome">Bridging Q&amp;A Forum</a></h1>
					<div class="tabs closed">
			  			<ul class="nav nav-tabs box-header">
				    		<li class="item active"><a href="userhome" rel="bootstrap-tooltip" data-original-title="" title="">Questions</a></li>
						    <li class="item inactive"><a href="userhome" rel="bootstrap-tooltip" data-original-title="" title="">Search / Browse</a></li>
			  			</ul>
					</div>
					
					<div class="question" id="question_63205">
						<div class="status-banner box-header answered">
				        	<span class="answered-label">Answered</span>
				      	</div>
						
						<%--	 ==================================================   				--%>
						
						<s:iterator value="vecquesanssnip">
							
							<div class="box-content clearfix">
		      				<div class="question-header">
	         					<div class="pull-left">
	      							<div rel="bootstrap-tooltip" class="avatar tooltip-html " title="">
		     							<a href="userhome" class="size-large"><img alt="287253" src="./resources/doc.png"></a>
		     							<label style="font-weight:bold; "><s:property value="expertname"/></label>		        						
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
			          					<s:property value="ques"/>
			          					<br/>
										<lable style="font-size:12px;">(<s:property value="quesdomain"/>)</lable>										
			          				</h2>
			          				<p><s:property value="quessnip"/></p>
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
	          				<a href="userhome"><i class="icon-logo-grey">Moz</i></a>
	       				</div>
	        			<div class="span7 center">
	        				<p class="small">Copyright Google© 2020 All Rights Reserved.</p>
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
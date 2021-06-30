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
				$("#loginmodal").hide();				
				$(".analyzelink").click(function()
				{
					var maskHeight = $(document).height();
					var maskWidth = $(window).width();
					
					$('#mask').css({'width':maskWidth,'height':maskHeight,backgroundColor:"black"});
				
					$('#mask').fadeIn(400);	
					$("#loginmodal").fadeIn(600);
				});	
			});
		</script>
  	</head>  	
  
	<body class="background-noise">
	
		<div id="loginmodal">
	    	<h4>PROCESSING WAIT</h4>
			<center><img src="resources/loading.gif"></center>
	  	</div>
	  	<div id="mask" style="height: 229px; background-color: black; display: none; opacity: 0.5;"></div>
	
		<header class="background-blue-canvas masthead-container">
  			<div class="container masthead">
    			<div class="row">
	      			<div id="logo" class="span3 center" style="width:350px;">
	        			<a href="http://localhost:9999/Bridging" style="font-size: 22px;font-style: normal;color: black;font-weight: bold">Automatic Question Tagging</a>
	      			</div>
	      			<nav class="span12">
		        		<div class="nav-meta-extra pull-right">
		        			<ul class="nav">
					        <li class="item">
				                <a href="clear.jsp" class="button button-login" id="loginbutid" style="margin-top:5px;">Clear</a>
				            </li>
				           <li class="item">
				                <a href="index.jsp" class="button button-login" id="loginbutid" style="margin-top:5px;">Log Out</a>
				            </li>
			                	
					        </ul>
		        		</div>
	      			</nav>
    			</div>
  			</div>
  
		  	<nav class="nav-sub-container">
				<div class="container">
		      		<div class="nav nav-sub clearfix">
						<div class="item active"><a href="admin.jsp">Home</a></div>
						<div class="item"><a href="admincsvprocess" class="analyzelink">Analyze Csv</a></div>
						<div class="item"><a href="adminpdfprocess" class="analyzelink">Analyze Resources</a></div>
						<div class="item"><a href="adminnlp" class="analyzelink">NLP Process</a></div>
						<div class="item"><a href="clean" class="analyzelink">Clean</a></div>
						<div class="item"><a href="cleannlp" class="analyzelink">Clean Nlp</a></div>						
      				</div>
      			</div>
  			</nav>
		</header>


 		<div class="container" data-rails-env="production">
			<div id="content">
	      		<div id="right-column" class="span4 top5">
	      			<div class="box etiquette roger-at-top">
	    				<div class="roger-sticker top-sticker">
	      					<img alt="Roger_green_circle" class="robot-green" src="./resources/q.jfif">
	   	     			</div>	
		    			<p>
		      			<strong>Let food be the medicine and medicine be thy food</strong> 
						
  					</div>
  					
  					<div class="section-group">
	          			<div class="free search-ask">
	            			<div class="search">
	              				<form accept-charset="UTF-8" action="http://localhost:9999/Bridging" method="get">
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
	
	        		<h4>QUESTIONS</h4>
	        		<div class="list-filters">
		        		<form accept-charset="UTF-8" action="http://localhost:9999/Bridging" class="question-filter clearfix" method="get">
		        			<div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden"></div>
		  					<div class="form-body"> 
				      			<div class="filter-row">
				        			<label for="view">View</label>
			        				<select class="filter span3" id="view" name="view"><option value="all" selected="selected">All Questions</option>
										<option value="featured">Bounty</option>
										<option value="new">New (No Responses)</option>
									</select>
				      			</div>
						    	<div class="filter-row">
				        			<label for="from">From</label>
				        			<select class="filter span3" id="from" name="from"><option value="all" selected="selected">All Time</option>
										<option value="last_30_days">Last 30 Days</option>
										<option value="last_7_days">Last 7 Days</option>
										<option value="last_24_hours">Last 24 Hours</option>
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
				      			<div class="filter-row">
				        			<label for="category">With category</label>
				        			<select class="filter span3" id="category" name="category"><option value="all" selected="selected">All Categories</option>
										<option value="28">Affiliate Marketing</option>
										<option value="20">Alternative Search Sources</option>
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
					<center><label id="messagelabelid"> <s:actionmessage/></label></center>
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
		
	    				<div class="box-content clearfix">
		      				<div class="question-header">
	         					<div class="pull-left">
	      							<div rel="bootstrap-tooltip" class="avatar tooltip-html " title="">
		     							<a href="http://localhost:9999/Bridging" class="size-large"><img alt="287253" src="./resources/w.jfif"></a>
		        						<ul class="stars unstyled inline">
		 				 					<li class="star filled"></li><li class="star"></li><li class="star"></li><li class="star"></li><li class="star"></li>
										</ul>
	    							</div>
	 		 					</div>
	 		 
	            				<aside class="thumbs-group pull-right">
	    		  					<form accept-charset="UTF-8" action="http://localhost:9999/Bridging" class="vote up" method="post">
		    		  					<div style="margin:0;padding:0;display:inline">
			    		  					<input name="utf8" type="hidden">
			    		  					<input name="authenticity_token" type="hidden" value="SaVlMlRmtsNB9rUj14H+1XGKH5Yajp6hXEgKiOewnCE=">
		    		  					</div>
		    		  					<button class="button" rel="bootstrap-tooltip" title="" data-original-title="In order to ask questions, comment, or give thumbs up, you need to be logged in to your Moz Pro account.">
			    		  					<span class="hidden">Vote up</span>
			    		  					<i class="icon icon-thumbs-up"></i> 
			    		  					<span data-vote-count="true">1</span>
		    		  					</button>
									</form>
	    						</aside>	
	
		        				<div class="question-header-meta">
			          				<h2 class="top0 bottom0">            
			           					Is there a genetic factor to strokes?
			          				</h2>
		        				</div>
	      					</div>
	
		      				<div class="question-info">
						        <div class="description">
						          <p>My friend admitted in hospital  doctor said he has genetic that causes him a stroke</p>
						        </div>
								<div class="edited-time">
		          				</div>
		
		        				<div class="question-actions clearfix">      
							    	<div class="pull-right">
							    		<a class="button answer-link disabled" rel="bootstrap-tooltip" title="" data-original-title="In order to ask questions, comment, or give thumbs up, you need to be logged in to your Moz Pro account.">+ Respond to Question</a>
						    		</div>
	        					</div>
		      				</div>
	    				</div>
	
					    <div class="replies-header">
					      <h4 class="bottom1">1 Response</h4>
					      	<div class="reply-section">
					  			<div class="compose" id="compose_question_63205-top">
					  			</div>
							</div>
					    </div>
	
				    	<ul class="comment-list">
				       		<li class="reply item" id="reply_239437">
								<div class="comment  good-answer ">
						  			<div class="answer">    
						        		<div class="pull-left">
						      				<div rel="bootstrap-tooltip" class="avatar tooltip-html " title="" data-original-title="">
						     	 				<a href="http://localhost:9999/Bridging" class="size-large"><img alt="311667" src="./resources/m.jfif"></a>
						        				<ul class="stars unstyled inline">
							  						<li class="star filled"></li><li class="star"></li><li class="star"></li><li class="star"></li><li class="star"></li>
												</ul>
					      					</div>
					  					</div>
	
								    	<div class="reply-info comment-body">
								      		<header class="clearfix">
								          		<div class="reply-title-name pull-left">
									            	<a href="http://localhost:9999/Bridging" class="name">adamlcasey</a>
									            	<small class="small">Digital Marketing Executive at Crystal Ball Ltd</small>
									          	</div>
									          	<ul class="reply-title-date small unstyled pull-right">
									            	<li>Jun 12, 2021</li>
									          	</ul>	
								      		</header>
			
									      	<div class="description">
									        	<p>If you are interested, I am sure you can learn more about this condition from the Web. Some people are born with genetic conditions that predispose them to clotting. This in turn may increase their stroke risk. Finally, if you have a strong family history of high blood pressure, diabetes, high cholesterol or any of the major modifiable risk factors for stroke, you may also be at higher risk because of this. However, these particular conditions are very much treatable and you certainly can do something about them to lower your risk.</p>
												<p>You can contact him here:&nbsp;</p>
									      	</div>
									      	
									      	<div class="edited-time">
									      	</div>
			    						</div>
		    						
			    						<div class="reply-edit"></div>
										<div class="reply-section">
											<div class="compose" id="compose_reply_239437"></div>
										</div>
										<ul class="status-labels unstyled">
									    	<li class="good-answer-label">Good Answer</li>
								      	</ul>
  									</div>
								</div>
							</li>
						</ul>
	
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
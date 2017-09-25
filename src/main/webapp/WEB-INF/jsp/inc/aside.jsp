<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<body class="sb-l-o sb-r-c mobile-view tray-rescale onload-check">
    <div class="main">
    	<header class="navbar navbar-fixed-top navbar-shadow ">
			<div class="navbar-branding">
				<a class="navbar-brand" href="<c:url value='/main.do'/>">
					<strong><%=Config.getConfigValue(ConfigID.TITLE)%></strong>
<%-- 					<strong><spring:message code="title"/></strong> --%>
        		</a>
				<span id="toggle_sidemenu_l" class="ad ad-lines"></span>
			</div>
			<ul class="nav navbar-nav navbar-right">
			</ul>
    	</header>
    	<!-- End: Header -->
    	
		<aside id="sidebar_left" class="nano nano-light affix">
		<!-- Start: Sidebar Left Content -->
			<div class="sidebar-left-content nano-content" data-role="responsivepanel">
			<!-- Start: Sidebar Header -->
				<header class="sidebar-header">
					<div class="sidebar-widget author-widget">
						<div class="media">
							<a class="media-left" href="#">
								<img src="<c:url value='/resource/images/user_default.jpg'/>" class="img-responsive">
							</a>
							<div class="media-body">
								<div class="media-author">
									<div class="media-links">
										<a href="#" class="sidebar-menu-toggle">
											<c:out value="${userStore.username}"/><br>
											<c:out value="${userStore.fullname}"/>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>
	
					<!-- Sidebar Widget - Menu (slidedown) -->
					<div class="sidebar-widget menu-widget">
						<div class="row text-center mbn">
							<div class="col-xs-4">
								<a href="dashboard.html" class="text-primary" data-toggle="tooltip" data-placement="top" title="Dashboard">
									<span class="glyphicon glyphicon-home"></span>
								</a>
							</div>
							<div class="col-xs-4">
								<a href="#" class="text-info" data-toggle="tooltip" data-placement="top" title="Messages">
									<span class="glyphicon glyphicon-inbox"></span>
								</a>
								</div>
							<div class="col-xs-4">
								<a href="#" class="text-alert" data-toggle="tooltip" data-placement="top" title="Tasks">
									<span class="glyphicon glyphicon-bell"></span>
								</a>
								</div>
							<div class="col-xs-4">
								<a href="#" class="text-profile" data-toggle="tooltip" data-placement="top" title="Profile">
									<span class="glyphicon glyphicon-user"></span>
								</a>
								</div>
							<div class="col-xs-4">
								<a href="#" class="text-danger" data-toggle="tooltip" data-placement="top" title="Settings">
									<span class="fa fa-gears"></span>
								</a>
							</div>
							<div class="col-xs-4">
								<a href="${contextPath}/com/login/logout.do" class="text-logout" data-toggle="tooltip" data-placement="top" title="Logout">
									<span class="glyphicon glyphicon-log-out"></span>
								</a>
							</div>
						</div>
					</div>
				</header>
				<!-- Start: Sidebar Menu -->
	       		<ui id="menu-body" class="nav sidebar-menu"></ui>
				<!-- End: Sidebar Menu -->
			</div>
			<!-- End: Sidebar Left Content -->
	    </aside>
	    <!-- End: Sidebar Left -->
	    <section id="content_wrapper">
			<!-- Content Header (Page header) -->
			<header id="topbar" class="alt">
<script>
	//alert("${userStore.userType}")
	var userType = "${userStore.userType}";
	var userId = "${userStore.username}";
	var userNm  = "${userStore.fullname}";
	var temp;
		
	/////////////////////////////
	// main.js duple
	/////////////////////////////
	var sidebarLeftToggle = function(options) {
		// Set Default Options
       	var defaults = {
		   	sbl: "sb-l-o", // sidebar left open onload 
		   	sbr: "sb-r-c", // sidebar right closed onload
		   	sbState: "save", //Enable localstorage for sidebar states
		
		   	collapse: "sb-l-m", // sidebar left collapse style
		   	siblingRope: true
		   	// Setting this true will reopen the left sidebar
			// when the right sidebar is closed
		};
		
		var Body = $('body');
       	var options = $.extend({}, defaults, options);
       	// If sidebar is set to Horizontal we return
       	if ($('body.sb-top').length) { return; }   

		// We check to see if the the user has closed the entire
		// leftside menu. If true we reopen it, this will result
		// in the menu resetting itself back to a minified state.
		// A second click will fully expand the menu.
       	
		if (Body.hasClass('sb-l-c') && options.collapse === "sb-l-m") {
			Body.removeClass('sb-l-c');
		}

		// Toggle sidebar state(open/close)
		Body.toggleClass(options.collapse).removeClass('sb-r-o').addClass('sb-r-c');
		setTimeout(function() {
			$(window).trigger('resize');
		
			if(Body.hasClass('sb-l-m')) {
		    	Body.addClass('sb-l-disable-animation');
		    }
		    else {
		    	Body.removeClass('sb-l-disable-animation');
			}
		}, 300);
	};
    $("#toggle_sidemenu_l").on('click', sidebarLeftToggle);
	/////////////////////////////
	
	$(document).ready(function() { 
		$(document).on("click", ".treeview", function(){
			$(".active").removeClass("active");
			$(this).addClass('active');
		}); 
		
		drawMenu("${current_menu}");
		
		"use strict";
		// Init Demo Js
	    Demo.init();

		// Init Theme Core    
		Core.init();
	});
</script>
<style>
.treeview-menu{cursor:pointer}
.nav>li>a{display:inline-block !important;}
.nav>li>a:hover{background-color:transparent;}
.btn-default{border:0px; background-color:transparent; margin-bottom:1px;}
</style>
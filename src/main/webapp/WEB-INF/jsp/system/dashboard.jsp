<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>
<script src="<c:url value='/resource/js/comm/util-number.js'/>" type="text/javascript" ></script>
<script src="<c:url value='/resource/js/comm/time.js'/>" type="text/javascript" ></script>

		<div class="topbar-left">
			<ol class="breadcrumb">
				<li class="crumb-active"><a
					href="${contextPath}/
								<c:choose>
									<c:when test="${menu.menu_url != null}">${menu.menu_url}</c:when>
									<c:otherwise>${menu.main_url}</c:otherwise>
								</c:choose>
							">
						<c:choose>
							<c:when test="${menu.menu_name != null}">${menu.menu_name}</c:when>
							<c:otherwise>${menu.main_name}</c:otherwise>
						</c:choose>
				</a></li>
				<li class="crumb-link"><a href="#">${menu.main_name}</a></li>
				<c:if test="${menu.menu_name != null}">
					<li class="crumb-trail">${menu.menu_name}</li>
				</c:if>
			</ol>
		</div>
		<div class="topbar-right">
			<div class="ib topbar-dropdown">
				<label for="topbar-multiple" class="control-label pr10 fs11 text-muted"> <c:choose>
						<c:when test="${menu.description != null}">${menu.description}</c:when>
						<c:otherwise>${menu.main_description}</c:otherwise>
					</c:choose>
				</label>
			</div>
			<div class="ml15 ib va-m" id="toggle_sidemenu_r">
            	<a class="request-fullscreen toggle-active" href="#">
            		<span class="ad ad-screen-full fs18"></span>
          		</a>
          	</div>
		</div>
	</header>
	<!-- Main content -->
	<section id="content" class="table-layout animated fadeIn">
		<div class="tray tray-center">
			<div class="row">
				<div class="col-sm-4 col-xl-3">
					<div class="panel panel-tile text-center br-a br-grey">
						<div class="panel-body">
							<h1>
								<div id="clock" style="font-size:50px;"></div>
								<h2> 
									<div id="date"></div>
								</h2>
							</h1>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-4 col-xl-3">
					<div class="panel panel-tile text-center br-a br-grey">
						<div class="panel-body">
							<h1 class="fs30 mt5 mbn"><fmt:formatNumber>1426</fmt:formatNumber></h1>
							<h6 class="text-system">소독 차량</h6>
						</div>
						<div class="panel-footer br-t p12">
							<span class="fs11"> 
								<i class="fa fa-arrow-up pr5 text-primary"></i> 3% INCREASE <b>1W AGO</b>
							</span>
						</div>
					</div>
				</div>
				<div class="col-sm-4 col-xl-3">
					<div class="panel panel-tile text-center br-a br-grey">
						<div class="panel-body">
							<h1 class="fs30 mt5 mbn"><fmt:formatNumber>4837</fmt:formatNumber></h1>
							<h6 class="text-success">미소독 차량</h6>
						</div>
						<div class="panel-footer br-t p12">
							<span class="fs11"> 
								<i class="fa fa-arrow-up pr5 text-primary"></i> 2.7%	INCREASE <b>1W AGO</b>
							</span>
						</div>
					</div>
				</div>
				<div class="col-sm-4 col-xl-3">
					<div class="panel panel-tile text-center br-a br-grey">
						<div class="panel-body">
							<h1 class="fs30 mt5 mbn"><fmt:formatNumber>108</fmt:formatNumber></h1>
							<h6 class="text-warning">감염 차량</h6>
						</div>
						<div class="panel-footer br-t p12">
							<span class="fs11"> 
								<i class="fa fa-arrow-up pr5 text-primary"></i> 1% INCREASE <b>1W AGO</b>
							</span>
						</div>
					</div>
				</div>
				<div class="col-sm-4 col-xl-3">
					<div class="panel panel-tile text-center br-a br-grey">
						<div class="panel-body">
							<h1 class="fs30 mt5 mbn"><fmt:formatNumber>10</fmt:formatNumber></h1>
							<h6 class="text-danger">감염 농가</h6>
						</div>
						<div class="panel-footer br-t p12">
							<span class="fs11"> 
								<i class="fa fa-arrow-down pr5 text-danger"></i> 6% DECREASE <b>1W AGO</b>
							</span>
						</div>
					</div>
				</div>
			</div>
			<div id="row">
				<div class="col-sm-8 col-xl-6">
					<div class="panel panel-tile text-center br-a br-grey">
						<div id="chart-car-week"></div>
					</div>
				</div>
				<div class="col-sm-8 col-xl-6">
					<div class="panel panel-tile text-center br-a br-grey">
						<div id="chart-car-daily"></div>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>

<script>
	var series = [
		{
		    name: "미소독차량",
		    data: [100, 200, 150, 309, 183, 392, 239],
		    // Line chart marker type
		    markers: { type: "square" }
		}, {
		    name: "소독차량",
		    data: [39, 55, 84, 24, 140, 99, 127]
		}
	];
	
	$(document).ready(function() {
		printClock();
		$("#chart-car-week").kendoChart({
            title: {
                text: "미/소독 차량 출입현황(주별)"
            },
            legend: {
                position: "bottom"
            },
            seriesDefaults: {
                type: "column",
                stack: true
            },
            series: series,
            valueAxis: {
                line: {
                    visible: false
                }
            },
            categoryAxis: {
                categories: ['9/10(일)', '9/11(월)', '9/12(화)', '9/13(수)', '9/14(목)', '9/15(금)', '9/16(토)'],
                majorGridLines: {
                    visible: false
                }
            },
            tooltip: {
                visible: true,
                format: "{0}대"
            }
        });
		
		$("#chart-car-daily").kendoChart({
            title: {
                text: "미/소독 차량 출입현황(일별)"
            },
            legend: {
                position: "bottom"
            },
            seriesDefaults: {
                type: "column",
                stack: true
            },
            series: [
        		{
        		    name: "미소독차량",
        		    data: [1, 3, 5, 6, 7, 5, 0, 1, 3, 4, 5, 6, 7, 9, 11, 22, 5, 0, 0, 12, 4, 5, 3, 1],
        		    // Line chart marker type
        		    markers: { type: "square" }
        		}, {
        		    name: "소독차량",
        		    data: [1, 1, 3, 6, 0, 5, 0, 0, 3, 4, 5, 6, 0, 1, 1, 2, 3, 0, 1, 8, 4, 0, 0, 1],
        		}
        	],
            valueAxis: {
                line: {
                    visible: false
                }
            },
            categoryAxis: {
                categories: ['0시', '1시', '2시', '3시', '4시', '5시', '6시', '7시', '8시', '9시', '10시', '11시', '12시', '13시', '14시', '15시', '16시', '17시', '18시', '19시', '20시', '21시', '22시', '23시'],
                majorGridLines: {
                    visible: false
                }
            },
            tooltip: {
                visible: true,
                format: "{0}대"
            }
        });
	});//document ready javascript end...
</script>
<%@ include file="../inc/footer.jsp"%>
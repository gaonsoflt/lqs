<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

		<div class="topbar-left">
			<ol class="breadcrumb">
				<li class="crumb-active">
					<a href="<c:url value='${menu.menu_url}'/>">${menu.menu_name}</a>
				</li>
				<li class="crumb-link">
					<a href="#">${menu.main_name}</a>
				</li>
				<li class="crumb-trail">${menu.menu_name}</li>
			</ol>
		</div>
		<div class="topbar-right">
			<div class="ib topbar-dropdown">
				<label for="topbar-multiple" class="control-label pr10 fs11 text-muted">${menu.description}</label>
			</div>
		</div>
	</header>
	<!-- Main content -->
	<section id="content" class="table-layout animated fadeIn">
		<div class="row">
			<div class="col-md-12">
				<p style="font-size: 15px; padding: 10px 0px;">
					검색:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_user" />&nbsp;&nbsp;&nbsp;
					<button id="searchBtn" type="button">조회</button>
				</p>
			</div>
			<div class="col-md-12">
				<div id="grid-resource"></div>
			</div>
		</div>
	</section>

<script>
	var G_UserNmVal;//조회조건 : 사용자명
	var codelist = "_USER_TYPE_";
	var codeModels = "";

	$.ajax({
		type : "post",
		url : "<c:url value='/common/getCodeListByCdIDModel.do'/>",
		data : {
			"list" : codelist
		},
		async : false, //동기 방식
		success : function(data, status) {
			//codeModels = $.extend(codeModels, data.rtnList);
			codeModels = data.rtnList;
			console.log(codeModels);
		},
		fail : function() {
			console.log("error: getCodeListByCdIDModel");
		},
		complete : function() {
			console.log(codeModels);
		}
	});

	function fnCodeNameByCdID(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModels.length; i++) {
			if (codeModels[i].cd_id == code) {
				rtnVal = codeModels[i].cd_nm;
			}
		}
		return rtnVal;
	}

	function fnCodeNameByCd(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModels.length; i++) {
			if (codeModels[i].cd == code) {
				rtnVal = codeModels[i].cd_nm;
			}
		}
		return rtnVal;
	}

	$(function() {
		/* 사용자명 */
		$("#in_user").kendoAutoComplete({
			dataSource : {
				transport : {
					read : { url : "<c:url value='/common/getUsername.do'/>", dataType : "jsonp" },
					parameterMap : function(data, type) {
						var result = {
						};
						return {
							params : kendo.stringify(result)
						};
					}
				}
			},
			dataTextField : "text",
			dataBound : function(e) {
				// handle the event
			},
			change : function(e) {
				G_UserNmVal = this.value();
			}
		});
		/* 조회 */
		$("#searchBtn").kendoButton({
			icon : "search",
			click : function(e) {
				$("#grid-resource").data("kendoGrid").dataSource.read();
			}
		});
	});
	var cancelFalg = false;

	$(document).ready(function() {
		/*************************/
		/* dataSource grid-resource */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/sm/resource";
		/*** dataSource ***/
		dataSourceDetail = new kendo.data.DataSource({
			transport : {
				read : { url: crudServiceBaseUrl + "/read.do", dataType: "jsonp" },
				update : { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
				create : { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
				destroy : { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
				parameterMap : function(data, type) {
					if (type == "read") {
						var result = {
							PAGESIZE : data.pageSize,
							SKIP : data.skip,
							PAGE : data.page,
							TAKE : data.take,
							G_UserNmVal : G_UserNmVal
						};
						return {
							params : kendo.stringify(result)
						};
					}

					if (type !== "read" && data.models) {
						return {
							models : kendo.stringify(data.models)
						};
					}
				}
			},//transport end...
			schema : {
				data : function(response) {
					return response.rtnList;
				},
				total : function(response) {
					return response.total;
				},
				errors : function(response) {
					return response.error;
				},
				model:{
					id: "res_id",
					fields: { 
						runm			: { type: "number", editable: false },
						res_id			: { type: "string", editable: false },
						res_name		: { type: "string" },
						res_pattern		: { type: "string" },
						description		: { type: "string" },
						res_type		: { type: "string", defaultValue: 'url', editable: false },
						sort_order		: { type: "number", defaultValue: 1 }
					}  
				}
			},
			error : function(e) {
				console.log(e.errors);
				alert(e.errors);
			},
			change : function(e) {
			},
			requestStart : function(e) {
			},
			requestEnd : function(e) {
				console.log("grid-resource:dataSource:requestEnd");
	        	if(e.type != 'read' && (typeof(e.response.error) == undefined || e.response.error == null)) {
	        		alert("정상적으로 처리되었습니다.");
	        	} else if(e.type != 'read' && e.response.error != null) {
	        		e.preventDefault();
					this.cancelChanges();
	        		alert("문제가 발생하여 정상적으로 처리되지 않았습니다.");
	        	}
			},
			sync : function(e) {
				console.log("sync complete");
// 				$("#grid-resource").data("kendoGrid").dataSource.read();
			},
			serverPaging : true, // 서버 사이드 페이징 활성화
			serverFiltering : false,
			serverSorting : false, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
			//autoSync: true,          //     자동 저장
			batch : true, //     true: 쿼리를 한줄로,  false : row 단위로
			page : 1, //     반환할 페이지
			pageSize : 13, //     반환할 항목 수
			skip : 0, //     건너뛸 항목 수
			take : 13
		//     반환할 항목 수 (pageSize와 같음)
		});//datasource grid-resource end...

		/*************************/
		/***    grid-resource     ***/
		/*************************/
		$("#grid-resource").kendoGrid({
			autoBind : true,
			dataSource : dataSourceDetail,
			navigatable : true,
			pageable : true,
			height : 630,
			toolbar : [ 
				{ name : "create", text : "추가" },
				{ name : "cancel", text : "취소" }
			],
			messages : {
				commands : {
					canceledit : "취소",
					update : "저장"
				}
			},
			columns : [
				{ field: "res_id", title: "리소스ID", width: 110, attributes: {style: "text-align: center;"} },
				{ field: "res_name", title: "리소스명", width: 250, attributes: {style: "text-align: center;"} },
				{ field: "res_pattern", title: "리소스패턴", attributes: {style: "text-align: left;"} },
				{ field: "description", title: "설명", width: 350, attributes: {style: "text-align: left;"} },
				{ field: "res_type", title: "리소스타입", width: 80, attributes: {style: "text-align: center;"} },
				{ field: "sort_order", title: "우선순위", width: 80, attributes: {style: "text-align: center;"} },
				{
					command: [
						{ name: "edit", 
							template: "<a class='k-button k-grid-edit' href='' style='min-width:16px;'><span class='fa fa-pencil'></span></a>" },
						{ name: "destroy", 
								template: "<a class='k-button k-grid-delete' href='' style='min-width:16px;'><span class='fa fa-trash-o'></span></a>" }
					],
					width: 90
				}
			],
			editable : {
				mode : "inline",
				confirmation : "선택한 행을 삭제하시겠습니까?"
			},
			sortable : true,
			selectable : true, //selectable: "multiple cell","multiple row","cell","row",
			scrollable : true,
			mobile : true,
			//excel, pdf
			excel : false,
			pdf : false,
			noRecords : {
				template : "검색된 결과가 없습니다."
			},
			pageable : {
				//refresh: true, //하단의 리프레쉬 아이콘
				pageSizes : true,
				//buttonCount: 1  //paging 갯수
				//input: true //페이지 직접입력
				//info: false //하단의 페이지 정보
				messages : {
					display : "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
					empty : "출력할 항목이 없습니다",
					itemsPerPage : "한 페이지에 출력할 항목 수"
				}
			},
			resizable : true, //컬럼 크기 조절
			reorderable : true, //컬럼 위치 이동
			save : function(e) {//저장전 이벤트
			},
			saveChanges : function(e) {//저장버턴 클릭시 이벤트 
			},
			edit : function(e) {
			},
			dataBound : function(e) {
				invokeUserAuth("${current_menu}", "kendoGrid");
			}
		});//grid-resource end...
	});//document ready javascript end...
</script>

<!-- custome style -->
<style>
	#grid-resource .k-grid-content {
		overflow-x: auto;
	}
	
	#grid-resource table th {
		text-align: center;
	}
/* 	.k-grid td { */
/* 	    overflow: hidden; */
/* 		white-space: nowrap; */
/* 		text-overflow: ellipsis; */
/* 	} */
</style>
<%@ include file="../inc/footer.jsp"%>
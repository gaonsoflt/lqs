<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>

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
				<p id="searchArea" style="font-size: 15px; padding: 10px 0px;">
					검색&nbsp;&nbsp;&nbsp;&nbsp;
					<input id="in_search" /> 
					<input id="in_keyword" /> 
					<input id="in_searchDate" />
					<input id="in_user" /> 
					<button id="searchBtn" type="button">조회</button>
				</p>
			</div>
			<div class="col-md-12">
				<div id="grid-disf"></div>
			</div>
		</div>
	</section>
</section>
<script>
	/* DropDownList Template */
	var codelist = "_USER_TYPE_";
	var codeModles = "";
	
	$.ajax({
		type : "post",
		url : "<c:url value='/common/getCodeListByCdIDModel.do'/>",
		data : {
			"list" : codelist
		},
		async : false, //동기 방식
		success : function(data, status) {
			//codeModles = $.extend(codeModles, data.rtnList);
			codeModles = data.rtnList;
		},
		fail : function() {
		},
		complete : function() {
		}
	});

	function fnCodeNameByCdID(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
			if (codeModles[i].CD_ID == code) {
				rtnVal = codeModles[i].CD_NM;
			}
		}
		return rtnVal;
	}
	
	function fnCodeNameByCd(code) {
		var rtnVal = "";
		for (var i = 0; i < codeModles.length; i++) {
			if (codeModles[i].CD == code) {
				rtnVal = codeModles[i].CD_NM;
			}
		}
		return rtnVal;
	}

	var G_Condition = "ALL";
	var G_Keyword = ""; 
	
	$(function() {
		var searchData = [ 
			{ text : "전체", value : "ALL" }, 
			{ text : "제목", value : "TITLE" }, 
			{ text : "글쓴이", value : "USER_NAME" }, 
			{ text : "접속일", value : "ACCESS_DT" } 
		];
	
		$("#in_search").kendoComboBox({
			dataTextField : "text",
			dataValueField : "value",
			dataSource : searchData,
			change : function() {
				G_Condition = $("#in_search").val();
				console.log("combobox change: " + G_Condition);
				if (G_Condition == "ALL") {
					$("#in_keyword").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
				} else if (G_Condition == "ACCESS_DT") {
					G_Keyword = "";
					$("#in_searchDate").data("kendoDatePicker").value(new Date());
					$("#searchArea .k-datepicker").css({ "display" : "inline-block" });
					$("#in_keyword").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
					G_Keyword = kendo.toString(new Date(), "yyyy-MM-dd");
				} else if (G_Condition == "USER_NAME") {
					G_Keyword = "";
					$("#in_user").val("");
					$("#searchArea .k-autocomplete").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#in_keyword").css({ "display" : "none" });
				} else {
					G_Keyword = "";
					$("#in_keyword").val("");
					$("#in_keyword").css({ "display" : "inline-block" });
					$("#searchArea .k-datepicker").css({ "display" : "none" });
					$("#searchArea .k-autocomplete").css({ "display" : "none" });
				}
			},
			index : 0
		});

		/* 키워드 */
		$("#in_keyword").kendoMaskedTextBox({
			change : function(e) {
				G_Keyword = this.value();
			}
		});
		
		/*검색일자*/
		$("#in_searchDate").kendoDatePicker({
			culture : "ko-KR",
			format : "yyyy/MM/dd",
			parseFormats : [ "yyyy-MM-dd" ],
			value : new Date(),
			change : function(e) {
				G_Keyword = kendo.toString(this.value(), "yyyy-MM-dd");
			}
		});
	
		/* 조회 */
		$("#searchBtn").kendoButton({
			icon : "search",
			click : function(e) {
				$("#grid-disf").data("kendoGrid").dataSource.read();
			}
		});
	
		/* 사용자명 */
		$("#in_user").kendoAutoComplete({
			dataSource : {
				transport : {
					read : {
						url : "<c:url value='/common/getAutoComplete.do'/>",
						dataType : "jsonp"
					},
					parameterMap : function(data, type) {//type =  read, create, update, destroy
						var result = {
							TABLE : "SYS_USER_INFO",
							COLUNM : "USER_NAME"
						};
						return { params : kendo.stringify(result) };
					}
				}
			},
			dataTextField : "cd_nm",
			dataBound : function(e) {
			},
			change : function(e) {
				G_Keyword = this.value();
			}
		});
	});
	
	$(document).ready(function() {
		/*************************/
		/***    grid-disf     ***/
		/*************************/
		$("#grid-disf").kendoGrid({
			autoBind : true,
			dataSource : {
				transport : {
					read : { 
						url : "${contextPath}/car/disf/list.do", 
						dataType : "jsonp",
						complete: function(e){ 
					    	console.log("grid-disf:dataSource:list:complete");
					    }
					},
					parameterMap : function(data, type) {//type =  read, create, update, destroy
						if (type == "read") {
							var result = {
								PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take
							};
							return { params : kendo.stringify(result) };
						}
					}
				},//transport end...
				schema : {
					data : function(response) { return response.rtnList; },
					total : function(response) { return response.total; },
					errors : function(response) { return response.error; },
					parse : function(response) { return response; },
					model : {
						fields : {
							car_no 			: { type: "string", editable: false },
							ref_car_no		: { type: "string", editable: false },
							owner	 		: { type: "string", editable: false },
							facility_seq	: { type: "number", editable: false },
							facility_name	: { type: "string", editable: false },
							address_seq 	: { type: "number", editable: false },
							sido			: { type: "string", editable: false },
							sigungu			: { type: "string", editable: false },
							disf_dt 		: { type: "string", editable: false },
							admit_dt	 	: { type: "string", editable: false }
						}
					}
				},
				error : function(e) {
					console.log(e.errors);
					alert(e.errors);
				},
				change : function(e) {
				},
				sync : function(e) {
					console.log("sync complete");
				},
				serverPaging : true, // 서버 사이드 페이징 활성화
				serverFiltering : false,
				serverSorting : false, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
				//autoSync: true,          //     자동 저장
				batch : true, //     true: 쿼리를 한줄로,  false : row 단위로
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			navigatable : true,
			pageable : true,
			height : 600,
            toolbar: false,
			columns : [
				{ field : "car_no", title : "차량번호", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "owner", title : "차량", width : 150, attributes : { style : "text-align: center;" },
					template: "#= (ref_car_no == '') ? '미등록차량' : owner #" },
				{ field : "disf_dt", title : "소독시간", attributes : { style : "text-align: center;" },
					template : "#= (disf_dt == '') ? '' : kendo.toString(new Date(Number(disf_dt)), 'yyyy년 MM월 dd일   HH시 mm분 ss초') #" },
				{ field : "admit_dt", title : "소독허용시간", attributes : { style : "text-align: center;" },
					template : "#= (admit_dt == '') ? '' : kendo.toString(new Date(Number(admit_dt)), 'yyyy년 MM월 dd일   HH시 mm분 ss초') #" },
				{ field : "facility_name", title : "소독시설명", width : 200, attributes : {	style : "text-align: center;" } },
				{ field : "sido", title : "시설위치(시/도)", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "sigungu", title : "시설위치(시/군/구)", width : 200, attributes : { style : "text-align: center;" } }
			],
			change: function(e) {
			},
			sortable : true,
			selectable : "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable : true,
			mobile : true,
			excel : false,
			noRecords : {
				template: "검색된 결과가 없습니다."
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
			dataBound: function(e) {
				console.log("dataBound");
				var rows = e.sender.tbody.children();
				  
				for (var j = 0; j < rows.length; j++) {
				    var row = $(rows[j]);
				    var dataItem = e.sender.dataItem(row);
				  
				    if (dataItem.get("admit_dt") < new Date()) {
				        row.addClass("timeover");
				    }
				}
			},
			resizable : true, //컬럼 크기 조절
			reorderable : true //컬럼 위치 이동
		});//grid-disf end...
	});//document ready javascript end...
</script>

<style>
.timeover {
	background:#aaa;
}

#in_keyword, .k-datepicker, .k-autocomplete {
	display: none;
}

#in_keyword, .k-datepicker, #searchBtn {
	margin-left: 9px;
}

.k-grid td {
	white-space: nowrap;
	text-overflow: ellipsis;
}

#dropzone {
    border:2px dotted #3292A2;
    width:100%;
    height:70px;
    color:#92AAB0;
    text-align:center;
    font-size:24px;
    padding-top:12px;
    margin-top:10px;
}
</style>
<%@ include file="../../inc/footer.jsp"%>
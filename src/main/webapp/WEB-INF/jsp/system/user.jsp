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
					사용자 검색:&nbsp;&nbsp;&nbsp;&nbsp;<input id="in_user" />&nbsp;&nbsp;&nbsp;
					<button id="searchBtn" type="button">조회</button>
				</p>
			</div>
			<div class="col-md-12">
				<div id="gridDetail"></div>
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
				var gridDetail = $("#gridDetail").data("kendoGrid");
				gridDetail.dataSource.read();
			}
		});
	});
	var cancelFalg = false;

	$(document).ready(function() {
		/*************************/
		/* dataSource gridDetail */
		/*************************/
		var crudServiceBaseUrl = "${contextPath}/sm/user",
		/*** dataSource ***/
		dataSourceDetail = new kendo.data.DataSource({
			transport : {
				read : { url : crudServiceBaseUrl + "/read.do", dataType : "jsonp" },
				update : { url : crudServiceBaseUrl + "/update.do", dataType : "jsonp" },
				destroy : { url : crudServiceBaseUrl + "/delete.do", dataType : "jsonp" },
				create : { url : crudServiceBaseUrl + "/create.do", dataType : "jsonp" },
				parameterMap : function(data, type) {//type =  read, create, update, destroy
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
				model : {//가져온 값이 있음...
					id : "user_id",//id 로 insert할건지 update 할건지 판단함.
					fields : {
						user_id : { type : "string", validation : { required : true } },
						user_type : { type : "string", defaultValue : "100025" },
						user_name : { type : "string", validation : { required : true } },
						password : { type : "string", validation : { required : true } },
						birthday : { editable : true, validation : { required : true } },
						use_yn : { type : "boolean", defaultValue : true },
						phone : { type : "string" },
						email : { type : "string" },
						groups : { type : "string", editable : false },
						description : { type : "string", editable : true },
						cre_usr : { type : "string", editable : false, defaultValue : "${userStore.username}" },
						cre_dt : { type : "string", editable : false }
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
			},
			sync : function(e) {
				console.log("sync complete");
				alert("정상적으로 처리되었습니다.");
				$("#gridDetail").data("kendoGrid").dataSource.read();
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
		//     반환할 항목 수 (pageSize와 같음)
		});//datasource gridDetail end...

		/*************************/
		/***    gridDetail     ***/
		/*************************/
		$("#gridDetail").kendoGrid({
			autoBind : true,
			dataSource : dataSourceDetail,
			navigatable : true,
			pageable : true,
			height : 630,
			toolbar : [ 
				{ name : "create", text : "추가" },
				{ name : "excel", text : "엑셀" }
			],
			messages : {
				commands : {
					canceledit : "취소",
					update : "저장"
				}
			},
			columns : [
// 				{
// 					field : "user_type",
// 					title : "사용자구분",
// 					width : 120,
// 					attributes : { style : "text-align: center;" },
// 					editor : function(container, options) {
// 						$('<input required name="' + options.field + '"/>')
// 						.appendTo(container)
// 						.kendoDropDownList({
// 							autoBind : true,
// 							dataTextField : "cd_nm",
// 							dataValueField : "cd_id",
// 							dataSource : {
// 								transport : {
// 									read : {
// 										url : "<c:url value='/dgms/getCodeListByCdID.do'/>",
// 										dataType : "jsonp"
// 									},
// 									parameterMap : function(data, type) {
// 										var result = {
// 											CD_ID : "_USER_TYPE_",
// 											USE_YN : "1"
// 										};
// 										return {
// 											params : kendo.stringify(result)
// 										};
// 									}
// 								}
// 							},
// 							change : function() {
// 							},
// 							dataBound : function(e) {
// 								$(".k-list-container").css("width", "100px");
// 							}
// 						});
// 					},
// 					template : "#=fnCodeNameByCdID(user_type)#"
// 				},
				{
					field : "user_id",
					title : "아이디",
					validation : {
						required : true,
						min : 1
					},
					attributes : { style : "text-align: center;" },
					width : 120
				},
				{
					field : "password",
					title : "비밀번호",
					attributes : { style : "text-align: center;" },
					width : 100,
					editor : function(container, options) {
						$('<input type="password" class="k-textbox" name="' + options.field + '"/>').appendTo(container);
					}
				},
				{
					field : "user_name",
					title : "이름",
					attributes : { style : "text-align: center;" },
					validation : {
						required : true,
						min : 1
					},
					width : 120
				},
				{
					field : "birthday",
					title : "생년월일",
					attributes : { style : "text-align: center;" },
					width : 100,
					editor : function(container, options) {
						$('<input name="' + options.field + '"/>')
						.appendTo(container)
						.kendoDatePicker({
							start : "year",
							depth : "month",
							culture : "ko-KR",
							format : "yyyy-MM-dd",
							parseFormats : [ "yyyyMMdd" ],
							//template: '#= kendo.toString(options.values), "MM/dd/yyyy" ) #',
							change : function() {
								var selectDate = kendo.toString(this.value(), "yyyyMMdd");
								options.model.set("birthday", selectDate);
							}
						});
					},
					template : "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #"
				},
				{
					field : "phone",
					title : "연락처",
					attributes : { style : "text-align: center;" },
					width : 130,
					template : "#= phone == null ? '' : phone.substring(0,3) + '-' + phone.substring(3,7) + '-' + phone.substring(7) #"
				},
				{
					field : "email",
					title : "이메일",
					attributes : { style : "text-align: center;" },
					width : 130
				},
				{
					field : "groups",
					title : "그룹",
					attributes : { style : "text-align: center;" },
					width : 300
				},
// 				{
// 					field : "groups",
// 					title : "그룹",
// 					attributes : { style : "text-align: center;" },
// 					width : 300,
// 					editor : function(container, options) {
// 						$('<select name="' + options.field + '"/>')
// 						.appendTo(container)
// 						.kendoMultiSelect({
// 							placeholder: "Select Group...",
// 			                dataTextField: "cd_nm",
// 			                dataValueField: "cd_id",
// 			                autoBind: false,
// 			                dataSource: {
// 			                    transport: {
// 			    					read : { 
// 			    						url: "${contextPath}/sm/code" + "/readDetails.do",
// 			    						dataType: "jsonp", 
// 			    						complete: function(e){ 
// 			    					    	console.log("group-grid:field:dataSource:read:complete");
// 			    					    }
// 			    					},
// 			    					parameterMap: function(data, type) {//type =  read, create, update, destroy
// 			    						if (type == "read"){
// 			    	                       	var result = {
// 			    								CATGR: "100462" // 100462=_USER_GROUP_
// 			    							};
// 			    							return { params: kendo.stringify(result) }; 
// 			    						}
// 			    					}
// 			    				},
// 			    				schema: {
// 			    					data: function(response) {
// 			    						return response.rtnList;
// 			    					},
// 			    					total: function(response) {
// 			    						return response.total;
// 			    					},
// 			    					errors: function(response) {
// 			    						return response.error;
// 			    					},
// 			    					model:{
// 			    						id: "cd",
// 			    						fields: { 
// 			    							cd		: { type: "string" },
// 			    							cd_nm	: { type: "string" },
// 			    							cd_id	: { type: "string" }
// 			    						}  
// 			    					}
// 			    				}
// 			                },
// 							autoClose: false
// 						});
// 					}
// // 					},
// // 					template : "#= group #"
// 				},
				{
					field : "description",
					title : "설명",
					attributes : { style : "text-align: left;" }
				},
				{
					field : "use_yn",
					title : "사용여부",
					attributes : { style : "text-align: center;" },
					width : 80
				},
				{
					title : "관리",
					attributes : { style : "text-align: center;" },
					command : [ 
						{ name : "edit", text : "수정" }, 
					    { name : "destroy", text : "삭제" } 
					],
					width : 150
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
			excel : {
				allPages : true,
				fileName : "사용자관리.xlsx",
			},
			pdf : {
				allPages : true,
				fileName : "사용자관리.pdf",
				paperSize : "A4",
				landscape : true,
				scale : 0.75
			},
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
				if (e.model.isNew()) {
					var uid = dataSourceDetail.at(0).user_id;
					var parameters = {
						'id' : uid
					};
					$.ajax({
						type : "post",
						url : "<c:url value='/common/chkExistUser.do'/>",
						async : false,
						data : parameters,
						success : function(data, status) {
							if (data.isExisted) {
								alert("동일한 아이디가 존재합니다.");
								e.preventDefault();
								cancelFalg = true;
								dataSourceDetail.cancelChanges();
							}
						},
						fail : function() {	}
					});
				}
				console.log("save...............");
			},
			saveChanges : function(e) {//저장버턴 클릭시 이벤트 
				var uid = dataSourceDetail.at(0).user_id;
				var upw = dataSourceDetail.at(0).password;
				if (typeof uid == 'undefined' || uid.replace(/ /gi, '').length < 1) {
					alert("아이디를 입력해주십시오.");
					e.preventDefault();
				}
			},
			edit : function(e) {
				if (!e.model.isNew()) {
					$("input[name=user_id]").attr({ "readonly" : true });
					$("input[name=user_id]").css({
						"background" : "#ccc",
						"text-align" : "center"
					});
				} else {
					/* Disable the editor of the "id" column when editing data items */
					$('input[name=user_seq]').parent().html(e.model.user_seq);
				}
			},
			dataBound : function(e) {
				invokeUserAuth("${current_menu}", "kendoGrid");
			}
		});//gridDetail end...
	});//document ready javascript end...
</script>

<!-- custome style -->
<style>
	#gridDetail .k-grid-content {
		overflow-x: auto;
	}
	
	#gridDetail table th {
		text-align: center;
	}
	.k-grid td {
	    overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
</style>
<%@ include file="../inc/footer.jsp"%>
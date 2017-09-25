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
				<button type="button" class="btn btn-primary btn-sm btn-auth-c" onclick="location.href='${contextPath}/bbs/board/form.do?bbs=${bbsInfo.bbs_uid}'"><spring:message code="button.add"/></button>
				<div id="grid-content"></div>
			</div>
		</div>
	</section>
</section>
<div id="window" style="display:none;">
	<div>
		<button id="delete-btn" class="btn btn-primary btn-sm btn-auth-d" data-role="button" data-icon="close" data-bind="click: remove" style="float:right;margin:10px 10px 0 0;">삭제</button>
		<button id="modify-btn" class="btn btn-primary btn-sm btn-auth-u" data-role="button" data-icon="pencil" data-bind="click: modify" style="float:right;margin:10px 10px 0 0;">수정</button>
		<button id="cancel-btn" class="btn btn-primary btn-sm" data-role="button" data-icon="cancel" data-bind="click: cancel" style="float:right;margin:10px 10px 0 0;">닫기</button>
	</div>
	<table style="width:100%;">
		<colgroup>
			<col width="60%">
			<col width="40%">
		</colgroup>
		<tbody>
			<tr>
				<td>
					<div style="width:100%;">
						<h4>제목</h4>
						<div>
							<input name="title" data-bind="value:selected.title" style="width:100%;" readonly="readonly"/>
						</div>
						<h4>내용</h4>
						<div>
							<textarea id="bbs-content" name="bbs-content" data-role="editor" data-bind="value:selected.content" style="width:100%;height:500px;"></textarea>
						</div>
					</div>
				</td>
				<td valign="top">
					<c:if test="${bbsInfo.attached == true}">
						<div>
							<div>첨부파일</div>
							<div id="file-list" style="border:2px solid #c9c9c9;min-height:50px"></div>
						</div>
					</c:if>
					<div id="reply" style="width:100%;">
<!-- 						<div id="reply-list" style="overflow:scroll;height:350px"></div> -->
						<div id="reply-content">
							<h4>댓글</h4>
							<textarea rows="3" cols="80" id="replyText" name="replyText" placeholder="댓글을 입력하세요."></textarea>
							<button id="add-reply" class="btn btn-primary btn-sm btn-auth-c" data-role="button" data-bind="click: add">댓글 등록</button>
							<form id="form2">
								<table style="width:100%;height:100%;">
									<colgroup>
										<col width="*">
										<col width="10%">
										<col width="15%">
										<col width="8%">
									</colgroup>
									<thead>
										<tr>
											<th>댓글</th>
											<th>작성자</th>
											<th>작성시간</th>
											<th></th>
										</tr>
									</thead>
									<tbody data-template="reply-row-template" data-bind="source: replyData"></tbody>
								</table>
								<div id="pager" data-role="pager" data-bind="source: dataSource" data-auto-bind="false"></div>
							</form>
						</div>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<script id="reply-row-template" type="text/x-kendo-template">
    <tr style="height:30px;">
        <td data-bind="text: reply"></td>
        <td data-bind="text: cre_usr"></td>
        <td>#= kendo.toString(new Date(Number(mod_dt)), 'yyyy-MM-dd hh:mm:ss')#</td>
        <td>
			#if ("${auth.auth_d}" == "true" || cre_usr == "${userStore.username}") {#
				<a onclick="return deleteReply(#=reply_seq#);">삭제</a>
			#}else{#
			#}#
		</td>
    </tr>
</script>     
<script>
	/* DropDownList Template */
	var codelist = "_USER_TYPE_";
	var codeModles = "";
	var bbsViewModel;
	var replyViewModel;
	var bbsModel;
	var wnd;
	
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
	var G_SEQ = 0;
	
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
				$("#grid-content").data("kendoGrid").dataSource.read();
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
	
	function closeWindow(e) {
		wnd.close();
		G_SEQ = 0;
		$("#grid-content").data("kendoGrid").dataSource.read();
	}
	
	function updateReply(){
		$("#replyText").val("");
		replyViewModel.dataSource.read();
    }
	
	function deleteReply(seq){
		if (confirm("삭제하시겠습니까?")) {
			$.ajax({
				type : "get",
				url : "<c:url value='/bbs/board/reply/delete.do'/>",
				data : {
					"seq" : seq
				},
				success : function(data, status) {
					if(data.success) {
						alert("삭제되었습니다.");
					}
					updateReply();
				}
			});
		}
    }
	
	$(document).ready(function() {
		
		/*************************/
		/* deatils window
		/*************************/
		wnd = $("#window").kendoWindow({
            title: "",
            width: 1100,
            actions: [
				"Maximize",
				"Close"
			],
            modal: true,
            visible: false,
            resizable: true,
            open: function(e) {
            	updateReply();
				var editor = $('#bbs-content').data('kendoEditor');
			    if (editor !== undefined) {
			        editor.body.contentEditable = false;
			        $('.k-editor-toolbar').hide();
			    }
            }
        }).data("kendoWindow");
		
		var crudServiceBaseUrl = "${contextPath}/bbs/board";
		/*************************/
		/***    grid-content     ***/
		/*************************/
		$("#grid-content").kendoGrid({
			autoBind : true,
			dataSource : {
				transport : {
					read : { 
						url : crudServiceBaseUrl + "/readList.do", 
						dataType : "jsonp",
						complete: function(e){ 
					    	console.log("grid-content:dataSource:read:complete");
					    }
					},
					parameterMap : function(data, type) {//type =  read, create, update, destroy
						if (type == "read") {
							var result = {
								PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
								bbs_uid : "${bbsInfo.bbs_uid}",
								CONDITION : G_Condition,
								KEYWORD : G_Keyword
							};
							return { params : kendo.stringify(result) };
						}

						if (type !== "read"
								&& data.models) {
							return {
								models : kendo.stringify(data.models)
							};
						}
					}
				},//transport end...
				schema : {
					data : function(response) {
						console.log(response.rtnList);
						return response.rtnList; 
					},
					total : function(response) { return response.total; },
					errors : function(response) { return response.error; },
					parse : function(response) { return response; },
					model : {//가져온 값이 있음...
						id : "content_seq",
						fields : {
							content_seq: { type : "number", editable : false },
							bbs_uid: { type : "string", editable : false },
							rnum : { type : "number", editable : false },
							title : { type : "string", editable : false },
							content : { type : "string", editable : false },
							recnt: { type : "number", editable : false },
							cre_dt : { type : "string", editable : false },
							cre_usr : { type : "string", editable : false },
							mod_dt : { type : "string", editable : false },
							mod_usr : { type : "string", editable : false }
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
					alert("정상적으로 처리되었습니다.");
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
				{ field : "content_seq", title : "seq", hidden: true },
				{ field : "rnum", title : "번호", width : 100, attributes : { style : "text-align: center;" } },
				// Todo: 제목 길이 제한 
				{ field : "title", title : "제목", attributes : { style : "text-align: left;" },
					template : "#= title # [#= recnt#]"},
				{ field : "cre_usr", title : "글쓴이", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "cre_dt", title : "등록일", width : 150, attributes : {	style : "text-align: center;" },
					template : "#= (cre_dt == '') ? '' : kendo.toString(new Date(Number(cre_dt)), 'yyyy-MM-dd hh:mm') #" }
				// Todo: 조회수 필드 추가 예정 
				/* 
				{ field : "expose_from", title : "게시시작", attributes : {	style : "text-align: center;" },
					template : "#= (expose_from == '') ? '' : kendo.toString(new Date(Number(expose_from)), 'yyyy-MM-dd HH:mm') #" },
				{ field : "expose_to", title : "게시종료", attributes : {	style : "text-align: center;" },
					template : "#= (expose_to == '') ? '' : kendo.toString(new Date(Number(expose_to)), 'yyyy-MM-dd HH:mm') #" },
				{ command: { 
					text : " ", click: showDetails, className: "fa fa-folder" }, title: "", width: "100px", attributes : {	style : "text-align: center;" } }
				*/
			],
			change: function(e) {
        		// find seq value in selected row  	
				var selectedItem = this.dataItem(this.select());
				G_SEQ = selectedItem.content_seq;
				console.log("selected item: ");
                console.log(selectedItem);
        		// read bbsViewModel by G_SEQ 
        		bbsViewModel.dataSource.read();
        		$("#delete-btn").css("display", "inline-block");
        		$("#reply").css("display", "inline-block");
                // open window
        		wnd.center().open();
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
			resizable : true, //컬럼 크기 조절
			reorderable : true //컬럼 위치 이동
		});//grid-content end...
		
		/*
		 * view model for window data 
		 */
		bbsModel = kendo.data.Model.define({
			id: "content_seq",
			fields: {
				content_seq	:{ type: "string" },
				bbs_uid		:{ type: "string", defaultValue: "${bbsInfo.bbs_uid}" },
				title		:{ type: "string" },
				content		:{ type: "string" },
				mod_dt		:{ type: "string" },
				mod_usr		:{ type: "string" },           
				cre_dt		:{ type: "string" },
				cre_usr		:{ type: "string" }           
			}
		});
		
	    /*** dataSource ***/
		bbsViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: crudServiceBaseUrl + "/read.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("complete /read.do...................");
		    			}
					},
					update: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destroy: { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
					create: { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
								bbs_uid : "${bbsInfo.bbs_uid}",
								content_seq : G_SEQ
							};
							return { params: kendo.stringify(result) }; 
						}
		               
						if (type !== "read" && data.models) {
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				batch: true,
				schema: {
					model: bbsModel,
					data: function(response) {
						console.log("viewmodel data: ");
						return response;
					},
					total: function(response) {
						console.log("viewmodel total: " + 1);
						return 1;
					},
					errors: function(response) {
						console.log("viewmodel error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						console.log("viewmodel parse: ");
                    	return response;
					}
				},
		        error : function(e) {
			    	console.log('viewmodel error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("viewmodel change: set selected :");
		            var _data = this.data()[0];
					console.log(_data);
					if(typeof _data != "undefined") {
					} else {
						
					}
					bbsViewModel.set("selected", _data);
		        },
		        requestStart : function(e) {
				},
				requestEnd : function(e) {
					console.log("deployViewModel:dataSource:requestEnd");
// 		        	if(e.type != 'read' && e.response.error == null) {
// 		        		alert("정상적으로 처리되었습니다.");
// 						closeWindow(e);
// 		        	} else if(e.type != 'read' && e.response.error != null) {
// 		        		e.preventDefault();
// 						this.cancelChanges();
// 		        		alert("문제가 발생하여 정상적으로 처리되지 않았습니다.");
// 		        	}
				},
		        sync: function(e) { 
		        	console.log("viewmodel save data: ");
     			    console.log(this.data()[0]);
				},
				dataBound: function(e){ 
					console.log("viewmodel dataBound");
				}
			}),
			error : function(e) {
            	console.log("kendo.observable:error" + e.errors);
            },
            change: function(e) {
            	console.log("kendo.observable:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            modify: function (e) {
				console.log("kendo.observable:modify");
				location.href='${contextPath}/bbs/board/form.do?bbs=${bbsInfo.bbs_uid}&con=' + G_SEQ;
            },
            remove: function(e) {
            	console.log("kendo.observable:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
					closeWindow();
                }
            },
            cancel: function(e) {
            	console.log("kendo.observable:cancel");
                this.dataSource.cancelChanges();
                closeWindow();
            }
		});
	    
	    // binding data to window
		kendo.bind($("#window"), bbsViewModel);

		replyModel = kendo.data.Model.define({
	    	id: "reply_seq",
			fields: { 
				runm			: { type: "number", editable: false },
				reply_seq		: { type: "number" },
				cre_usr			: { type: "string" },
				reply			: { type: "string" },
				mod_dt			: { type: "string", editable: false }
			}  
		});
			
	    /*** dataSource ***/
		replyViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read : { url: "${contextPath}/bbs/board/reply/read.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
								bbs_uid : "${bbsInfo.bbs_uid}",
								content_seq : G_SEQ
							};
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				batch: true,
				autoSync: false,
				serverPaging : true, // 서버 사이드 페이징 활성화
				serverFiltering : true,
				serverSorting : true, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
				page : 1, //     반환할 페이지
				pageSize : 10, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 10,
				schema: {
					model: replyModel,
					data: function(response) {
						console.log("replyViewModel:dataSource:data");
						return response.rtnList;
					},
					total: function(response) {
						console.log("replyViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("replyViewModel:dataSource:error: " + response.error);
						return response.error;
					}
				},
		        error : function(e) {
			    	console.log('replyViewModel:dataSource:error: ');
// 			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("replyViewModel:dataSource:change: set selected :");
// 		        	console.log(this.data());
		        	replyViewModel.set("replyData", this.data());
		        },
		        requestEnd: function(e) {
		        	console.log("replyViewModel:dataSource:requestEnd");
		        },
		        sync: function(e) { 
		        	console.log("replyViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("replyViewModel:dataSource:dataBound");
				}
			}),
            add: function(e) {
            	console.log("replyViewModel:add");
    			var replyText = $("#replyText").val();
    			if(replyText != '') {
    				$.ajax({
    					type : "post",
    					url : "${contextPath}/bbs/board/reply/create.do",
    					data : {
    						"text" : replyText,
    						"uid" : "${bbsInfo.bbs_uid}",
    						"con" : G_SEQ
    					},
    					success : function(data, status) {
    						if(data.success) {
    							alert("댓글이 등록되었습니다.");
    						}
    						updateReply();
    					}
    				});
    			}
            },
            batch: true,
            replyData: null,
            hasChanges: false
		});
		    
		kendo.bind($("#reply-content"), replyViewModel);
	});//document ready javascript end...
</script>

<style>
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
<%@ include file="../inc/footer.jsp"%>
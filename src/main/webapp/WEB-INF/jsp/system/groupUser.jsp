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
				<table style="width:100%;height:715px;">
					<colgroup>
						<col width="30%">
						<col width="35%">
						<col>
						<col width="35%">
					</colgroup>
					<tr>
						<th>그룹</th>
						<th>사용자</th>
						<th></th>
						<th><span id="group_name"></span> 그룹 사용자</th>
					</tr>
					<tr>
						<td><div id="group-grid"></div></td>
						<td><div id="user-grid"></div></td>
						<td>
							<div><Button style="width:50px;height:40px;" onclick="addAllGroupUser();"><span class="fa fa-angle-double-right"/></Button></div>
							<p>
							<div><Button style="width:50px;height:40px;" onclick="addGroupUser();"><span class="fa fa-angle-right"/></Button></div>
							<p>
							<div><Button style="width:50px;height:40px;" onclick="removeGroupUser();"><span class="fa fa-angle-left"/></Button></div>
							<p>
							<div><Button style="width:50px;height:40px;" onclick="removeAllGroupUser();"><span class="fa fa-angle-double-left"/></Button></div>
						</td>
						<td><div id="groupuser-grid"></div></td>
					</tr>
				</table>
			</div>
		</div>
	</section>
</section>

<script type="text/x-kendo-template" id="toolbar-template">
	<div id="toolbar" style="float:left;">
		<a href="\\#" class="k-grid-save-changes k-link k-button" id="save-btn" title="Save" onclick="return onClick(this);">저장</a>
	</div>
</script>     
<script>
	var G_GROUP;
	var temp;
	var selectedUser = null;
	var selectedGroupUser = null;
	
	function onClick(e) {
		var id = e.id;
		
		if(id == 'save-btn') {
// 			var users = $("#groupuser-grid").data("kendoGrid").dataSource.data();
			var list = {
				'group_id': G_GROUP,
				'users': JSON.stringify($("#groupuser-grid").data("kendoGrid").dataSource.data())
			};
			$.ajax({
				type: "post",
				url: "<c:url value='/sm/groupuser/update.do'/>",
				data: list,
				async: false, //동기 방식
				success: function(data, status){
					console.log('/update.do');
					if(typeof data.error == 'undefined') {
						console.log(data.result);
						alert("정상적으로 저장되었습니다.");
					} else {
						alert("저장 중 에러가 발생했습니다.");
					}
					refreshUserGrid();
				}
			});		
		}
	}
	
	function addGroupUser() {
		console.log("addGroupUser");
		if(selectedUser != null) {
			$("#groupuser-grid").data("kendoGrid").dataSource.add(selectedUser);
			$("#user-grid").data("kendoGrid").dataSource.remove(selectedUser);
			selectedUser = null;
		}
	}
	
	function removeGroupUser() {
		console.log("removeGroupUser");
		if(selectedGroupUser != null) {
			$("#user-grid").data("kendoGrid").dataSource.add(selectedGroupUser);
			$("#groupuser-grid").data("kendoGrid").dataSource.remove(selectedGroupUser);
			selectedGroupUser = null;
		}
	}
	
	function addAllGroupUser() {
		console.log("addAllGroupUser");
		var userDS = $("#user-grid").data("kendoGrid").dataSource;
		var groupDS = $("#groupuser-grid").data("kendoGrid").dataSource;
		var raw = userDS.data();
		var length = raw.length;
		var i, item;
		for(i = (raw.length - 1); i >= 0; i--) {
			item = raw[i];
			if(item != null) {
				groupDS.add(item);
				userDS.remove(item);
			}
		}
	}
	
	function removeAllGroupUser() {
		console.log("removeAllGroupUser");
		var userDS = $("#user-grid").data("kendoGrid").dataSource;
		var groupDS = $("#groupuser-grid").data("kendoGrid").dataSource;
		var raw = groupDS.data();
		var length = raw.length;
		var i, item;
		for(i = (raw.length - 1); i >= 0; i--) {
			item = raw[i];
			if(item != null) {
				userDS.add(item);
				groupDS.remove(item);
			}
		}
	}
	
	function refreshUserGrid() {
		$("#user-grid").data("kendoGrid").dataSource.read();
		$("#groupuser-grid").data("kendoGrid").dataSource.read();
	}
	
	$(document).ready(function () {
		/*************************/
		/*       splitter        */
		/*************************/
		$("#group-grid").kendoGrid({
			dataSource: {
				transport: {
					read : { url: "${contextPath}/sm/group/read.do", dataType: "jsonp" },
					update : { url: "${contextPath}/sm/group/update.do", dataType: "jsonp" },
					create : { url: "${contextPath}/sm/group/create.do", dataType: "jsonp" },
					destroy : { url: "${contextPath}/sm/group/delete.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						console.log(data);
						console.log(type);

						if (type == "read"){
		                   	var result = {
// 	                   			PAGESIZE : data.pageSize,
// 								SKIP : data.skip,
// 								PAGE : data.page,
// 								TAKE : data.take,
// 		                   		group_id: G_GROUP
							};
							return { params: kendo.stringify(result) }; 
						}
						if (type !== "read" && data.models) {	
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				schema: {
					data: function(response) {
						return response.rtnList;
					},
					total: function(response) {
						return response.total;
					},
					errors: function(response) {
						return response.error;
					},
					model:{
						id: "group_id",
						fields: { 
							group_id	: { type: "number" },
							group_name	: { type: "string" }
						}  
					}
				},
				requestEnd : function(e) {
					console.log("group-grid:dataSource:requestEnd");
		        	if(e.type != 'read' && (typeof(e.response.error) == undefined || e.response.error == null)) {
		        		alert("정상적으로 처리되었습니다.");
		        	} else if(e.type != 'read' && e.response.error != null) {
		        		e.preventDefault();
						this.cancelChanges();
		        		alert("문제가 발생하여 정상적으로 처리되지 않았습니다.");
		        	}
				},
				sync: function(e) {
					console.log("sync complete");
				},
				batch: true
			},
	        error : function(e) {
		    	console.log('group-grid:dataSource:error:' + e.errors);
	        },
			pageable: false,
			height: 715,
			resizable: false,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			mobile: true,
			toolbar : [ 
				{ name : "create", text : "추가" },
// 				{ name : "save", text : "저장" },
				{ name : "cancel", text : "취소" }
			],
			messages: {
				commands : {
					canceledit: "취소",
					update: "저장"
				}
			},
			columns: [
				{ field: "group_id", hidden: true },
				{ field: "group_name", title: "그룹명", attributes: {style: "text-align: center;"},
					filterable: {
                        cell: {
                            operator: "contains",
                            suggestionOperator: "contains"
                        }
                    }
				},
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
			editable:  {
            	mode:  "inline",
				confirmation: "선택한 행을 삭제하시겠습니까?"
            },
			noRecords: false,
            filterable: "row",
            change: function(e) {
				console.log("group-grid:change");
				var selectedItem = this.dataItem(this.select());
		        G_GROUP = selectedItem.group_id;
		        document.getElementById("group_name").innerHTML = selectedItem.group_name;
				console.log("selected item: " + G_GROUP + "(seq)");
				refreshUserGrid();
            },
            dataBound: function(e) {
            	invokeUserAuth("${current_menu}", "kendoGrid");	
            }
		});
		
	    var crudServiceBaseUrl = "${contextPath}/sm/groupuser";
		$("#user-grid").kendoGrid({
			dataSource: {
				transport: {
					read	: { 
						url: crudServiceBaseUrl + "/readNoGroupUsers.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("user-grid:dataSource:read");
					    }
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
		                   		group_id: G_GROUP
							};
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				schema: {
					data: function(response) {
						return response.rtnList;
					},
					total: function(response) {
						return response.total;
					},
					errors: function(response) {
						return response.error;
					},
					model:{
						id: "user_id",
						fields: { //data type of the field {Number|String|Boolean|Date} default is String
							user_id:		{ type: "string" },
							user_name:		{ type: "string" },
							birthday: 		{ type: "string" }
						}  
					}
				},
		        error : function(e) {
			    	console.log('user-grid:dataSource:error: ' + e.errors);
		        },
		        batch : true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: false,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
// 			pageable : {
// 				pageSizes : true,
// 				messages : {
// 					display : "전체 {2} 중 {0}~{1}",
// 					empty : "출력할 항목이 없습니다",
// 					itemsPerPage : "한 페이지 출력 수"
// 				}
// 			},
			toolbar: false,
			columns: [
				{ field: "user_id", title: "아이디", attributes : { style : "text-align: center;" } },
				{ field: "user_name", title: "이름", attributes : { style : "text-align: center;" } },
				{ field: "birthday", title: "생년월일", attributes : { style : "text-align: center;" },
					template: "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				}
			],
			editable: false,
			noRecords: false,
            change: function(e) {
				console.log("user-grid:change");
				selectedUser = this.dataItem(this.select());
				console.log("selected item: " + selectedUser.user_seq + "(seq)");
            },
            dataBound: function(e) {
            	console.log("user-grid:dataBound");
            	selectedUser = null;
            }
		});
		
		$("#groupuser-grid").kendoGrid({
			dataSource: {
				transport: {
					read : { 
						url: crudServiceBaseUrl + "/readGroupUsers.do",
						dataType: "jsonp", 
						complete: function(e){ 
					    	console.log("groupuser-grid:dataSource:read");
					    }
					},
					update : { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					create : { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destory : { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
		                   		group_id: G_GROUP
							};
							return { params: kendo.stringify(result) }; 
						}
						if (type == "update"){
		                   	var result = {
		                   		group_id: G_GROUP
							};
							return { 
								params: kendo.stringify(result), 
								models: kendo.stringify(data.models) 
							}; 
						}
						if (type != "read" && type != "update" && data.models) {	
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				schema: {
					data: function(response) {
						return response.rtnList;
					},
					total: function(response) {
						return response.total;
					},
					errors: function(response) {
						return response.error;
					},
					model:{
						id: "user_id",
						fields: { //data type of the field {Number|String|Boolean|Date} default is String
							user_id:		{ type: "string" },
							user_name:		{ type: "string" },
							birthday: 		{ type: "string" }
						}  
					}
				},
		        error : function(e) {
			    	console.log('groupuser-grid:dataSource:error: ' + e.errors);
		        },
		        change : function(e) {
		        	console.log("groupuser-grid:dataSource:change");
		        },  	
		        sync: function(e) {
		        	console.log("groupuser-grid:dataSource:sync");
					alert("정상적으로 처리되었습니다.");  
					refreshUserGrid();
				}, 
				batch: true,
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15
			},
			height: 715,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: false,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
// 			pageable : {
// 				pageSizes : true,
// 				messages : {
// 					display : "전체 {2} 중 {0}~{1}",
// 					empty : "출력할 항목이 없습니다",
// 					itemsPerPage : "한 페이지 출력 수"
// 				}
// 			},
			toolbar: kendo.template($("#toolbar-template").html()),
			columns: [
				{ field: "user_id", title: "아이디", attributes : { style : "text-align: center;" } },
				{ field: "user_name", title: "이름", attributes : { style : "text-align: center;" } },
				{ field: "birthday", title: "생년월일", attributes : { style : "text-align: center;" },
					template: "#= (birthday == '') ? '' : kendo.toString(kendo.parseDate(birthday, 'yyyyMMdd'), 'yyyy-MM-dd') #" 
				}
			],
			editable: false,
			noRecords: false,
			save: function(e) {
				console.log("groupuser-grid:save");
			},
			saveChanges: function(e) { 
				console.log("groupuser-grid:saveChanges");
			},
            change: function(e) {
				console.log("groupuser-grid:change");
				selectedGroupUser = this.dataItem(this.select());
				console.log("selected item: " + selectedGroupUser.user_seq + "(seq)");
            },
            dataBound: function(e) {
				console.log("groupuser-grid:dataBound");
            	selectedGroupUser = null;
            }
		});
		
		$("#user-grid").delegate("tbody>tr", "dblclick", function () {
			var grid = $("#user-grid").data("kendoGrid");
			selectedUser = grid.dataItem(grid.select())
			addGroupUser();
		});
		
		$("#groupuser-grid").delegate("tbody>tr", "dblclick", function () {
			var grid = $("#groupuser-grid").data("kendoGrid");
			selectedGroupUser = grid.dataItem(grid.select())
			removeGroupUser();
		});
	});	
</script>	
<style>
	.k-grid table {
		table-layout: fixed;
	}
</style>
<%@ include file="../inc/footer.jsp"%>
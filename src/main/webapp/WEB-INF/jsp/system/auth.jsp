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
				<div id="vertical" style="height:715px;">
					<div id="top-pane">
						<div id="horizontal" style="height: 100%; width: 100%;">
							<div id="left-pane">
								<div class="pane-content">
									<h3>역할</h3>
									<p><div id="role-grid"></div>
								</div>
							</div>
							<div id="right-pane">
								<div class="pane-content">
									<div id="tabstrip">
										<ul>
											<li class='k-state-active'>역할</li>
											<li>사용자 및 그룹</li>
											<li>시스템 리소스</li>
											<li>메뉴</li>
										</ul>
										<div>
											<div id="tab1-content">
												<div class="col-md-10" style="float: right;">
													<button class="btn btn-primary btn-sm btn-auth-u" 
															data-role="button" 
															data-bind="click: remove, enabled: selected.editabled"
															style="float:right;margin:10px 10px 0 0;">
															<spring:message code="button.delete" text="delete" /></button>
													<button class="btn btn-primary btn-sm btn-auth-d" 
															data-role="button" 
															data-bind="click: save, enabled: selected.editabled"
															style="float:right;margin:10px 10px 0 0;">
															<spring:message code="button.save" text="save" /></button>
												</div>
												<form id="role-form">
													<table style="width:95%;">
														<colgroup>
															<col width="40%">
															<col width="60%">
														</colgroup>
														<tbody>
															<tr>
																<th>상위역할</th>
																<td>
																	<input id="parent-id" name="parent-id" 
																			data-option-label="상위역할을 선택하세요."
																			data-role="dropdownlist"
																			data-auto-bind="true"
																			data-value-primitive="true"
																			data-text-field="text"
					            											data-value-field="value"
																			data-bind="value:selected.parent_id,
																						source: roleParentDataSource"
																			required validationMessage="상위역할을 선택하세요."
																			style="width:100%;display:none;"/>
																</td>
															</tr>
															<tr>
																<th>역할명</th>
																<td>
																	<input id="role-name" name="role-name" 
																			data-role="maskedtextbox" 
																			data-bind="value:selected.role_name" 
																			required validationMessage="역할명을 입력하세요." 
																			style="width:100%;"/>
																</td>
															</tr>
															<tr>
																<th>설명</th>
																<td>
																	<input id="description" name="description" 
																		data-role="maskedtextbox" 
																		data-bind="value:selected.description" 
																		style="width:100%;"/>
																</td>
															</tr>
														</tbody>
													</table>
												</form>
											</div>
										</div>
										<div>
											<div id="horizontal2" style="height: 100%; width: 100%;">
						                        <div id="left-pane2">
													<div class="pane-content">
							                           	<div id="tab4_1-content" class="col-md-5" style="width: 95%;height: 100%;">
		            										<h4>그룹</h4>
		            										<hr class="alt short">
	            											<form id="group-role-form">
																<table style="width:100%;">
																	<colgroup>
																		<col width="70%">
																		<col width="30%">
																	</colgroup>
																	<thead>
																		<tr>
																			<th>그룹</th>
																			<th>권한</th>
																		</tr>
																	</thead>
																	<tbody data-template="role-group-row-template" data-bind="source: rolesGroup">
																	</tbody>
																</table>
															</form>
		          										</div>
													</div>
						                        </div>
						                        <div id="right-pane2">
						                            <div class="pane-content">
						                                <div id="tab4_2-content" class="col-md-6" style="width: 95%;height: 100%;">
				            								<h4><span id="group_name"></span> 멤버</h4>
		        										    <hr class="alt short">
		            										<form id="group-role-form">
																<table style="width:100%;">
																	<colgroup>
																		<col width="35%">
																		<col width="35%">
																		<col width="30%">
																	</colgroup>
																	<thead>
																		<tr>
																			<th>아이디</th>
																			<th>이름</th>
																			<th>권한</th>
																		</tr>
																	</thead>
																	<tbody data-template="role-user-row-template" data-bind="source: rolesUser">
																	</tbody>
																</table>
															</form>
									        			</div>
						                            </div>
						                        </div>
						                    </div>
										</div>
										<div>
											<div id="tab2-content">
<!-- 												<div id="grid-secured-res"></div> -->
												<h4>시스템 리소스 권한</h4>
		            							<hr class="alt short">
												<form id="form2">
													<table style="width:100%;">
														<colgroup>
															<col width="10%">
															<col width="15%">
															<col width="*">
															<col width="20%">
															<col width="10%">
															<col width="10%">
														</colgroup>
														<thead>
															<tr>
																<th>우선순위</th>
																<th>리소스명</th>
																<th>리소스패턴</th>
																<th>설명</th>
																<th>리소스타입</th>
																<th>적용</th>
															</tr>
														</thead>
														<tbody data-template="resource-row-template" data-bind="source: resourceData"></tbody>
													</table>
													<div id="pager" data-role="pager" data-bind="source: dataSource" data-auto-bind="false"></div>
												</form>
											</div>
										</div>
										<div>
											<div id="tab3-content">
												<form id="form3">
													<table style="width:100%;">
														<colgroup>
															<col width="30%">
															<col width="30%">
															<col width="8%">
															<col width="8%">
															<col width="8%">
															<col width="8%">
															<col width="8%">
														</colgroup>
														<thead>
															<tr>
																<th>상위메뉴명</th>
																<th>메뉴명</th>
																<th>
																	권한
																	<p>
																	<span class="fa fa-eye" <c:if test="${auth.auth_u eq 'true'}"> onclick="toggleAuthBtn('r')"></c:if>></span> 
																	조회
																</th>
																<th><span class="fa fa-pencil" <c:if test="${auth.auth_u eq 'true'}"> onclick="toggleAuthBtn('c')"></c:if>></span> 생성</th>
																<th><span class="fa fa-wrench" <c:if test="${auth.auth_u eq 'true'}"> onclick="toggleAuthBtn('u')"></c:if>></span> 수정</th>
																<th><span class="fa fa-trash-o" <c:if test="${auth.auth_u eq 'true'}"> onclick="toggleAuthBtn('d')"></c:if>></span> 삭제</th>
																<th><span class="fa fa-print" <c:if test="${auth.auth_u eq 'true'}"> onclick="toggleAuthBtn('p')"></c:if>></span> 출력</th>
															</tr>
														</thead>
														<tbody data-template="menu-auth-row-template" data-bind="source: menuAuth">
														</tbody>
													</table>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>
<script id="resource-row-template" type="text/x-kendo-template">
    <tr style="height:30px;">
        <td data-bind="text: res_id"></td>
        <td data-bind="text: res_name"></td>
        <td data-bind="text: res_pattern"></td>
        <td data-bind="text: description"></td>
        <td data-bind="text: res_type"></td>
        <td><input name="is_auth" data-role="kendo.mobile.ui.Switch" data-bind="value: is_auth" data-enable="${auth.auth_u}"/></td>
    </tr>
</script>
<script id="menu-auth-row-template" type="text/x-kendo-template">
    <tr style="height:30px;">
        <td>
			<span class="fa fa-list-ul"></span> #=main_name#
		</td>
        <td data-bind="text: menu_name"></td>
        <td><input name="auth-r" data-role="kendo.mobile.ui.Switch" data-bind="value: auth_r" data-enable="${auth.auth_u}"/></td>
        <td><input name="auth-c" data-role="kendo.mobile.ui.Switch" data-bind="value: auth_c" data-enable="${auth.auth_u}"/></td>
        <td><input name="auth-u" data-role="kendo.mobile.ui.Switch" data-bind="value: auth_u" data-enable="${auth.auth_u}"/></td>
        <td><input name="auth-d" data-role="kendo.mobile.ui.Switch" data-bind="value: auth_d" data-enable="${auth.auth_u}"/></td>
        <td><input name="auth-p" data-role="kendo.mobile.ui.Switch" data-bind="value: auth_p" data-enable="${auth.auth_u}"/></td>
    </tr>
</script>
<script id="role-group-row-template" type="text/x-kendo-template">
    <tr data-bind="click:showGroupMember" style="height:30px;">
        <td>
			<span class="fa fa-group"></span> #=group_name# (#=member_count#)
		</td>
        <td>
			#if (group_id == 0) {##}else{#<input name="is-role" data-role="kendo.mobile.ui.Switch" data-bind="value: is_role" data-enable="${auth.auth_u}"/>#}#
		</td>
    </tr>
</script>
<script id="role-user-row-template" type="text/x-kendo-template">
    <tr style="height:30px;">
        <td>
			<span class="fa fa-user"></span> #=user_id#
		</td>
        <td data-bind="text: user_id"></td>
        <td><input name="is-role" data-role="kendo.mobile.ui.Switch" data-bind="value: is_role" data-enable="${auth.auth_u}"/></td>
    </tr>
</script>
<script>
	var G_ROLE_ID;
	var G_TAB_IDX = 0;
	var tabStripElement;
	
	function toggleAuthBtn(type) {
		console.log(type);
		var data = menuAuthViewModel.dataSource.data();
		var length = data.length;
		var i;
		for(i = 0; i < length; i++) {
			var type;
			if(type == 'c') {
				type = "auth_c";
			} else if(type == 'r') {
				type = "auth_r";
			} else if(type == 'u') {
				type = "auth_u";
			} else if(type == 'd') {
				type = "auth_d";
			} else if(type == 'p') {
				type = "auth_p";
			}
			var value = data[i].get(type);
			data[i].set(type, !value);
		}
	}
	
	$(document).ready(function () {
		/*************************/
		/*       splitter        */
		/*************************/
		$("#vertical").kendoSplitter({
			orientation: "vertical",
			panes: [
				{ collapsible: false }
			]
		});
		$("#horizontal").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: false, resizable: false, scrollable: false, size: "30%" },
				{ collapsible: false, scrollable: false }
			]
		});
		$("#horizontal2").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: false, resizable: false, scrollable: true, size: "50%" },
				{ collapsible: false, scrollable: true }
			]
		});
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// kendo tablstrip auto height
		var resizeAll = function() {
		    expandContentDivs(tabStripElement.children(".k-content")); 
		}

		tabStripElement = $("#tabstrip").kendoTabStrip({
		    animation: {
		        open: {
		            effects: "fadeIn"
		        }
		    },
		    change: function(e) {
		    	console.log("tap change");
		    	G_TAB_IDX = this.select().index();
		    	updatePage();
		    }
		});
		var tabStrip = tabStripElement.data("kendoTabStrip");

		var expandContentDivs = function(divs) {
		    divs.height(tabStripElement.innerHeight() - tabStripElement.children(".k-tabstrip-items").outerHeight() - 16);
		}
		// 16px are substracted to compensate for content div vertical paddings and borders

		tabStripElement.parent().attr("id", "tabstrip-parent");

		resizeAll();

		$(window).resize(function(){
		    resizeAll();
		});
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		

		function updatePage() {
			if(G_ROLE_ID != null) {
				if(G_TAB_IDX == 0) {
					roleViewModel.dataSource.read();
				} else if(G_TAB_IDX == 1) {
					groupViewModel.dataSource.read();
					document.getElementById("group_name").innerHTML = "";
					G_GROUP_ID = -1;
				} else if(G_TAB_IDX == 2) {
					resourceViewModel.dataSource.read();
				} else {
					menuAuthViewModel.dataSource.read();
				}
			}
		}
		
		$("#role-grid").kendoTreeList({
			dataSource:	{
				transport: {
					read : { url: "${contextPath}/sm/auth/role/read.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
		                   	var result = {
							};
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				schema: {
					data: function(response) {
						return response;
					},
					errors: function(response) {
						return response.error;
					},
					parse: function(response) {
						for (var i = 0; i < response.length; i++) {
							if(typeof response[i].parent_id == "undefined") {
								response[i].parent_id = null;
							}
						}
						return response;
					},
					model : {//가져온 값이 있음...
						id: "role_id",
						parentId: "parent_id",
						fields: { 
							role_id		: { type: "string", editable: false, nullable: false },
							parent_id	: { type: "string", nullable: true },
							role_name	: { type: "string" },
							description : { type: "string" },
							editabled	: { type: "boolean" },
							cre_dt		: { type: "string" },
							mod_dt		: { type: "string" }
						},
						expanded: true
					}
				}
			},
	        error : function(e) {
		    	console.log('role-grid:dataSource:error:' + e.errors);
	        },
			pageable: false,
			height: 660,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			mobile: true,
			columns: [
				{ field: "role_name", title: "역할명", attributes: {style: "text-align: left;"} },
				{ field: "description", title: "설명", attributes: {style: "text-align: left;"} }
			],
			editable: false,
			noRecords: false,
			filterable: false,
            save : function(e) {//저장전 이벤트
			},
			saveChanges : function(e) {//저장버턴 클릭시 이벤트 
			},
			edit : function(e) {
			},
			dataBound : function(e) {
			},
            change: function(e) {
				console.log("role-grid:change");
				var selectedItem = this.dataItem(this.select());
				G_ROLE_ID = selectedItem.role_id;
				updatePage();
            }
		});
		
		///////////////////////////////////////////////////////////////////////////////////////////////
	    // tab1
	    ///////////////////////////////////////////////////////////////////////////////////////////////
		roleModel = kendo.data.Model.define({
			id: "role_id",
			fields: { 
				role_id		: { type: "string", editable: false, nullable: false },
				parent_id	: { type: "string", nullable: true },
				role_name	: { type: "string" },
				description : { type: "string" },
				editabled	: { type: "boolean" },
				cre_dt		: { type: "string" },
				mod_dt		: { type: "string" }
			}
		});
		
	    /*** dataSource ***/
	    var crudServiceBaseUrl = "${contextPath}/sm/auth";
		roleViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read : { url: "${contextPath}/sm/auth/role/detail.do", dataType: "jsonp" },
					update : { url: "${contextPath}/sm/auth/role/update.do", dataType: "jsonp" },
					create : { url: "${contextPath}/sm/auth/role/save.do", dataType: "jsonp" },
					destroy : { url: "${contextPath}/sm/auth/role/delete.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							return { params : G_ROLE_ID }; 
						}
		               
						if (type !== "read" && data.models) {
							return { models: kendo.stringify(data.models) };
						}
					}
				},
				batch: true,
				schema: {
					model: roleModel,
					data: function(response) {
						console.log("roleViewModel:dataSource:data");
						return response.rtnList;
					},
					total: function(response) {
						console.log("roleViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("roleViewModel:dataSource:error: " + response.error);
						return response.error;
					}
				},
		        error : function(e) {
			    	console.log('roleViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("roleViewModel:dataSource:change: set selected :");
					var _data = this.data()[0];
					roleViewModel.set("selected", _data);
		        },
		        requestEnd: function(e) {
		        	console.log("roleViewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && e.response.error == null) {
		        		alert("정상적으로 처리되었습니다.");
		        		$("#role-grid").data("kendoTreeList").dataSource.read();
		        	} else if(e.type != 'read') {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("roleViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("roleViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("roleViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("roleViewModel:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            save: function (e) {
				console.log("roleViewModel:save");
				if($("#role-form").kendoValidator().data("kendoValidator").validate()) {
	                if (confirm("저장하시겠습니까?")) {
						console.log(this.dataSource.data()[0]);
						this.dataSource.sync();
	                }
				}
            },
            remove: function(e) {
            	console.log("roleViewModel:remove");
            	var tree = $("#treeview").data("kendoTreeView");
				var item = tree.dataItem(tree.select());
				if(item.hasChildren) {
					alert("삭제할 수 없습니다.\n하위 메뉴 삭제 후 다시 시도해주시기 바랍니다.");
				} else {
	                if (confirm("삭제하시겠습니까?")) {
	                	console.log("remove");
	                    this.dataSource.remove(this.dataSource.data()[0]);
	                    this.dataSource.sync();
	                }
				}
            },
            cancel: function(e) {
            	console.log("roleViewModel:cancel");
                this.dataSource.cancelChanges();
            },
            roleParentDataSource: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/common/getTableDataList.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
	                       	var result = {
                       			TABLE:"SYS_ROLE",
								TEXT:"ROLE_NAME",
								VALUE:"ROLE_ID"
							};
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				schema: {
					data: function(response) {
						return response;
					},
					model:{
						id: "value",
						fields: { 
							value	: { type: "string" },
							text	: { type: "string" }
						}  
					}
				},
            }),
		});
	    
	    // binding data to right-pane
		kendo.bind($("#tab1-content"), roleViewModel);
	    
	    ///////////////////////////////////////////////////////////////////////////////////////////////
	    // tab2
	    ///////////////////////////////////////////////////////////////////////////////////////////////
// 	    $("#grid-secured-res").kendoGrid({
// 			dataSource: {
// 				transport: {
// 					read : { url: "${contextPath}/sm/resource/role/read.do", dataType: "jsonp" },
// 					update : { url: "${contextPath}/sm/resource/role/save.do", dataType: "jsonp" },
// // 					create : { url: "${contextPath}/sm/resource/role/create.do", dataType: "jsonp" },
// 					destroy : { url: "${contextPath}/sm/resource/role/save.do", dataType: "jsonp" },
// 					parameterMap: function(data, type) {
// 						if (type == "read"){
// 		                   	var result = {
// 	                   			PAGESIZE : data.pageSize,
// 								SKIP : data.skip,
// 								PAGE : data.page,
// 								TAKE : data.take,
// 								role_id : G_ROLE_ID 
// 							};
// 							return { params: kendo.stringify(result) }; 
// 						}
// 						if (type !== "read" && data.models) {	
// 							return { 
// 								models: kendo.stringify(data.models),
// 								roleID: G_ROLE_ID
// 							};
// 						}
// 					}
// 				},
// 				schema: {
// 					data: function(response) {
// 						return response.rtnList;
// 					},
// 					total: function(response) {
// 						return response.total;
// 					},
// 					errors: function(response) {
// 						return response.error;
// 					},
// 					model:{
// 						id: "res_id",
// 						fields: { 
// 							runm			: { type: "number", editable: false },
// 							res_id			: { type: "string", editable: false },
// 							role_id			: { type: "string" },
// 							res_name		: { type: "string", editable: false },
// 							res_pattern		: { type: "string", editable: false },
// 							description		: { type: "string", editable: false },
// 							res_type		: { type: "string", defaultValue: 'url', editable: false },
// 							sort_order		: { type: "number", defaultValue: 1, editable: false }
// 						}  
// 					}
// 				},
// 				requestEnd : function(e) {
// 					console.log("grid-secured-res:dataSource:requestEnd");
// // 		        	if(e.type != 'read' && (typeof(e.response.error) == undefined || e.response.error == null)) {
// // 		        		alert("정상적으로 처리되었습니다.");
// // 		        	} else 
// 		        	if(e.type != 'read' && e.response.error != null) {
// 		        		e.preventDefault();
// 						this.cancelChanges();
// 		        		alert("문제가 발생하여 정상적으로 처리되지 않았습니다.");
// 		        	}
// 				},
// 				sync: function(e) {
// 					console.log("sync complete");
// 				},
// 				serverPaging : true, // 서버 사이드 페이징 활성화
// 				serverFiltering : false,
// 				serverSorting : false, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
// 				autoSync: true,          //     자동 저장
// 				batch : true, //     true: 쿼리를 한줄로,  false : row 단위로
// 				page : 1, //     반환할 페이지
// 				pageSize : 15, //     반환할 항목 수
// 				skip : 0, //     건너뛸 항목 수
// 				take : 15
// 			},
// 	        error : function(e) {
// 		    	console.log('grid-secured-res:dataSource:error:' + e.errors);
// 	        },
// 			height: 600,
// 			autoBind: false,
// 			navigatable: true,
// 			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
// 			scrollable: true,
// 			mobile: true,
// 			toolbar : false,
// 			columns: [
// 				{ field: "sort_order", title: "우선순위", width: 80, attributes: {style: "text-align: center;"} },
// 				{ field: "res_id", hidden: true },
// 				{ field: "res_name", title: "리소스명", width: 150, attributes: {style: "text-align: center;"} },
// 				{ field: "res_pattern", title: "리소스패턴", attributes: {style: "text-align: left;"} },
// 				{ field: "description", title: "설명", width: 250, attributes: {style: "text-align: left;"} },
// 				{ field: "res_type", title: "리소스타입", width: 100, attributes: {style: "text-align: center;"} },
// 				{ field: "is_auth", title: "적용", width: 80,  attributes: {style: "text-align: center;"},
// 					editor : function(container, options) {
// 						$('<input name="' + options.field + '"/>')
// 						.appendTo(container)
// 						.kendoMobileSwitch({
// 							onLabel: "적용",
// 							offLabel: "미적용"
// 						});
// 					},
// 					template : "#=(is_auth) ? '적용' : '미적용'#"
// 				}
// 	    	],
// 			editable: true,
//             noRecords : {
// 				template : "검색된 결과가 없습니다."
// 			},
// 			pageable : {
// 				//refresh: true, //하단의 리프레쉬 아이콘
// 				pageSizes : true,
// 				//buttonCount: 1  //paging 갯수
// 				//input: true //페이지 직접입력
// 				//info: false //하단의 페이지 정보
// 				messages : {
// 					display : "전체 {2}개 항목 중 {0}~{1}번째 항목 출력",
// 					empty : "출력할 항목이 없습니다",
// 					itemsPerPage : "한 페이지에 출력할 항목 수"
// 				}
// 			},
// 			resizable : true, //컬럼 크기 조절
// 			reorderable : true, //컬럼 위치 이동
//             filterable: "row",
//             change: function(e) {
// 				console.log("grid-secured-res:change");
//             },
//             save: function(e) {
//             	console.log("grid-secured-res:save");
//             }
// 		});
	    
	    resourceModel = kendo.data.Model.define({
	    	id: "res_id",
			fields: { 
				runm			: { type: "number", editable: false },
				res_id			: { type: "string", editable: false },
				role_id			: { type: "string" },
				res_name		: { type: "string", editable: false },
				res_pattern		: { type: "string", editable: false },
				description		: { type: "string", editable: false },
				res_type		: { type: "string", editable: false },
				sort_order		: { type: "number", editable: false },
				is_auth			: { type: "boolean" }
			}  
		});
		
	    /*** dataSource ***/
		resourceViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read : { url: "${contextPath}/sm/resource/role/read.do", dataType: "jsonp" },
					update : { url: "${contextPath}/sm/resource/role/save.do", dataType: "jsonp" },
// 					create : { url: "${contextPath}/sm/resource/role/create.do", dataType: "jsonp" },
// 					destroy : { url: "${contextPath}/sm/resource/role/save.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						console.log(data);
						console.log(type);
						if (type == "read"){
		                   	var result = {
	                   			PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take,
								role_id : G_ROLE_ID 
							};
							return { params: kendo.stringify(result) }; 
						}
						if (type !== "read" && data.models) {	
							return { 
								models: kendo.stringify(data.models),
								role_id: G_ROLE_ID
							};
						}
					}
				},
				batch: true,
				autoSync: true,
				serverPaging : true, // 서버 사이드 페이징 활성화
				serverFiltering : true,
				serverSorting : true, // 서버 사이드 정렬 활성화          sort[0][field]=필드명, sort[0][dir]=asc|desc 요청 파라메터 전달
				page : 1, //     반환할 페이지
				pageSize : 15, //     반환할 항목 수
				skip : 0, //     건너뛸 항목 수
				take : 15,
				schema: {
					model: resourceModel,
					data: function(response) {
						console.log("resourceViewModel:dataSource:data");
						return response.rtnList;
					},
					total: function(response) {
						console.log("resourceViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("resourceViewModel:dataSource:error: " + response.error);
						return response.error;
					},
					parse: function(response) {
// 						for (var i = 0; i < response.total; i++) {
// 							response.rtnList[i].id = "" + response.rtnList[i].res_id + response.rtnList[i].target_id + response.rtnList[i].target_type;
// 						}
						return response;
					}
				},
		        error : function(e) {
			    	console.log('resourceViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("resourceViewModel:dataSource:change: set selected :");
		        	console.log(this.data());
		        	resourceViewModel.set("resourceData", this.data());
		        },
		        requestEnd: function(e) {
		        	console.log("resourceViewModel:dataSource:requestEnd");
// 		        	if(e.type != 'read' && e.response.error == null) {
// 		        		alert("정상적으로 처리되었습니다.");
// 		        		$("#treeview").data("kendoTreeView").dataSource.read();
// 		        	} else 
		        	if(e.type != 'read' && e.response.error != null) {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("resourceViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("resourceViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("resourceViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("resourceViewModel:change");
            },
            batch: true,
            resourceData: null,
            hasChanges: false
		});
	    
	    // binding data to tab2-content
		kendo.bind($("#tab2-content"), resourceViewModel);
	    
	    
	    ///////////////////////////////////////////////////////////////////////////////////////////////
	    // tab3
	    ///////////////////////////////////////////////////////////////////////////////////////////////
        menuAuthModel = kendo.data.Model.define({
			fields: {
				menu_seq			:{ type: "number", validation: { required: true } },
				menu_name			:{ type: "string" },
				menu_order			:{ type: "number" },
				main_name			:{ type: "string" },
				main_order			:{ type: "number" },
				target_id			:{ type: "string", validation: { required: true } },
				target_type			:{ type: "string", validation: { required: true } },
				auth_c				:{ type: "boolean" },
				auth_r				:{ type: "boolean" },
				auth_u				:{ type: "boolean" },
				auth_d				:{ type: "boolean" },
				auth_p				:{ type: "boolean" }
			}	
		});
		
	    /*** dataSource ***/
		menuAuthViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: "${contextPath}/sm/auth/readAuth.do",
		    			dataType: "jsonp"
					},
					update: { url: "${contextPath}/sm/auth/save.do", dataType: "jsonp" },
// 					destroy: { url: "${contextPath}/sm/auth/delete.do", dataType: "jsonp" },
// 					create: { url: "${contextPath}/sm/auth/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							return { params: G_ROLE_ID }; 
						}
		               
						if (type !== "read" && data.models) {
							return { 
								params: G_ROLE_ID,
								models: kendo.stringify(data.models) 
							};
						}
					}
				},
				batch: true,
				autoSync: true,
				schema: {
					model: menuAuthModel,
					data: function(response) {
						console.log("menuAuthViewModel:dataSource:data");
						return response.rtnList;
					},
					total: function(response) {
						console.log("menuAuthViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("menuAuthViewModel:dataSource:error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						for (var i = 0; i < response.total; i++) {
							response.rtnList[i].id = "" + response.rtnList[i].menu_seq + response.rtnList[i].target_id + response.rtnList[i].target_type;
						}
						return response;
					}
				},
		        error : function(e) {
			    	console.log('menuAuthViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("menuAuthViewModel:dataSource:change: set selected :");
		        	console.log(this.data());
		        	menuAuthViewModel.set("menuAuth", this.data());
		        },
		        requestEnd: function(e) {
		        	console.log("menuAuthViewModel:dataSource:requestEnd");
// 		        	if(e.type != 'read' && e.response.error == null) {
// 		        		alert("정상적으로 처리되었습니다.");
// 		        		$("#treeview").data("kendoTreeView").dataSource.read();
// 		        	} else 
		        	if(e.type != 'read' && e.response.error != null) {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("menuAuthViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("menuAuthViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("menuAuthViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("menuAuthViewModel:change");
            },
            batch: true,
            menuAuth: null,
            hasChanges: false
		});
	    
	    // binding data to tab3-content
		kendo.bind($("#tab3-content"), menuAuthViewModel);
   
	    	    
		///////////////////////////////////////////////////////////////////////////////////////////////
	    // tab4
	    ///////////////////////////////////////////////////////////////////////////////////////////////
        groupModel = kendo.data.Model.define({
			fields: {
				group_id			:{ type: "string", validation: { required: true } },
				group_name			:{ type: "string", validation: { required: true } },
				role_id				:{ type: "string" },
				member_count		:{ type: "number" },
				is_role				:{ type: "boolean" }
			}	
		});
		
	    /*** dataSource ***/
		groupViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: "${contextPath}/sm/auth/role/group/read.do",
		    			dataType: "jsonp"
					},
					update: { url: "${contextPath}/sm/auth/role/group/save.do", dataType: "jsonp" },
// 					destroy: { url: "${contextPath}/sm/auth/role/group/delete.do", dataType: "jsonp" },
// 					create: { url: "${contextPath}/sm/auth/role/group/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							return { params: G_ROLE_ID }; 
						}
		               
						if (type !== "read" && data.models) {
							return { 
								models: kendo.stringify(data.models),
								role_id: G_ROLE_ID
							};
						}
					}
				},
				autoSync: true,
				batch: true,
				schema: {
					model: groupModel,
					data: function(response) {
						console.log("groupViewModel:dataSource:data");
						return response.rtnList;
					},
					total: function(response) {
						console.log("groupViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("groupViewModel:dataSource:error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						for (var i = 0; i < response.total; i++) {
							response.rtnList[i].id = "" + response.rtnList[i].group_id + response.rtnList[i].role_id;
						}
						return response;
					}
				},
		        error : function(e) {
			    	console.log('groupViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("groupViewModel:dataSource:change: set selected :");
		        	console.log(this.data());
		        	groupViewModel.set("rolesGroup", this.data());
		        },
		        requestEnd: function(e) {
		        	console.log("groupViewModel:dataSource:requestEnd");
// 		        	if(e.type != 'read' && e.response.error == null) {
// 		        		alert("정상적으로 처리되었습니다.");
// 		        		$("#treeview").data("kendoTreeView").dataSource.read();
// 		        	} else 
		        	if(e.type != 'read' && e.response.error != null) {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("groupViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("groupViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("groupViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("groupViewModel:change");
				
            },
            batch: true,
            rolesGroup: null,
            hasChanges: false,
            cancel: function(e) {
            	console.log("groupViewModel:cancel");
                this.dataSource.cancelChanges();
            },
            showGroupMember: function(e) {
	            console.log(e);
 	    		G_GROUP_ID = e.data.group_id;
		        document.getElementById("group_name").innerHTML = e.data.group_name;
	    		userViewModel.dataSource.read();
            }
		});
	    
	    // binding data to tab4_1-content
		kendo.bind($("#tab4_1-content"), groupViewModel);
	    
		userModel = kendo.data.Model.define({
			fields: {
				group_id			:{ type: "string", validation: { required: true } },
				user_id				:{ type: "string", validation: { required: true } },
				user_name			:{ type: "string", validation: { required: true } },
				role_id				:{ type: "string" },
				birthday			:{ type: "string" },
				is_role				:{ type: "boolean" }
			}	
		});
		
	    /*** dataSource ***/
		userViewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: "${contextPath}/sm/auth/role/user/read.do",
		    			dataType: "jsonp"
					},
					update: { url: "${contextPath}/sm/auth/role/user/save.do", dataType: "jsonp" },
// 					destroy: { url: "${contextPath}/sm/auth/role/user/delete.do", dataType: "jsonp" },
// 					create: { url: "${contextPath}/sm/auth/role/user/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							return { 
								role_id: G_ROLE_ID,
								group_id: G_GROUP_ID
							}; 
						}
		               
						if (type !== "read" && data.models) {
							return { 
								models: kendo.stringify(data.models),
								role_id: G_ROLE_ID
							};
						}
					}
				},
				autoSync: true,
				batch: true,
				schema: {
					model: userModel,
					data: function(response) {
						console.log("userViewModel:dataSource:data");
						console.log(response.rtnList);
						return response.rtnList;
					},
					total: function(response) {
						console.log("userViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("userViewModel:dataSource:error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						for (var i = 0; i < response.total; i++) {
							response.rtnList[i].id = "" + response.rtnList[i].user_id + response.rtnList[i].role_id;
						}
						return response;
					}
				},
		        error : function(e) {
			    	console.log('userViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("userViewModel:dataSource:change: set selected :");
		        	console.log(this.data());
		        	userViewModel.set("rolesUser", this.data());
		        },
		        requestEnd: function(e) {
		        	console.log("userViewModel:dataSource:requestEnd");
// 		        	if(e.type != 'read' && e.response.error == null) {
// 		        		alert("정상적으로 처리되었습니다.");
// 		        		$("#treeview").data("kendoTreeView").dataSource.read();
// 		        	} else 
		        	if(e.type != 'read' && e.response.error != null) {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("userViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("userViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("userViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("userViewModel:change");
            },
            batch: true,
            rolesUser: null,
            hasChanges: false,
            cancel: function(e) {
            	console.log("userViewModel:cancel");
                this.dataSource.cancelChanges();
            }
		});
	    
	    // binding data to tab4_2-content
		kendo.bind($("#tab4_2-content"), userViewModel);
	});	
</script>	
<style>
	.k-grid {
		width: 100%;
		height: 100%;
	}
	.k-grid table {
		table-layout: fixed;
	}
	#horizontal
 	#vertical {
 	    margin: 0 auto;
 	    border-width: 0;
 	}
	.pane-content {
	    padding: 0px;
	    height: 100%;
	    min-height: 100%;
	}
	#tabstrip,
	#tabstrip-parent {
		height: 100%;
		border-width: 0;
	}
	#horizontal2 {
 	    margin: 0 auto;
 	    border-width: 0;
 	}
	
</style>
<%@ include file="../inc/footer.jsp"%>
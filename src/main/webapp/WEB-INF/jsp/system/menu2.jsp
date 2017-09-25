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
				<div id="horizontal" style="height:715px">
					<div id="left-pane">
						<div id="treeview"></div>
					</div>
					<div id="vertical">
						<div id="right-pane">
							<div class="col-md-10" style="float: right;">
								<button id="remove" class="btn btn-primary btn-sm btn-auth-d" 
										data-role="button" 
										data-bind="click: remove, enabled: isEnabledRemove"
										style="float:right;margin:10px 10px 0 0;">
										<spring:message code="button.delete" text="delete" /></button>
								<button id="save" class="btn btn-primary btn-sm btn-auth-u" 
										data-role="button" 
										data-bind="click: save, enabled: isEnabledSave"
										style="float:right;margin:10px 10px 0 0;">
										<spring:message code="button.save" text="save" /></button>
								<button id="add" class="btn btn-primary btn-sm btn-auth-c" 
										data-role="button" 
										data-bind="click: add, enabled: isEnabledAdd"
										style="float:right;margin:10px 10px 0 0;">
										<spring:message code="button.add" text="add" /></button>
							</div>
							<div class="col-md-10">
								<form id="menu-form">
									<table style="width:100%;">
										<colgroup>
											<col width="30%">
											<col width="70%">
										</colgroup>
										<tbody>
											<tr>
												<th>상위메뉴명</th>
												<td>
													<input id="parent-name" name="parent-name" 
															data-role="maskedtextbox" 
															data-bind="value:selected.parent_name, enabled: isReadonly"
															style="width:100%;background:#ccc;"/>
												</td>
											</tr>
											<tr>
												<th>메뉴ID(영문)</th>
												<td>
													<input id="menu-id" name="menu-id" 
															data-role="maskedtextbox" 
															data-bind="value:selected.menu_id, enabled: isEditable"
															required validationMessage="메뉴 ID를 영문으로 입력하세요."
															style="width:100%;"/>
												</td>
											</tr>
											<tr>
												<th>메뉴명</th>
												<td>
													<input id="menu-name" name="menu-name" 
															data-role="maskedtextbox" 
															data-bind="value:selected.menu_name, enabled: isEditable" 
															required validationMessage="메뉴명을 입력하세요." 
															style="width:100%;"/>
												</td>
											</tr>
											<tr>
												<th>메뉴타입</th>
												<td>
													<input id="menu-type" name="menu-type" 
															data-option-label="메뉴 타입을 선택하세요."
															data-role="dropdownlist"
															data-auto-bind="true"
															data-value-primitive="true"
															data-text-field="text"
	            											data-value-field="value"
															data-bind="value:selected.menu_type,
																		source: menuTypeDataSource,
																		enabled: isEditable,
																		events: {
																			change: onChangeMenuType
																		}"
															required validationMessage="메뉴타입을 선택하세요."
															style="width:100%;display:none;"/>
												</td>
											</tr>
											<tr id="menu-type-bbs" style="display:none;">
												<th>게시판</th>
												<td>
													<input id="bbs-uid" name="bbs-uid" 
															data-option-label="사용할 게시판을 선택하세요."
															data-role="dropdownlist"
															data-auto-bind="false"
															data-value-primitive="true"
															data-text-field="text"
	            											data-value-field="value"
															data-bind="value:selected.bbs_uid,
																		source: bbsDataSource,
																		enabled: isEditable,
																		events: {
																			change: onChangeBBS
																		}"
															style="width:100%;display:none;"/>
												</td>
											</tr>
											<tr id="menu-type-inner" style="display:none;">
												<th>내부페이지</th>
												<td>
													<input id="inner-page" name="inner-page"
															data-option-label="사용할 내부페이지를 선택하세요."
															data-role="dropdownlist"
															data-auto-bind="false"
															data-value-primitive="true"
															data-text-field="name"
	            											data-value-field="url"
															data-bind="value:selected.menu_url,
																		source: innerPageDS,
																		enabled: isEditable"
															style="width:100%;display:none;"/>
												</td>
											</tr>
											<tr>
												<th>메뉴경로(URL)</th>
												<td>
													<input id="menu-url" name="menu-url" 
															data-role="maskedtextbox" 
															data-bind="value:selected.menu_url, enabled: isEditableUrl" 
															required validationMessage="메뉴 경로를 입력하세요."
															style="width:100%;"/>
												</td>
											</tr>
											<tr>
												<th>우선순위</th>
												<td>
													<input id="menu-order" name="menu-order" 
															data-role="numerictextbox" 
															data-bind="value:selected.menu_order, enabled: isEditable"
															data-min="1" 
															data-max="99999" 
															data-format="n0" 
															required validationMessage="메뉴가 노출된 순위(1~99999)를 입력하세요." 
															style="width:100%;"/>
												</td>
											</tr>
											<tr>
												<th>아이콘</th>
												<td>
													<input id="menu-icon" name="menu-icon" 
															data-option-label="메뉴를 대표할 아이콘을 선택하세요."
															data-role="dropdownlist"
															data-auto-bind="false"
															data-value-primitive="true"
															data-text-field="text"
	            											data-value-field="value"
	            											data-template="dataTemplate"
															data-bind="value:selected.menu_icon,
																		enabled: isEditable,
																		source: iconDataSource" 
															style="width:100%;display:none;"/>
												</td>
											</tr>
											<tr>
												<th>사용유무</th>
												<td>
													<label>
														<input name="use-yn" type="radio" value="true" data-bind="checked: selected.use_yn, enabled: isEditable" />
													    <span>사용</span>
													</label>
													<label>
														<input name="use-yn" type="radio" value="false" data-bind="checked: selected.use_yn, enabled: isEditable" />
													    <span>미사용</span>
													</label>
												</td>
											</tr>
											<tr>
												<th>메뉴설명</th>
												<td>
													<input id="description" name="description" 
															data-role="maskedtextbox" 
															data-bind="value:selected.description, enabled: isEditable" 
															style="width:100%;"/>
												</td>
											</tr>
										</tbody>
									</table>
								</form>
							</div>
						</div>
					</div>
               	</div>
			</div>
		</div>
	</section>
</section>

<script id="dataTemplate" type="text/x-kendo-template">
	<span class='#: data.value#'></span> <span>#: data.text#</span>
</script>

<script>
	var viewModel;
	var G_SEQ = 0;
	$(document).ready(function () {
		
		/*************************/
		/*       splitter        */
		/*************************/
		$("#horizontal").kendoSplitter({
			orientation: "horizontal",
			panes: [
				{ collapsible: false, resizable: true, scrollable: false, min: "100px",	size: "20%"	}, 
				{ collapsible: false, resizable: true, scrollable: false, min: "100px" }      
			]
		});
		$("#vertical").kendoSplitter({
			orientation: "vertical",
			panes: [
				{ collapsible: false, resizable: false }, 
				{ collapsible: false, resizable: false }
			]
		});
	
		var crudServiceBaseUrl = "${contextPath}/sm/menu";
		
        $("#treeview").kendoTreeView({
            dataSource: {
            	transport: {
    				read : { 
    					url: crudServiceBaseUrl + "/readHierarchy.do", 
    					dataType: "jsonp" 
    				}
    			},
    			schema: {
    				data: function(response) {
//     					console.log(response.rtnList);
    					return response.rtnList;
    				},
    				errors: function(response) {
    					return response.error;
    				},
    				model:{
    					id: "menu_seq",
    					hasChildren: "hasChildren"
    				}
    			},
            },
            dataTextField: "menu_name",
            change: function(e) {
				var item = this.dataItem(this.select());
            	G_SEQ = item.menu_seq;
            	viewModel.dataSource.read();
	            this.dataSource.data()[0].set("menu_url", "");
            	if(item.menu_seq == 0) {
					viewModel.readyEdit(false);
					viewModel.set("isEnabledAdd", true);
            	} else {
					viewModel.readyEdit(true);
            	}
				viewModel.toggleMenuType(item.menu_type);
            }
        });
        
        model = kendo.data.Model.define({
			id: "menu_seq",
			fields: {
				menu_seq			:{ type: "number" },
				parent_seq			:{ type: "number" },
				parent_name			:{ type: "string" },
				menu_id				:{ type: "string", validation: { required: true } },
				menu_name			:{ type: "string", validation: { required: true } },
				menu_type			:{ type: "string", validation: { required: true } },
				menu_url			:{ type: "string", validation: { required: true } },
				menu_icon			:{ type: "string" },
				menu_order			:{ type: "number", defaultValue: 1 },
				use_yn				:{ type: "boolean" },
				bbs_uid				:{ type: "string" }
			}	
		});
		
	    /*** dataSource ***/
		viewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: {
						url: crudServiceBaseUrl + "/read.do",
		    			dataType: "jsonp",
		    			complete: function(e){ 
		    				console.log("viewModel:dataSource:read:complete");
		    			}
					},
					update: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destroy: { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
					create: { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
		                   	var result = {
								menu_seq: G_SEQ
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
					model: model,
					data: function(response) {
						console.log("viewModel:dataSource:data");
						console.log(response.rtnList);
						return response.rtnList;
					},
					total: function(response) {
						console.log("viewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("viewModel:dataSource:error: " + response.error);
						return response.error;
					}
				},
		        error : function(e) {
			    	console.log('viewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("viewModel:dataSource:change: set selected :");
		            var _data = this.data()[0];
					viewModel.set("selected", _data);
	            	
					if(typeof viewModel.selected != "undefined") {
// 						viewModel.toggleMenuType(this.data()[0].get("menu_type"));
					}
		        },
		        requestEnd: function(e) {
		        	console.log("viewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && e.response.error == null) {
		        		alert("정상적으로 처리되었습니다.");
		        		$("#treeview").data("kendoTreeView").dataSource.read();
		        		if(e.type == 'destroy') {
		        			viewModel.readyEdit(false);
		        		}
		        	} else if(e.type != 'read') {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("viewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("viewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("viewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("viewModel:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            add: function (e) {
				console.log("viewModel:add");
				var tree = $("#treeview").data("kendoTreeView");
				var item = tree.dataItem(tree.select());
				
				if(item.addChildren) {
					this.set("selected", new model());
			  		this.dataSource.insert(0, this.selected);
			  		
			 		// init default value
			 		this.dataSource.data()[0].set("parent_seq", item.menu_seq);
			 		this.dataSource.data()[0].set("parent_name", item.menu_name);
			 		$("#menu-type").data("kendoDropDownList").select(0); // default url
			 		
					this.readyEdit(true);
			 		this.set("isEnabledRemove", false);
				} else {
					alert("더 이상 추가할 수 없습니다.\n최대 3 Level 까지만 추가할 수 있습니다.");
				}
            },
            save: function (e) {
				console.log("viewModel:save");
				if($("#menu-form").kendoValidator().data("kendoValidator").validate()) {
	                if (confirm("저장하시겠습니까?")) {
						console.log(this.dataSource.data()[0]);
						this.dataSource.sync();
	                }
				}
            },
            remove: function(e) {
            	console.log("viewModel:remove");
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
            	console.log("viewModel:cancel");
                this.dataSource.cancelChanges();
            },
            menuTypeDataSource: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/common/getCodename.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
	                       	var result = {
								CATGR: "_MENU_TYPE_" 
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
            onChangeMenuType: function() {
            	console.log("onChangeMenuType");
            	this.toggleMenuType(this.dataSource.data()[0].get("menu_type"));
	            this.dataSource.data()[0].set("menu_url", "");
            },
            toggleMenuType: function(type) {
            	if(type == "100468002") { // 100468002 = bbs 
	            	$("#menu-type-bbs").css({ "display" : "table-row" });
	            	$("#menu-type-inner").css({ "display" : "none" });
	            	$("#bbs-uid").data("kendoDropDownList").select(0);
            	} else if(type == "100468001") { // 100468001 = inner-page 
            		$("#menu-type-inner").css({ "display" : "table-row" });
	            	$("#menu-type-bbs").css({ "display" : "none" });
	            	$("#inner-page").data("kendoDropDownList").select(0);
            	} else {
	            	$("#menu-type-inner").css({ "display" : "none" });
	            	$("#menu-type-bbs").css({ "display" : "none" });
            	}
            },
            bbsDataSource: new kendo.data.DataSource({
            	transport: {
					read : { 
// 						url: "${contextPath}/sm/bbs/readNotUse.do",
						url: "${contextPath}/common/getTableDataList.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {
						if (type == "read"){
	                       	var result = {
	                       		TABLE: "sys_bbs_info",
								TEXT: "bbs_name",
								VALUE: "bbs_uid"
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
				}
            }),
            onChangeBBS: function() {
            	console.log("onChangeBBS");
            	this.dataSource.data()[0].set("menu_url", "/bbs/board.do?bbs=" + this.dataSource.data()[0].get("bbs_uid"));
            },
            innerPageDS: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/sm/menu/getInnerPageList.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {
						if (type == "read"){
	                       	var result = { };
							return { params: kendo.stringify(result) }; 
						}
					}
				},
				schema: {
					data: function(response) {
						return response;
					},
					model:{
						id: "url",
						fields: { 
							url		: { type: "string" },
							name	: { type: "string" }
						}  
					}
				}
            }),
            iconDataSource: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/common/getCodename.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
	                       	var result = {
								CATGR: "_ICON_" // 100472=_ICON_
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
				}
			}),
			isReadonly: false,
            isEditable: false,
            isEditableUrl: false,
            isEnabledAdd: false,
            isEnabledRemove: false,
            isEnabledSave: false,
			readyEdit: function(isReady) {
				this.set("isEditable", isReady)
				this.set("isEnabledAdd", isReady);
        		this.set("isEnabledRemove", isReady);
        		this.set("isEnabledSave", isReady);
			}
		});
	    
	    // binding data to right-pane
		kendo.bind($("#right-pane"), viewModel);
	});	
</script>	

<style>
	#treeview .k-sprite {
		background-image: url("../resource/images/coloricons-sprite.png");
	}

	.rootfolder { background-position: 0 0; }
	.folder { background-position: 0 -16px; }
	.pdf { background-position: 0 -32px; }
	.html { background-position: 0 -48px; }
	.image { background-position: 0 -64px; }
</style>
<%@ include file="../inc/footer.jsp"%>
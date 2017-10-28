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
				<div id="vertical" style="height:715px;">
					<div id="top-pane">
						<div id="horizontal" style="height: 100%; width: 100%;">
							<div id="left-pane">
								<div class="pane-content">
									<h3>번호인식기</h3>
									<p><div id="grid-lpr"></div>
								</div>
							</div>
							<div id="right-pane">
								<div class="panel-tile">
									<div>
										<div class="col-md-12" style="float: right;">
											<button class="btn btn-primary btn-sm btn-auth-u" 
													data-role="button" 
													data-bind="click: remove, enabled: isEnabledDelete"
													style="float:right;margin:10px 10px 0 0;">
													<spring:message code="button.delete" text="delete" /></button>
											<button class="btn btn-primary btn-sm btn-auth-d" 
													data-role="button" 
													data-bind="click: save, enabled: isEnabledSave"
													style="float:right;margin:10px 10px 0 0;">
													<spring:message code="button.save" text="save" /></button>
											<button class="btn btn-primary btn-sm btn-auth-c" 
													data-role="button" 
													data-bind="click: add, enabled: isEnabledAdd"
													style="float:right;margin:10px 10px 0 0;">
													<spring:message code="button.add" text="add" /></button>
										</div>
									</div>
									<div>
										<form id="lpr-form">
											<table style="width:90%;">
												<colgroup>
													<col width="30%">
													<col width="70%">
												</colgroup>
												<tbody>
													<tr>
														<th><label class="col-lg-12 control-label">seq</label></th>
														<td>
															<input data-role="maskedtextbox"
																	data-bind="value:selected.lpr_seq,
																				enabled: isFalse"
																	style="width:100%;background:#EEE;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">인식기모델번호</label></th>
														<td>
															<input data-role="maskedtextbox" 
																	data-bind="value:selected.model, enabled: isEditable" 
																	required validationMessage="인식기모델번호를 입력하세요." 
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">설치구분/위치</label></th>
														<td>
															<div>
																<input id="loc-type"
																		data-option-label="설치구분을 선택하세요."
																		data-role="dropdownlist"
																		data-auto-bind="true"
																		data-value-primitive="true"
																		data-text-field="text"
						          										data-value-field="value"
																		data-bind="value:selected.loc_type,
																					source: locTypeDS,
																					enabled: isEditable,
																					events: {
																						change: onChangeLocType
																					}"
																		required validationMessage="설치구분을 선택하세요."/>
																<input data-option-label="설치위치를 선택하세요."
																		data-role="dropdownlist"
																		data-auto-bind="false"
																		data-value-primitive="true"
																		data-text-field="text"
						          										data-value-field="value"
						          										data-filter="startswith"
																		data-bind="value:selected.loc_seq,
																					enabled: isSelectedLocType,
																					source: locSeqDS,
																					events: {
																						change: onChangeLocSeq
																					}"
																		required validationMessage="설치위치를 선택하세요."/>
															</div>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">인식기상태</label></th>
														<td>
															<input data-role="maskedtextbox"
																	data-bind="value:selected.is_alive,
																				enabled: isFalse"
																	style="width:100%;background:#EEE;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">상태메시지</label></th>
														<td>
															<input data-role="maskedtextbox"
																	data-bind="value:selected.status_msg,
																				enabled: isFalse"
																	style="width:100%;background:#EEE;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">최종확인일시</label></th>
														<td>
															<input data-role="datetimepicker"
																	data-format="yyyy-MM-dd HH:mm:ss"
																	data-bind="value:selected.last_alive_dt,
																				enabled: isFalse"
																	style="width:100%;background:#EEE;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">설명</label></th>
														<td>
															<textarea class="k-textbox form-control" style="width:100%;height:100px;"
																		data-bind="value:selected.description, enabled: isEditable"></textarea>
														</td>
													</tr>
<!-- 													<tr> -->
<!-- 													<pre> -->
<!-- { -->
<!-- 	isEditable: <span data-bind="text: isEditable"></span>, -->
<!-- 	isEnabledDelete: <span data-bind="text: isEnabledDelete"></span>, -->
<!-- 	isEnabledSave: <span data-bind="text: isEnabledSave"></span>, -->
<!-- 	isEnabledAdd: <span data-bind="text: isEnabledAdd"></span>, -->
<!-- 	isSelectedLocType: <span data-bind="text: isSelectedLocType"></span>, -->
<!-- 	isTrue: <span data-bind="text: isTrue"></span>, -->
<!-- 	isFalse: <span data-bind="text: isFalse"></span> -->
<!-- 	seq: <span data-bind="text: seq"></span> -->
<!-- } -->
<!--     </pre> -->
<!-- 													</tr> -->
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
	</section>
</section>
<script>
	var lprViewModel;
	
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
				{ collapsible: false, resizable: false, scrollable: false, size: "50%" },
				{ collapsible: false, scrollable: false }
			]
		});
		
		model = kendo.data.Model.define({
			id: "lpr_seq",
			fields: { 
				lpr_seq			: { type: "string", editable: false },
				model			: { type: "string" },
				loc_type		: { type: "string" },
				loc_name		: { type: "string" },
				loc_seq 		: { type: "number" },
				description		: { type: "string" },
				is_alive		: { type: "string" },
				last_alive_dt	: { type: "date" },
				cre_dt			: { type: "date" }
			}
		});
		
		var crudBaseUrl = "${contextPath}/lpr";
		$("#grid-lpr").kendoGrid({
			dataSource:	{
				transport: {
					read : { url: crudBaseUrl + "/list.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							var result = {
								PAGESIZE : data.pageSize,
								SKIP : data.skip,
								PAGE : data.page,
								TAKE : data.take
							};
							return {
								params : kendo.stringify(result)
							}; 
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
					parse: function(response) {
						var list = response.rtnList;
						$.map(list, function (item, index) {                           
							if (typeof(item.last_alive_dt) != "undefined" && item.last_alive_dt != null) {               
						    	item.last_alive_dt = new Date(Number(item.last_alive_dt));
							}
							if (typeof(item.is_alive) != "undefined" && item.is_alive != null) {               
						    	item.is_alive = (item.is_alive) ? '정상' : '에러';
							}
						});
						return response;
					},
					model : model
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
	        error : function(e) {
		    	console.log('grid-lpr:dataSource:error:' + e.errors);
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
			height: 630,
			resizable: true,  //컬럼 크기 조절
			reorderable: true, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			mobile: true,
			columns: [
				{ field: "lpr_seq", title: "seq", width: 80, attributes: {style: "text-align: center;"} },
				{ field: "model", title: "인식기모델번호", width: 150, attributes: {style: "text-align: center;"} },
				{ field: "loc_type", title: "설치구분", width: 80, attributes: {style: "text-align: center;"},
					template: "#=(loc_type == 'L') ? '소독시설' : '농장' #" },
				{ field: "loc_name", title: "설치위치", width: 150, attributes: {style: "text-align: center;"} },
				{ field: "is_alive", title: "인식기상태", width: 100, attributes: {style: "text-align: center;"} }
			],
			editable: false,
			noRecords: false,
			filterable: false,
            change: function(e) {
				console.log("grid-lpr:change");
				var selectedItem = this.dataItem(this.select());
				lprViewModel.readLocSeqDS(selectedItem.loc_type);
				lprViewModel.read(selectedItem.lpr_seq);
            }
		});
		
	    /*** dataSource ***/
		lprViewModel = kendo.observable({
			read: function(seq) {
				this.set("seq", seq);
				this.dataSource.read();
				this.set("isEditable", true);
				this.set("isEnabledDelete", true);
				this.set("isEnabledSave", true);
        		this.set("isSelectedLocType", true);
			},
			seq: 0,
			dataSource: new kendo.data.DataSource({
				transport: {
					read : { url: crudBaseUrl + "/read.do", dataType: "jsonp" },
					update : { url: crudBaseUrl + "/save.do", dataType: "jsonp" },
					create : { url: crudBaseUrl + "/save.do", dataType: "jsonp" },
					destroy : { url: crudBaseUrl + "/delete.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							var result = {
								lpr_seq : lprViewModel.seq
							};
							return {
								params : kendo.stringify(result)
							};  
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
						console.log("lprViewModel:dataSource:data");
						return response.rtnList;
					},
					total: function(response) {
						console.log("lprViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("lprViewModel:dataSource:error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						console.log("lprViewModel:dataSource:parse");
						var list = response.rtnList;
						 
						$.map(list, function (item, index) {                           
							if (typeof(item.last_alive_dt) != "undefined" && item.last_alive_dt != null) {               
					    		item.last_alive_dt = new Date(Number(item.last_alive_dt));
							}
							if (typeof(item.is_alive) != "undefined" && item.is_alive != null) {               
						    	item.is_alive = (item.is_alive) ? '정상' : '에러';
							}
						});
						return response;
					}
				},
		        error : function(e) {
			    	console.log('lprViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("lprViewModel:dataSource:change:");
					var _data = this.data()[0];
					lprViewModel.set("selected", _data);
		        },
		        requestEnd: function(e) {
		        	console.log("lprViewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && e.response.error == null) {
		        		alert("정상적으로 처리되었습니다.");
		        		$("#grid-lpr").data("kendoGrid").dataSource.read();
		        	} else if(e.type != 'read') {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("lprViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("lprViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("lprViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("lprViewModel:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            isFalse: false,
            isTrue: true,
            isEditable: false,
            isSelectedLocType: false,
            isEnabledDelete: false,
            isEnabledSave: false,
            isEnabledAdd: true,
            save: function (e) {
				console.log("lprViewModel:save");
				if($("#lpr-form").kendoValidator().data("kendoValidator").validate()) {
	                if (confirm("저장하시겠습니까?")) {
						console.log(this.dataSource.data()[0]);
						this.dataSource.sync();
	                }
				}
            },
            remove: function(e) {
            	console.log("lprViewModel:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
                }
            },
            add: function(e) {
            	console.log("lprViewModel:add");
                this.dataSource.cancelChanges();
		  		this.dataSource.insert(0, new model());
		  		this.set("isEditable", true);
		  		this.set("isEnabledDelete", false);
		  		this.set("isEnabledSave", true);
        		this.set("isSelectedLocType", false);
        		this.dataSource.data()[0].set("last_alive_dt", null);
        		this.dataSource.data()[0].set("is_alive", '대기');
            },
            locType: "",
            locTypeDS: [
            	{ text: "농장", value: "F" },
            	{ text: "소독시설", value: "L" }
            ],
            onChangeLocType: function() {
            	console.log("onChangeLocType");
            	if(this.selected != null) {
	            	if(this.selected.loc_type == null || this.selected.loc_type == "") {
	            		this.set("isSelectedLocType", false);
	            	} else {
	            		this.set("isSelectedLocType", true);
	            		this.set("locType", this.selected.loc_type);
		            	this.locSeqDS.read();
	            	}
            	} else {
            		console.log("selected is null");
            	}
            },
            readLocSeqDS: function(type) {
				this.set("locType", type);
        		this.locSeqDS.read();
            },
            locSeqDS: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: crudBaseUrl + "/getLocList.do", dataType: "jsonp"
					},
					parameterMap: function(data, type) {
						if (type == "read"){
							console.log(lprViewModel.locType);
							return { loc_type : lprViewModel.locType }; 
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
            onChangeLocSeq: function() {
            	console.log("onChangeLocSeq");
            }
		});
	    
	    // binding data to right-pane
		kendo.bind($("#right-pane"), lprViewModel);

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
<%@ include file="../../inc/footer.jsp"%>
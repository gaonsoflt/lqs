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
									<h3>차량</h3>
									<p><div id="grid-car"></div>
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
										<form id="car-form">
											<table style="width:90%;">
												<colgroup>
													<col width="30%">
													<col width="70%">
												</colgroup>
												<tbody>
													<tr>
														<th><label class="col-lg-12 control-label">차량번호</label></th>
														<td>
															<input data-role="maskedtextbox" 
																	data-bind="value:selected.car_no, 
																				enabled: isReadonly"
																	required validationMessage="차량번호를 입력하세요." 
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">소유자</label></th>
														<td>
															<input data-role="maskedtextbox" 
																	data-bind="value:selected.owner, enabled: isEditable" 
																	required validationMessage="소유자를 입력하세요." 
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">소유자형태</label></th>
														<td>
															<input id="biz_type" data-option-label="소유자형태를 선택하세요."
																	data-role="dropdownlist"
																	data-auto-bind="true"
																	data-value-primitive="true"
																	data-text-field="text"
					          										data-value-field="value"
																	data-bind="value:selected.biz_type,
																				enabled: isEditable,
																				source: bizTypeDS,
																				events: {
																					change: onChangeBizType
																				}"
																	required validationMessage="소유자형태를 선택하세요."
																	style="width:100%;display:none;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">차량종류</label></th>
														<td>
															<input data-option-label="차량종류를 선택하세요."
																	data-role="dropdownlist"
																	data-auto-bind="true"
																	data-value-primitive="true"
																	data-text-field="text"
					          										data-value-field="value"
																	data-bind="value:selected.type,
																				source: carTypeDS,
																				enabled: isEditable"
																	required validationMessage="차량종류를 선택하세요."
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">모델</label></th>
														<td>
															<input data-role="maskedtextbox"
																	data-bind="value:selected.model,
																				enabled: isEditable"
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">제조사</label></th>
														<td>
															<input data-option-label="제조사를 선택하세요."
																	data-role="dropdownlist"
																	data-auto-bind="true"
																	data-value-primitive="true"
																	data-text-field="text"
					          										data-value-field="value"
																	data-bind="value:selected.maker,
																				source: makerDS,
																				enabled: isEditable"
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">연식</label></th>
														<td>
															<input data-role="maskedtextbox"
																	data-mask="0000-00"
																	data-bind="value:selected.since_year,
																				enabled: isEditable"
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">유종</label></th>
														<td>
															<input data-option-label="유종을 선택하세요."
																	data-role="dropdownlist"
																	data-auto-bind="true"
																	data-value-primitive="true"
																	data-text-field="text"
					          										data-value-field="value"
																	data-bind="value:selected.fuel_type,
																				source: fuelTypeDS,
																				enabled: isEditable"
																	style="width:100%;"/>
														</td>
													</tr>
													<tr>
														<th><label class="col-lg-12 control-label">설명</label></th>
														<td>
															<textarea class="k-textbox form-control" style="width:100%;height:100px;"
																		data-bind="value:selected.description, enabled: isEditable"></textarea>
														</td>
													</tr>
													<tr data-bind="visible: isVisibleCreDt">
														<th><label class="col-lg-12 control-label">등록일</label></th>
														<td>
															<input data-role="maskedtextbox"
																	data-mask="0000"
																	data-bind="value:selected.cre_dt,
																				enabled: isFalse"
																	style="width:100%;background:#EEE;"/>
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
			</div>
		</div>
	</section>
</section>
<script>
	var carViewModel;
	var fuelTypeModel = [
    	{ text: "휘발유", value: "G" },
    	{ text: "경유", value: "D" },
    	{ text: "가스", value: "L" },
    	{ text: "전기", value: "E" }
    ];
	
	function getFuelTypeText(value) {
		var i;
		for(i = 0; i < fuelTypeModel.length; i++) {
			if(fuelTypeModel[i].value == value) {
				return fuelTypeModel[i].text;
			}
		}
	};
	
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
			id : "car_no",
			fields : {
				car_no 		: { type: "string", validation: { required: true } },
				owner 		: { type: "string", validation: { required: true } },
				type		: { type: "string", validation: { required: true } },
				type_name	: { type: "string" },
				model 		: { type: "string" },
				maker 		: { type: "string" },
				since_year 	: { type: "string" },
				fuel_type 	: { type: "string" },
				company 	: { type: "string" },
				biz_type	: { type: "string", validation: { required: true } },
				description : { type: "string" },
				cre_dt 		: { type: "string" },
				cre_usr 	: { type: "string" }
			}
		});
		
		var crudBaseUrl = "${contextPath}/car";
		$("#grid-car").kendoGrid({
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
							return { params : kendo.stringify(result) }; 
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
		    	console.log('grid-car:dataSource:error:' + e.errors);
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
				{ field : "type_name", title : "차량타입", attributes : { style : "text-align: center;" } },
				{ field : "car_no", title : "차량번호", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "owner", title : "소유자", width : 150, attributes : { style : "text-align: center;" } },
				{ field : "fuel_type", title : "유종", width : 100, attributes : { style : "text-align: center;" },
	 				template: "#=getFuelTypeText(fuel_type)#" 
				},
				{ field : "cre_dt", title : "등록일", width : 150, attributes : {	style : "text-align: center;" } }
			],
			editable: false,
			noRecords: false,
			filterable: false,
            change: function(e) {
				console.log("grid-car:change");
				var selectedItem = this.dataItem(this.select());
				carViewModel.read(selectedItem.car_no);
            }
		});
		
	    /*** dataSource ***/
		carViewModel = kendo.observable({
			read: function(no) {
				this.set("no", no);
				this.dataSource.read();
				this.set("isEditable", true);
				this.set("isEnabledDelete", true);
				this.set("isEnabledSave", true);
				this.set("isReadonly", false);
				this.set("isVisibleCreDt", true);
			},
			no: "",
			dataSource: new kendo.data.DataSource({
				transport: {
					read : { url: crudBaseUrl + "/read.do", dataType: "jsonp" },
					update : { url: crudBaseUrl + "/save.do", dataType: "jsonp" },
					create : { url: crudBaseUrl + "/save.do", dataType: "jsonp" },
					destroy : { url: crudBaseUrl + "/delete.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							var result = {
								car_no : carViewModel.no
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
						console.log("carViewModel:dataSource:data");
						return response.rtnList;
					},
					total: function(response) {
						console.log("carViewModel:dataSource:total: " + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("carViewModel:dataSource:error: " + response.error);
						return response.error;
					},
					parse: function(response) {
						console.log("carViewModel:dataSource:parse");
						return response;
					}
				},
		        error : function(e) {
			    	console.log('carViewModel:dataSource:error: ');
			    	console.log(e)
		        },
		        change : function(e) {
		        	console.log("carViewModel:dataSource:change:");
					var _data = this.data()[0];
					carViewModel.set("selected", _data);
		        },
		        requestEnd: function(e) {
		        	console.log("carViewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && e.response.error == null) {
		        		alert("정상적으로 처리되었습니다.");
		        		$("#grid-car").data("kendoGrid").dataSource.read();
		        	} else if(e.type != 'read') {
		        		alert("에러가 발생했습니다." + "\n" + e.response.error);
		        	}
		        },
		        sync: function(e) { 
		        	console.log("carViewModel:dataSource:sync");
				},
				dataBound: function(e){ 
					console.log("carViewModel:dataSource:dataBound");
				}
			}),
			error : function(e) {
            	console.log("carViewModel:error" + e.errors);
            },
            change: function(e) {
            	console.log("carViewModel:change");
            },
            batch: true,
            selected: null,
            hasChanges: false,
            isFalse: false,
            isTrue: true,
            isReadonly: false,
            isEditable: false,
            isEnabledDelete: false,
            isEnabledSave: false,
            isEnabledAdd: true,
            isVisibleCreDt: false,
            save: function (e) {
				console.log("carViewModel:save");
				if($("#car-form").kendoValidator().data("kendoValidator").validate()) {
	                if (confirm("저장하시겠습니까?")) {
						console.log(this.dataSource.data()[0]);
						this.dataSource.sync();
	                }
				}
            },
            remove: function(e) {
            	console.log("carViewModel:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
                }
            },
            add: function(e) {
            	console.log("carViewModel:add");
                this.dataSource.cancelChanges();
		  		this.dataSource.insert(0, new model());
		  		this.set("isEditable", true);
		  		this.set("isEnabledDelete", false);
		  		this.set("isEnabledSave", true);
		  		this.set("isReadonly", true);
		  		this.set("isVisibleCreDt", false);
            },
            bizTypeDS: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/common/getCodename.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {
						if (type == "read"){
	                       	var result = {
								CATGR: "_BIZ_TYPE_" 
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
            onChangeBizType: function() {
            	console.log("onChangeBizType");
            },
            fuelTypeDS: fuelTypeModel,
            carTypeDS: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/common/getCodename.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {
						if (type == "read"){
	                       	var result = {
								CATGR: "_CAR_TYPE_" 
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
            makerDS: [
            	{ text: "기아", value: "기아" },
            	{ text: "현대", value: "현대" },
            	{ text: "르노삼성", value: "르노삼성" },
            	{ text: "GM", value: "한국지엠" },
            	{ text: "벤츠", value: "벤츠" },
            	{ text: "BMW", value: "BMW" },
            	{ text: "폭스바겐", value: "폭스바겐" },
            	{ text: "아우디", value: "아우디" },
            	{ text: "쌍용", value: "쌍용" },
            	{ text: "혼다", value: "혼다" },
            	{ text: "토요타", value: "토요타" },
            	{ text: "닛산", value: "닛산" },
            	{ text: "스바루", value: "스바루" },
            	{ text: "스즈키", value: "스즈키" },
            	{ text: "포드", value: "포드" },
            	{ text: "테슬라", value: "테슬라" },
            	{ text: "볼보", value: "볼보" },
            	{ text: "기타", value: "기타" }
            ]
		});
	    
	    // binding data to right-pane
		kendo.bind($("#right-pane"), carViewModel);

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
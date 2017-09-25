<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../inc/header.jsp"%>
<%@ include file="../../inc/aside.jsp"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


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
		<div id="panel">
			<div class="row">
				<div class="col-md-12">
					<div class="br-a br-grey panel panel-tile">
						<div class="panel-body">
							<div class="row">
								<div class="col-md-12">
									<div>
										<button class="btn btn-primary btn-sm btn-auth-d" style="float:right;margin:10px 10px 0 0;"
											data-role="button"
											data-bind="click: remove,
														visible: isVisibleDeleteBtn">
											<spring:message code="button.delete" text="delete" />
										</button>
										<button class="btn btn-primary btn-sm btn-auth-c" style="float:right;margin:10px 10px 0 0;"
												data-role="button"
												data-bind="click: save">
											<spring:message code="button.save" text="save" />
										</button>
										<button class="btn btn-primary btn-sm" style="float:right;margin:10px 10px 0 0;"
												data-role="button"
												data-bind="click: list">
											<spring:message code="button.list" text="list" />
										</button>
									</div>
								</div>
							</div>
							<div class="row">
								<table style="width:90%;">
									<colgroup>
										<col width="15%">
										<col width="35%">
										<col width="15%">
										<col width="35%">
									</colgroup>
									<tbody>
										<tr>
											<th>
												<label class="col-lg-12 control-label">농장(App)아이디</label>
											</th>
											<td>
												<input name="seq" class="form-control" style="background:#EEE;"
														data-role="maskedtextbox" 
														data-bind="value:selected.farm_seq,
																	enabled: isReadonly" />
											</td>
											<th>
												<label class="col-lg-12 control-label">App패스워드</label>
											</th>
											<td>
												<div>
													<div class="col-md-6" style="padding:0;">
														<input type="password" name="password" id="password" 
																class="form-control"
																data-role="maskedtextbox" 
																data-bind="value:selected.password"
																placeholder="<spring:message code="signup.password" text="default text" />" 
																required/>
													</div> 
													<div class="col-md-6" style="padding:0;">
														<input type="password" name="confirmPassword" id="confirmPassword" 
																class="form-control" 
																data-role="maskedtextbox"
																placeholder="<spring:message code="signup.confirmPassword" text="default text" />" 
																required/>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<th>
												<label class="col-lg-12 control-label">농장명</label>
											</th>
											<td>
												<input id="farm_name" class="form-control"
														data-role="maskedtextbox" 
														data-bind="value:selected.farm_name" 
														placeholder="농장명을 입력하세요." 
														required validationMessage="농장명을 입력하세요."/>
											</td>
											<th>
												<label class="col-lg-12 control-label">사업자종류</label>
											</th>
											<td>
												<input id="biz_type" data-option-label="사업자종류를 선택하세요."
														data-role="dropdownlist"
														data-auto-bind="true"
														data-value-primitive="true"
														data-text-field="text"
		          										data-value-field="value"
														data-bind="value:selected.biz_type,
																	source: bizTypeDS,
																	events: {
																		change: onChangeBizType
																	}"
														required validationMessage="사업자종류를 선택하세요."
														style="width:100%;display:none;"/>
											</td>
										</tr>
										<tr>
											<th>
												<label class="col-lg-12 control-label">농장주</label>
											</th>
											<td>
												<input id="owner" class="form-control"
														data-role="maskedtextbox" 
														data-bind="value:selected.owner"
														placeholder="농장주 이름을 입력하세요." 
														required validationMessage="농장주를 입력하세요."/>
											</td>
											<th>
												<label class="col-lg-12 control-label">사업자등록번호</label>
											</th>
											<td>
												<input class="form-control"
														data-role="maskedtextbox" 
														data-mask="000-00-00000"
														data-bind="value:selected.reg_number"
														placeholder="농장등록번호 및 사업자등록번호를 입력하세요." />
											</td>
										</tr>
										<tr>
											<th rowspan="2">
												<label class="col-lg-12 control-label">사업장주소</label>
											</th>
											<td>
												<span>
													<input class="col-lg-3 form-control" style="width:100px;background:#EEE;"
															data-role="maskedtextbox" 
															data-bind="value:selected.zonecode,
																		enabled: isEnabledAddress"
															required validationMessage="우편번호를 입력하세요."/>
													<button data-role="button"
															data-bind="click: onClickZonecode">우편번호 찾기</button>
												</span>
											</td>
											<th>
												<label class="col-lg-12 control-label">연락처</label>
											</th>
											<td>
												<input class="form-control"
														data-role="maskedtextbox" 
														data-mask="000-0000-0000"
														data-bind="value:selected.phone" 
														placeholder="연락처를 입력하세요." 
														required validationMessage="연락처를 입력하세요."/>
											</td>
										</tr>
										<tr>
											<td>
												<input class="form-control" style="background:#EEE;"
														data-role="maskedtextbox" 
														data-bind="value:selected.road_address,
																	enabled: isEnabledAddress"
														required validationMessage="주소를 입력하세요."/>
											</td>
											<td colspan="2">
												<input id="detail-address" class="form-control"
														data-role="maskedtextbox" 
														data-bind="value:selected.detail_address"
														placeholder="상세주소를 입력하세요."/>
											</td>
										</tr>
										<tr>
											<th>
												<label class="col-lg-12 control-label">운영여부</label>
											</th>
											<td>
												<label>
													<input name="run-yn" type="radio" value="true" data-bind="checked: selected.run_yn" />
												    <span>운영</span>
												</label>
												<label>
													<input name="run-yn" type="radio" value="false" data-bind="checked: selected.run_yn" />
												    <span>미운영</span>
												</label>
											</td>
										</tr>
										<tr>
											<th>
												<label class="col-lg-12 control-label">비고</label>
											</th>
											<td colspan="3">
												<textarea class="k-textbox form-control" style="width:100%;height:100px;"
														data-bind="value:selected.description"></textarea>
											</td>
										</tr>										
										<tr>
											<th>
												<label class="col-lg-12 control-label">사육가축</label>
											</th>
											<td>
												<div style="height:30px;">
													<div class="col-md-6" style="padding:0;">
														<input id="ls_type" data-option-label="가축종류를 선택하세요."
																data-role="dropdownlist"
																data-auto-bind="true"
																data-value-primitive="true"
																data-text-field="text"
				          										data-value-field="value"
																data-bind="	value: lsType,
																			source: lsTypeDS,
																			events: {
																				change: onChangeLsType
																			}"
																style="width:100%;display:none;"/>
													</div> 
													<div class="col-md-4" style="padding:0;">
														<input data-role="numerictextbox" 
																data-min="0" 
																data-max="999999999",
																data-format="n0",
																data-bind="value: inputLsCount"/> 
													</div>
													<div class="col-md-2" style="padding:0;">
														<button data-role="button" 
																data-bind="click: addLivestock">추가</button>
													</div>
												</div>
												<div>
													<div id="grid-livestock"></div>
												</div>
											</td>
										</tr>
										<c:if test="${farm_seq > 0}">
											<tr>
												<th>
													<label class="col-lg-12 control-label">등록일자</label>
												</th>
												<td>
													<input class="form-control" style="background:#EEE;"
														data-role="maskedtextbox" 
														data-bind="value:selected.cre_dt,
																	enabled: isReadonly" />
												</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>


<script type="text/javascript">
	var viewModel;
	$(document).ready(function() {
		$("input[type=password]").change(function() {
			if($("#confirmPassword").val() != '') {
				if($("#password").val() == $("#confirmPassword").val()) {
					document.getElementById("confirmPassword").parentElement.parentElement.parentElement.className = "form-group has-success";
				} else {
					document.getElementById("confirmPassword").parentElement.parentElement.parentElement.className = "form-group has-error";
				}
			}
			return true;
		});
		
		model = kendo.data.Model.define({
			id : "farm_seq",
			fields : {
				farm_seq 		: { type: "string", editable: false },
				biz_type 		: { type: "string", validation: { required: true } },
				reg_number 		: { type: "string", validation: { required: true } },
				password 		: { type: "string" },
				farm_name 		: { type: "string", validation: { required: true } },
				owner 			: { type: "string", validation: { required: true } },
				phone 			: { type: "string" },
				description 	: { type: "string" },
				run_yn			: { type: "boolean" },
				cre_dt 			: { type: "string", editable: true },
				address_seq 	: { type: "number", editable: false },
				zonecode 		: { type: "string" },
				jibun_address 	: { type: "string" },
				road_address 	: { type: "string" },
				detail_address 	: { type: "string" },
				sido 			: { type: "string" },
				sigungu 		: { type: "string" },
				sigungu_code 	: { type: "string" },
				roadname_code 	: { type: "string" },
				roadname 		: { type: "string" },
				building_code 	: { type: "string" },
				building_name 	: { type: "string" },
				bcode 			: { type: "string" },
				bname 			: { type: "string" },
				bname1 			: { type: "string" },
				livestocks		: { type: "object" }
			}
		});
		
		livestockModel = kendo.data.Model.define({
			id: "ls_type",
			fields : {
				farm_seq 		: { type: "string", editable: false, validation: { required: true } },
				ls_type 		: { type: "string", editable: false, validation: { required: true } },
				ls_name 		: { type: "string", editable: false, validation: { required: true } },
				ls_count 		: { type: "number", editable: false, validation: { required: true } }
			}
		});
		
		var crudServiceBaseUrl = "${contextPath}/farm";
	    /*** dataSource ***/
		viewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: { url: crudServiceBaseUrl + "/read.do", dataType: "jsonp" },
					update: { url: crudServiceBaseUrl + "/update.do", dataType: "jsonp" },
					destroy: { url: crudServiceBaseUrl + "/delete.do", dataType: "jsonp" },
					create: { url: crudServiceBaseUrl + "/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							var result = {
								farm_seq: "${farm_seq}"
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
// 						console.log(response.rtnList);
						return response.rtnList;
					},
					total: function(response) {
						console.log("viewModel:dataSource:total:" + response.total);
						return response.total;
					},
					errors: function(response) {
						console.log("viewModel:dataSource:error: " + response.error);
						return response.error;
					}
				},
		        error : function(e) {
			    	console.log('viewModel:dataSource:error: ');
		        },
		        change : function(e) {
		        	console.log("viewModel:dataSource:change");
		        	if(e.action != "remove") {
			        	if(this.data().length > 0) {
			        		viewModel.set("selected", this.data()[0]);
// 			        		viewModel.set("livestockDS", this.data()[0].livestocks);
			        	} else {
							viewModel.set("selected", new model());
					  		viewModel.dataSource.insert(0, this.selected);
			        		viewModel.set("livestockDS", this.data()[0].livestocks);
// 			        		$("#grid-livestock").data("kendoGrid").dataSource.insert(this.data()[0].livestocks);
			        	}
			        	if(viewModel.get("selected").farm_seq == "") {
			        		viewModel.set("isVisibleDeleteBtn", false);
						} else {
			        		viewModel.set("isVisibleDeleteBtn", true);
						}
		        	}
		        },
				requestStart : function(e) {
		        	console.log("viewModel:dataSource:requestStart");
				},
		        requestEnd: function(e) {
		        	console.log("viewModel:dataSource:requestEnd");
		        	if(e.type != 'read' && typeof e.response.error == 'undefined') {
		        		alert("정상적으로 처리되었습니다.");
		        		if(e.type == 'update') {
		        			location.href='${contextPath}/farm/form.do?seq=' + this.data()[0].get("farm_seq");
		        		} else {
		        			location.href='${contextPath}/farm.do';
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
            save: function (e) {
				console.log("viewModel:save");
				var data = this.dataSource.data()[0];
				if(data.get("farm_seq") == '') {
					if(data.get("password") == '' || data.get("password") != document.getElementById('confirmPassword').value) {
						alert('패스워드가 올바르지 않습니다.\n다시 확인해주세요.')
						document.getElementById('password').focus();
						return;
					}
				}
				if(data.get("farm_name") == '') {
					alert('농장명을 입력하세요.')
					document.getElementById('farm_name').focus();
					return;
				}
				if(data.get("biz_type") == '') {
					alert('사업자종류를 선택하세요.')
					document.getElementById('farm_name').focus();
					return;
				}
				if(data.get("owner") == '') {
					alert('농장주를 입력하세요.')
					document.getElementById('owner').focus();
					return;
				}
				if(data.get("phone") == '') {
					alert('연락처를 입력하세요.')
					document.getElementById('phone').focus();
					return;
				}
				if(data.get("zonecode") == '') {
					alert('주소를 입력하세요.')
					return;
				}
				
                if (confirm("저장하시겠습니까?")) {
                	this.dataSource.data()[0].set("livestocks", $("#grid-livestock").data("kendoGrid").dataSource.data());
					console.log(this.dataSource.data()[0]);
					this.dataSource.sync();
                }
            },
            remove: function(e) {
            	console.log("viewModel:remove");
                if (confirm("삭제하시겠습니까?")) {
                	console.log("remove");
                    this.dataSource.remove(this.dataSource.data()[0]);
                    this.dataSource.sync();
                }
            },
            list: function(e) {
        		location.href='${contextPath}/farm.do';	
            },
            onClickZonecode: function() {
            	console.log("viewModel:onClickZonecode");
            	var width = 500;
            	var height = 600;
            	new daum.Postcode({
            		width: width,
            		height: height,
            	    oncomplete: function(data) {
            	        console.log(data);
            	        viewModel.dataSource.data()[0].set("zonecode", data.zonecode);
            	        viewModel.dataSource.data()[0].set("road_address", data.roadAddress);
            	        viewModel.dataSource.data()[0].set("jibun_address", data.jibunAddress);
            	        viewModel.dataSource.data()[0].set("sido", data.sido);
            	        viewModel.dataSource.data()[0].set("sigungu", data.sigungu);
            	        viewModel.dataSource.data()[0].set("sigungu_code", data.sigunguCode);
            	        viewModel.dataSource.data()[0].set("roadname", data.roadname);
            	        viewModel.dataSource.data()[0].set("roadname_code", data.roadnameCode);
            	        viewModel.dataSource.data()[0].set("building_code", data.buildingCode);
            	        viewModel.dataSource.data()[0].set("building_name", data.buildingName);
            	        viewModel.dataSource.data()[0].set("bcode", data.bcode);
            	        viewModel.dataSource.data()[0].set("bname", data.bname);
            	        viewModel.dataSource.data()[0].set("bname1", data.bname1);
            	        document.getElementById('detail-address').focus();
            	    }
            	}).open({
//             		q: "나래관",
            		popupName: 'zonecodePopup'
//             		left: (window.screen.width / 2) - (width / 2),
//             	    top: (window.screen.height / 2) - (height / 2),
//             	    autoClose: true
            	});
            },
            bizTypeDS: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/common/getCodename.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
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
            lsType: null,
            lsTypeDS: new kendo.data.DataSource({
            	transport: {
					read : { 
						url: "${contextPath}/common/getCodename.do",
						dataType: "jsonp"
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
	                       	var result = {
								CATGR: "_LIVESTOCK_TYPE_" 
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
            onChangeLsType: function(e) {
            	console.log("onChangeLsType");
            },
            addLivestock: function() {
            	console.log("addLivestock");
            	var gridDS = $("#grid-livestock").data("kendoGrid").dataSource;
            	var i;
            	lsModel = new livestockModel();
            	for(i = 0; i < this.lsTypeDS.data().length; i++) {
					if(this.lsTypeDS.data()[i].value == this.lsType) {
		            	lsModel.ls_name = this.lsTypeDS.data()[i].text;
					}            		
            	}
            	
            	for(i = 0; i < gridDS.data().length; i++) {
            		if(gridDS.data()[i].ls_type == this.lsType) {
            			alert("가축(" + lsModel.ls_name + ")이 이미 존재합니다.");
            			return;
            		}
            	}
            	if(this.lsType == null) {
            		return;
            	}
            	lsModel.ls_type = this.lsType;
            	lsModel.ls_count = this.inputLsCount;
            	
            	$("#grid-livestock").data("kendoGrid").dataSource.insert(0, lsModel);
            },
            removeLivestock: function() {
            	console.log("removeLivestock");
            },
            inputLsCount: 0,
            isReadonly: false,
            isEnabledAddress: false,
            isVisibleDeleteBtn: true,
            livestockDS: null
		});
	    
	    // binding data to right-pane
		kendo.bind($("#panel"), viewModel);
		viewModel.dataSource.read();
		
		$("#grid-livestock").kendoGrid({
			dataSource: {
				transport: {
					read:  { 
						url: crudServiceBaseUrl + "/livestock/list.do",
						dataType: "jsonp" 
					},
					parameterMap: function(data, type) {//type =  read, create, update, destroy
						if (type == "read"){
							return { params: "${farm_seq}" }; 
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
					model: livestockModel
				},
				error : function(e) {
		        },
		        batch : true
			},
			height: 200,
			resizable: true,  //컬럼 크기 조절
			reorderable: false, //컬럼 위치 이동
			autoBind: true,
			navigatable: true,
			selectable: "row", //selectable: "multiple cell","multiple row","cell","row",
			scrollable: true,
			sortable : true,
			mobile: true,
			pageable : false,
			toolbar: false,
			columns: [
				{ field: "ls_name", title: "가축종류", attributes : { style : "text-align: center;" } },
				{ field: "ls_count", title: "가축수", attributes : { style : "text-align: center;" } },
				{
					attributes : { style : "text-align: center;" },
					command : [ 
					    { name : "destroy", text : "삭제" } 
					],
					width : 100
				}
			],
			editable : {
				mode : "inline",
				confirmation : "삭제하시겠습니까?"
			},			
			noRecords: "",
           	dataBound: function(e) {
	           	console.log("user-grid:dataBound");
			}
		});
	});//document ready javascript end...
</script>

<style>
</style>
<%@ include file="../../inc/footer.jsp"%>
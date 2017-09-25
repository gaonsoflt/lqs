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
												<label class="col-lg-12 control-label">Seq</label>
											</th>
											<td>
												<input name="seq" class="form-control" style="background:#EEE;"
														data-role="maskedtextbox" 
														data-bind="value:selected.facility_seq,
																	enabled: isReadonly" />
											</td>
										</tr>
										<tr>
											<th>
												<label class="col-lg-12 control-label">소독시설명</label>
											</th>
											<td>
												<input id="facility_name" class="form-control"
														data-role="maskedtextbox" 
														data-bind="value:selected.facility_name" 
														placeholder="소독시설명을 입력하세요." 
														required validationMessage="소독시설명을 입력하세요."/>
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
												<label class="col-lg-12 control-label">비고</label>
											</th>
											<td colspan="3">
												<textarea class="k-textbox form-control" style="width:100%;height:100px;"
														data-bind="value:selected.description"></textarea>
											</td>
										</tr>										
										<c:if test="${facility_seq > 0}">
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
		
		model = kendo.data.Model.define({
			id : "facility_seq",
			fields : {
				facility_seq 	: { type: "string", editable: false },
				facility_name 	: { type: "string", validation: { required: true } },
				phone 			: { type: "string" },
				description 	: { type: "string" },
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
		
		var crudBaseUrl = "${contextPath}/facility";
	    /*** dataSource ***/
		viewModel = kendo.observable({
			dataSource: new kendo.data.DataSource({
				transport: {
					read: { url: crudBaseUrl + "/read.do", dataType: "jsonp" },
					update: { url: crudBaseUrl + "/update.do", dataType: "jsonp" },
					destroy: { url: crudBaseUrl + "/delete.do", dataType: "jsonp" },
					create: { url: crudBaseUrl + "/create.do", dataType: "jsonp" },
					parameterMap: function(data, type) {
						if (type == "read"){
							var result = {
								facility_seq : "${facility_seq}"
							};
							return { params: kendo.stringify(result) }; 
						}
						if (type != "read" && data.models) {
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
						console.log("viewModel:dataSource:error: ");
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
			        	} else {
							viewModel.set("selected", new model());
					  		viewModel.dataSource.insert(0, this.selected);
			        	}
			        	if(viewModel.get("selected").facility_seq == "") {
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
		        			location.href = crudBaseUrl + '/form.do?seq=' + this.data()[0].get("facility_seq");
		        		} else {
		        			location.href = crudBaseUrl + '.do';
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
				if(data.get("facility_name") == '') {
					alert('소독시설명을 입력하세요.')
					document.getElementById('facility_name').focus();
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
    			location.href = crudBaseUrl + '.do';
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
            		popupName: 'zonecodePopup'
            	});
            },
            isReadonly: false,
            isEnabledAddress: false,
            isVisibleDeleteBtn: true,
		});
	    
	    // binding data to right-pane
		kendo.bind($("#panel"), viewModel);
		viewModel.dataSource.read();
	});//document ready javascript end...
</script>

<style>
</style>
<%@ include file="../../inc/footer.jsp"%>
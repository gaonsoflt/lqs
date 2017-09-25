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
				<div class="br-a br-grey panel panel-tile">
					<div class="panel-body">
						<form id="form" action="${contextPath}/sm/config/save.do" method="post" enctype="multipart/form-data" onsubmit="return fn_onsubmit(this);">
							<div>
								<button type="submit" class="btn btn-primary btn-sm btn-auth-u" style="float:right;margin:10px 10px 0 0;"><spring:message code="button.save" text="save" /></button>
							</div>
							<table style="width:100%;">
								<colgroup>
									<col width="50%">
									<col width="40%">
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div style="width:100%;">
												<div>
													<label for="title" class="col-lg-12 control-label">프로젝트명</label>
													<div class="col-lg-12">
														<small>사이트(프로젝트)를 대표할 명칭을 입력하세요.</small>
		                                          		<input type="text" id="title" name="title" class="form-control" value="<c:if test='${config.title != null}'>${config.title}</c:if>" required/>
		                                     		</div>
												</div>
												<div>
													<label for="logo" class="col-lg-12 control-label">메인로고</label>
													<div class="col-lg-12">
														<small>로고 이미지(250 x 45px)를 입력하세요.</small><p>
														<img id="logo_img" src="<c:if test='${config.logo != null}'>${contextPath}${config.logo}</c:if>" height="45" width="250" class="br-a"/>
		                                          		<input type="file" id="logo" name="logo" class="form-control"/>
		                                     		</div>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>

<script type="text/javascript">
	
	function fn_onsubmit(e) {
		if(confirm("<spring:message code='msg.save'/>")) {
			return true;
		}
		return false;
	}
	
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#logo_img').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	$(document).ready(function() {
		$("#logo").change(function() {
			readURL(this);
		});
	});//document ready javascript end...
</script>

<%@ include file="../inc/footer.jsp"%>
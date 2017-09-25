function invokeUserAuth(current_menu, type) {
//	console.log('invokeUserAuth: ');
	var auth;
	$.ajax({
	 	type: "get",
	 	url: getContextPath() + "/common/getLoggedUserAuth.do",
	 	data: {
	 		'current_menu': current_menu
	 	},
	 	async: false, //동기 방식
	 	success: function(data, status){
	 		auth = data.auth;
	 	},
	 	fail: function(e){
	 		console.log(e);
	 	},
	 	complete: function(){}
	});
	if(typeof auth != "undefined") {
		switch(type) {
	//		case 'kendoEditor':
	//			if(authMap.AUTH_C == 'false' && authType.toUpperCase() == 'C') {
	//				$(e.data().kendoEditor.body).attr('contenteditable', false);
	//			}
	//			if(authMap.AUTH_U == 'false' && authType.toUpperCase() == 'U') {
	//				$(e.data().kendoEditor.body).attr('contenteditable', false);
	//			}
	//			if(authMap.AUTH_D == 'false' && authType.toUpperCase() == 'D') {
	//				$(e.data().kendoEditor.body).attr('contenteditable', false);
	//			}
	//			break;
			case 'kendoGrid':
//				setTimeout(function() {
					if(!auth.auth_c) {
						$(".k-grid-add").remove();
					}
					if(!auth.auth_u) {
						$(".k-grid-edit").remove();
						$(".k-grid-save-changes").remove();
						$(".k-grid-cancel-changes").remove();
					}
					if(!auth.auth_d) {
						$(".k-grid-delete").remove();
					}
					if(!auth.auth_p) {
						$(".k-grid-excel").remove();
						$(".k-grid-pdf").remove();
					}
//				}, 100);
				break;
			default:
				if(!auth.auth_c) {
					$(".btn-auth-c").remove();
				}
				if(!auth.auth_r) {
					$(".btn-auth-r").remove();
				}
				if(!auth.auth_u) {
					$(".btn-auth-u").remove();
				}
				if(!auth.auth_d) {
					$(".btn-auth-d").remove();
					$(".auth-d").remove();
				}
				if(!auth.auth_p) {
					$(".btn-auth-p").remove();
				}
				break;
		}
	}
}
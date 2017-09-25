function getContextPath(){
    var offset=location.href.indexOf(location.host)+location.host.length;
    var ctxPath=location.href.substring(offset,location.href.indexOf('/',offset+1));
    return ctxPath;
}

function setCurrentMenu(menu_id) {
	$.get(
		getContextPath() + "/session/setCurrentMenu.do", 
		{ current_menu: menu_id }
	);
};

function drawMenu(menu_id) {
	console.log('drawMenu:' + menu_id);
	var menuList;
	$.ajax({
		type: "post",
		url: getContextPath() + "/sm/menu/readMenusByAuth.do",
		async: false, //동기 방식
		success: function(data, status){
			menuList = data.rtnList;
		},
		fail: function(e){
			console.log(e);
		},
		complete: function(){
// 			console.log("get menu");
		}
	});
	
	var oldMainSeq = -1;
	var hasChild = false;
	var temp = "";
	temp += '<li class="sidebar-label pt20">Menu</li>';
	for (i = 0; i < menuList.length; i++) {
		// check changed parentIdx 
		if(oldMainSeq != menuList[i].main_seq) {
			if(oldMainSeq > 0) {
				if(hasChild) {
					temp += '</ul></li>';
				} else {
					temp += '</li>';
				}
			}
			// check has child
			if(menuList[i].menu_seq > 0) {
				hasChild = true;
			} else {
				hasChild = false;
			}
			
			temp += '<li id="' + menuList[i].main_seq + '"';
//			temp += '<li id="' + menuList[i].main_id + '"';
//			if(menu_id == menuList[i].menu_id || menu_id == menuList[i].main_id) {
//				temp += ' class="active"';
//			}
			if(!hasChild) {
//				if(menu_id == menuList[i].menu_seq || menu_id == menuList[i].main_seq) {
//					temp += ' class="active"';
//				}
				temp += 'onclick="setCurrentMenu(this.id)"';	
			}
			temp += '><a ';
			if(hasChild) {
				temp += 'class="accordion-toggle" ';
			}
			temp += 'href="' + getContextPath() + menuList[i].main_url + '">';
			temp += '<span class="' + menuList[i].main_icon + '"></span>';
			temp += '<span class="sidebar-title">' + menuList[i].main_name + '</span></a>';
			
			if(hasChild) {
				temp += '<ul class="nav sub-nav">';
			}
		}
		if(hasChild) {
			temp += '<li id="' + menuList[i].menu_seq + '"';
//			if(menu_id == menuList[i].menu_seq) {
//				temp += ' class="active"';
//			}
//			temp += '<li id="' + menuList[i].menu_id + '"';
//			if(menu_id == menuList[i].menu_id) {
//				temp += ' class="active"';
//			}
			temp += 'onclick="setCurrentMenu(this.id)"><a href="' + getContextPath() + menuList[i].menu_url + '">';
			temp += '<span class="' + menuList[i].menu_icon + '"></span>' + menuList[i].menu_name + '</a></li>';
		}
		// save now main_seq for check changed parentIdx
		oldMainSeq = menuList[i].main_seq;
	}
	if(hasChild) {
		temp += '</ul></li></li>';
	} else {
		temp += '</li></li>';
	}
	var body = document.getElementById("menu-body");
	body.innerHTML = temp;
	
	// active menu
	var eleC = $('#' + menu_id); 
	eleC.addClass("active");
	var eleP = $('#' + menu_id).parent().parent(); 
	if(eleP.is("li")) {
		eleP.addClass("active");
		eleP.children('a').addClass("menu-open");
	}
};
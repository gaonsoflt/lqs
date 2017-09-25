<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<%@ include file="../inc/aside.jsp"%>

		<div class="topbar-left">
			<ol class="breadcrumb">
				<li class="crumb-active">
					<a href="<c:url value='${menu.menu_url}'/>">${menu.menu_nm}</a>
				</li>
				<li class="crumb-link">
					<a href="#">${menu.main_nm}</a>
				</li>
				<li class="crumb-trail">${menu.menu_nm}</li>
			</ol>
		</div>
		<div class="topbar-right">
			<div class="ib topbar-dropdown">
				<label for="topbar-multiple" class="control-label pr10 fs11 text-muted">${menu.menu_desc}</label>
			</div>
		</div>
	</header>
	<!-- Main content -->
	<section id="content" class="table-layout animated fadeIn">
		<div class="row">
			<div class="col-md-12">
				<div id="treelist"></div>
			</div>
		</div>
	</section>
</section>

<script>
$(document).ready(function () {
    var crudServiceBaseUrl = "https://demos.telerik.com/kendo-ui/service";

    var dataSource = new kendo.data.TreeListDataSource({
            transport: {
                read: {
                    url: crudServiceBaseUrl + "/EmployeeDirectory/All",
                    dataType: "jsonp"
                },
                update: {
                    url: crudServiceBaseUrl + "/EmployeeDirectory/Update",
                    dataType: "jsonp"
                },
                destroy: {
                    url: crudServiceBaseUrl + "/EmployeeDirectory/Destroy",
                    dataType: "jsonp"
                },
                create: {
                    url: crudServiceBaseUrl + "/EmployeeDirectory/Create",
                    dataType: "jsonp"
                },
                parameterMap: function(options, operation) {
                    if (operation !== "read" && options.models) {
                        return {models: kendo.stringify(options.models)};
                    }
                }
            },
            batch: true,
            schema: {
                model: {
                    id: "EmployeeId",
                    parentId: "ReportsTo",
                    fields: {
                        EmployeeId: { type: "number", editable: false, nullable: false },
                        ReportsTo: { nullable: true, type: "number" },
                        FirstName: { validation: { required: true } },
                        LastName: { validation: { required: true } },
                        HireDate: { type: "date" },
                        Phone: { type: "string" },
                        HireDate: { type: "date" },
                        BirthDate: { type: "date" },
                        Extension: { type: "number", validation: { min: 0, required: true } },
                        Position: { type: "string" }
                    },
                    expanded: true
                }
            }
        });

    $("#treelist").kendoTreeList({
        dataSource: dataSource,
        toolbar: [ "create" ],
        editable: "popup",
        height: 540,
        columns: [
            { field: "FirstName", expandable: true, title: "First Name", width: 250 },
            { field: "LastName", title: "Last Name" },
            { field: "Position" },
            { field: "Phone", title: "Phone" },
            { field: "Extension", title: "Ext", format: "{0:#}" },
            { command: [ "edit", "destroy" ] }
        ]
    });
});
</script>
<%@ include file="../inc/footer.jsp"%>
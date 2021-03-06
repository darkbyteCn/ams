<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
	<title>项目信息列表</title>
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css" />	
    <link href="${path}/resources/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css"/>
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="${path}/resources/js/config.js" type="text/javascript" ></script>
    <script src="${path}/resources/js/commonFN.js" type="text/javascript"></script>
    <script type="text/javascript">
    
	    var grid = null;
		$(document).ready(function(){
			grid = $("#maingrid").ligerGrid({
				toolbar: { items: [
					{ text: '新增', click: add, icon:'add'},               	
					{ line: true },
					{ text: '刷新', click: refresh, icon:'refresh'},
				]},
				columns: [
				{ display: '项目名称', name: 'projectName', width: "250" },
				{ display: '项目负责人', name: 'projectHead', width: "100" },
				{ display: '操作',width: "140", render: function (rowdata, rowindex, value){
					var h="";
					h += "<a href='${path}/infomanage/project/detail?id="+rowdata.projectId+"' rel='pageTab' data-tabid='dwxx"+rowdata.projectId+"' data-tabTxt='项目详细' data-parentOpen='true' style='color:teal'>详细</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:beginEdit(\"" + rowdata.projectId + "\")' style='color:teal'>编辑</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:itemDel(\""+rowdata.projectId+"\")' style='color:teal' >删除</a> ";
					return h;
				}}],
				usePager:true,
				delayLoad:true,//延迟加载
				root:'rows',
				record:'total',
	            url:"${path}/infomanage/project/list",
				fixedCellHeight: false,
				rownumbers:true,
				clickToEdit:false,
				width: '100%',height:'99%'
			});
			search();
			Public.pageTab();//启用链接打开tab页
		});
		function add(){
			parent.Public.addTab("","新建项目","${path}/infomanage/project/add");
		}
		function refresh(){
			window.location.reload();
		}
		function search(){
			grid.changePage("first");
			var params=$("#searchForm").serialize();
			grid.set("url","${path}/infomanage/project/list?"+params);
			grid.reload();
			return false;
		}
		function beginEdit(projectId) { 
			parent.Public.addTab("dwbj"+projectId,"项目编辑","${path}/infomanage/project/edit?id="+projectId);
	    }
		//删除
	    function itemDel(projectId){
	    	$.ligerDialog.confirm('请不要随意删除，如要删除，请联系管理员？', function (yes) {
	    		if(yes){
		        	parent.Public.ajaxPost("${path}/infomanage/project/delete?id="+projectId,"",function(data){
		        		data=eval(data);
		        		if(data){
		        			parent.Public.tips({type: 0, content : data.message});
		        			grid.reload();
		        		}else{
		        			parent.Public.tips({type: 0, content : data.message});
		        		}
		        	});
	    		}
	    	});
	    }
	</script>
</head>
<body>
	<div class="search-wrap">
		<form id="searchForm" onsubmit="return search();" method="post">
		<dl>
			<dd>
				<label class="b-label" for="txt_kw">项目名称：</label>
				<span class="ui-search"><input type="text" name="projectName" value="${model.projectName }" class="ui-input"></span>
				<label class="b-label" for="txt_kw">项目负责人：</label>
				<span class="ui-search"><input type="text" name="projectHead" value="${model.projectHead }" class="ui-input"></span>
			    <input id="btnOK" type="submit" value="搜 索" class="ui-btn">
			    <input type="reset" value="重置" class="ui-btn" >
			</dd>
		</dl>
		</form>		
	</div>
	<div class="clear ht_10"></div>
    <div id="maingrid" style="margin:0; padding:0"></div>
</body>
</html>
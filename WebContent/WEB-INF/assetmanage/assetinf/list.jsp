<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
	<title>资产信息列表</title>
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
					{ line: true },
					{ text: '导出Excel', click: excel, icon:'down'},
				]},
				columns: [
				{ display: '资产编号', name: 'assetId', width: "150"  },
				{ display: '资产类型', name: 'assettypeId', width: "100" },
				{ display: '资产序列号', name: 'assetserialCode', width: "150" },
				//{ display: '所属项目编号', name: 'projectNumber', width: "80"}, 
				{ display: '资产品牌', name: 'assetBrand', width: "100"},
				{ display: '资产型号', name: 'assetinfoVersion', width: "100"},
				{ display: '资产价格', name: 'assetinfoPrice', width: "60"},
				//{ display: '图片', name: 'assetinfoPic', width: "50"},
				{ display: '资产状态', name: 'assetStatus', width: "80"},
				{ display: '经办人', name: 'agentPurchaser', width: "50"},
				//{ display: '使用者Id', name: 'userId', width: "50"},
				{ display: '使用者', name: 'realName', width: "60"},
				//{ display: '制造日期', name: 'assetmadeTime', width: "60"},
				//{ display: '购买日期', name: 'assetinfoTime', width: "60"},
				//{ display: '启用日期', name: 'startUseTime', width: "60"},
				{ display: '厂商', name: 'assetfactoryId', width: "60"},
				{ display: '供应商', name: 'supplierId', width: "80"},
				{ display: '项目', name: 'projectId', width: "160"},
				{ display: '维护公司', name: 'maintenanceId', width: "80"},
				{ display: '安装地点', name: 'instaLocation', width: "240"},
				{ display: '使用年限', name: 'usedYears', width: "100"},
				{ display: '生命年限', name: 'lifeYears', width: "100"},
				//{ display: '备注', name: 'remark', width: "50" },
				{display: '操作',width: "120", render: function (rowdata, rowindex, value){
					var h="";
					h += "<a href='${path}/assetmanage/assetinf/detail?id="+rowdata.assetId+"' rel='pageTab' data-tabid='zcxq"+rowdata.assetId+"' data-tabTxt='资产详情' data-parentOpen='true' style='color:teal'>详情</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:beginEdit(\"" + rowdata.assetId + "\")' style='color:teal'>编辑</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:itemDel(\""+rowdata.assetId+"\")' style='color:teal' >删除</a> ";
					return h;
				}}],
				usePager:true,
				pageSize:20,
				//dataAction:'local',
				delayLoad:true,//延迟加载
				root:'rows',
				record:'total',
	            url:"${path}/assetmanage/assetinf/list",
				fixedCellHeight: false,
				rownumbers:true,
				clickToEdit:false,
				width: '100%',height:'99%'
			});
			search();
			Public.pageTab();//启用链接打开tab页
		});
		function add(){
			parent.Public.addTab("","新建资产","${path}/assetmanage/assetinf/add");
		}
		function refresh(){
			window.location.reload();
		}
		function excel(){
			//alert('excel export');
			var params=$("#searchForm").serialize();
			parent.Public.ajaxPost("${path}/assetmanage/assetinf/excel?"+params,"",function(data){
				data=eval(data);
				//弹出下载框
				window.open(data.param);
		   		parent.Public.tips({type: 0, content : data.message});
			});
		}
		function search(){
			grid.changePage("first");
			var params=$("#searchForm").serialize();
			grid.set("url","${path}/assetmanage/assetinf/list?"+params);
			grid.reload();
			return false;
		}
		function beginEdit(assetId) { 
			parent.Public.addTab("zcbj"+assetId,"资产编辑","${path}/assetmanage/assetinf/edit?id="+assetId);
	    }
		//删除
	    function itemDel(assetId){
	    	$.ligerDialog.confirm('请不要随意删除，如要删除，请联系管理员？', function (yes) {
	    		if(yes){
		        	parent.Public.ajaxPost("${path}/assetmanage/assetinf/delete?id="+assetId,"",function(data){
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
				<label class="b-label" for="txt_kw">资产编号：</label>
				<span class="ui-search"><input type="text" name="assetId" value="${model.assetId }" class="ui-input"></span><span class="ui-search">
				</span>
				&nbsp;&nbsp;
				<label class="b-label" for="txt_kw">资产类型：</label>
				<span class="ui-search">
					<%-- <input type="text" name="assetnameId" value="${model.assetnameId }" class="ui-input"> --%>
					<select name="assettypeId" >
						<option value="" selected>--全部--</option>
						<c:forEach items="${assettypeList }" var="item">
							<option value="${item.assettypeId }">${item.assettypeName }</option>
						</c:forEach>
					</select> 
				</span>
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
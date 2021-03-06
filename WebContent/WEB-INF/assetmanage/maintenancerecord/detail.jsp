<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
	<title>资产维护记录详情</title>
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css"> 
	<link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#btnEdit").bind("click",function(){
				var tabId=parent.tab.getSelectedTabItemID();
				parent.Public.addTab("zcwhjlbj${model.maintenancerecordId}","资产维护记录编辑","${path}/assetmanage/maintenancerecord/edit?id=${model.maintenancerecordId}");
				parent.Public.pageTabClose(tabId);
			});
			$("#btnClose").bind("click",function(){
				parent.tab.removeSelectedTabItem();					
			});
		});
	</script>
</head>
<body>
    <div class="man_zone">
         <table class="op_tb">
         	<caption style="text-align: center;">
         		资产维护记录表 
         	</caption>
             <tbody>
                 <tr>
                     <td class="label">
                          	维护记录编号：
                     </td>
                     <td>
                         ${model.maintenancerecordId }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                         	资产类型：
                     </td>
                     <td>
                         ${model.assetId }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                          	检修成员：
                     </td>
                     <td>
                         ${model.recordPeople }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                          	检修性质：
                     </td>
                     <td>
                         ${model.recordInfo }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                          	检修日期：
                     </td>
                     <td>
                         ${model.repairTime }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                          	检修前状态：
                     </td>
                     <td>
                         ${model.repairExstatus }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                          	检修内容：
                     </td>
                     <td>
                         ${model.repairContent }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                          	检修后状态：
                     </td>
                     <td>
                         ${model.repairAftstatus }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                          	验收人：
                     </td>
                     <td>
                         ${model.acceptancePerson }
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                        	 记录时间：
                     </td>
                     <td>
                         ${model.recordTime}
                     </td>
                 </tr>
                 <tr>
                     <td class="label">
                        	 验收评价：
                     </td>
                     <td>
                         ${model.acceptanceEvaluation}
                     </td>
                 </tr>
                 
                 <tr>
                     <td colspan="2" class="toolbottom" align="center">
                     	<input type="button" class="ui-btn ui-btn-sp" id="btnEdit" value="修改" />&nbsp;&nbsp;
			    		<input type="button" class="ui-btn-rad button blue" id="btnClose" value="关闭" />
                     </td>
                 </tr>
             </tbody>
         </table>   
     </div>
</body>
</html>
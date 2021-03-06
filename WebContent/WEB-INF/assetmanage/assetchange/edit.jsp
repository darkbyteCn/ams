<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
<meta name="robots" content="none" />
<title>资产领用</title>
<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css">
<link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
<script src="${path}/resources/My97DatePicker/WdatePicker.js" language="javascript" type="text/javascript"></script>
<script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
<!-- uploadifyJS和CSS -->
<script src="${path}/resources/uploadify/jquery.uploadify.min.js" type="text/javascript" ></script>
<link href="${path}/resources/uploadify/uploadify.css" rel="stylesheet" />
<script type="text/javascript">
	    $(document).ready(function(){
			var oldParams=$("#sub_form").serialize();
			$("#btnSaveNext").bind("click",function(){
				/* var flag=isBack();
				if(flag){ */
					var url="${path}/assetmanage/assetchange/save";
					var params=$("#sub_form").serialize();
					parent.
					Public.ajaxPost(url,params,saveNext);
				/* } */
			});
			$("#btnSave").bind("click",function(){
				/* var flag=isBack();
				if(flag){ */
					var url="${path}/assetmanage/assetchange/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,save);
				/* } */
			});
			$("#btnClose").bind("click",function(){
				var params=$("#sub_form").serialize();
				if(oldParams!=params){
					$.ligerDialog.confirm('您有信息未保存，是否关闭？', function (yes) { 
						if(yes) parent.tab.removeSelectedTabItem();
					});
				}else{
					parent.tab.removeSelectedTabItem();					
				}
			});
			//设置资产状态的值
			$("#assetStatus").val(${model.assetStatus});
			//初始化表单数据
			if(${empty model.aciId}){
				/* $("#nowDepartment").val("${user_depart.departName }");
				$("#nowPrincipal").val("${USERSESSION.user.userName}"); */
				$("#changeTmie").val("${now_time}");
			}
			$("#datauploadify").uploadify({
	            swf: "${path}/resources/uploadify/uploadify.swf",    //指定上传控件的主体文件
	            uploader: "${path}/assetmanage/assetchange/upload",    //指定服务器端上传处理文件
	            //其他配置项
	            //buttonClass : 'ui-btn-rad button blue',//按钮样式
	            buttonText : '附件上传',  //选择文件按钮显示的文件
	            queueID : 'datafileQueue',  //文件列表显示div
	            multi : false,              //是否可以多个同时上传
	            removeTimeout : 0,          //完成后从列表清除时间，设置0，不用等，直接去掉。
                removeCompleted : true,     //与removeTimeout参数对应，完成后是否从列表清除，设置true，即完成就自动从列表中去除。
                queueSizeLimit : 1,         //列表大小，设置为一，即只能最多上传一个文件。
                auto : true,				//是否选择了就自动上传
                fileObjName : 'file',		//后台传值的文件实体名
                onUploadSuccess :function(file, data, response){ //上传成功后执行的操作函数
                	parent.Public.tips({type: 0, content : "附件上传成功！"});
                	/* $("#assetAttach").text(file.name);
                	$("#assetAttach").attr('href','${path}/upload/'+file.name);  */
                	$("#assetAttach").val('/upload/'+file.name);
                },
                onUploadError: function(file,data,response){//上传失败后自行的操作函数
                	parent.Public.tips({type: 1, content : "附件上传失败！"});
                }
        	});
		});
		function saveNext(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.dwlb);
				parent.Public.tips({type: 0, content : data.message});
				window.location.reload();
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		function save(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.dwlb);
				parent.Public.tips({type: 0, content : data.message});
				var tabId=parent.tab.getSelectedTabItemID();
				parent.Public.addTab("dwxx"+data.param,"资产调拨详细","${path}/assetmanage/assetchange/detail?id="+data.param);
				parent.Public.pageTabClose(tabId);
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		
		//该资产是否归还了，归还了才可以被领取。
		/* function isBack(){
			var assetId=$("#assetId").val();
			var flag=true;
			$.ajax({
				type:"post",
				async:false,
				url:"${path}/assetmanage/assetchange/isBack",
				data:{id:assetId},
	    		dataType:'json',
	    		contentType:"application/x-www-form-urlencoded; charset=utf-8",	
	    		success:function(data){
	    			if(data){
	    				flag=true;
	    			}else{
						flag=false;
						parent.Public.tips({type: 2, content : '该资产尚未归还，无法领用！'});
	    			}
	    		},
	    		error:function(){
	    			flag=false;
	    		}
			});
			return flag;
		} */
    </script>
</head>
<body>
	<div class="man_zone">
		<form id="sub_form" action="${path }/assetmanage/assetchange/save"
			method="post">
			<table class="op_tb">
				<caption style="text-align: center;">
					<c:choose>
						<c:when test="${empty model.aciId}">资产领用录入</c:when>
						<c:otherwise>
            				资产领用信息修改
            				<input type="hidden" name="aciId"
								value="${model.aciId }" />
						</c:otherwise>
					</c:choose>
				</caption>
				<tbody>
					<tr>
						<td class="label">关联资产编号及信息：</td>
						<td colspan=3>
							<select name="assetId">
									<c:forEach items="${assetinfList }" var="item">
										<option
											<c:if test="${ item.assetId eq model.assetId }">selected</c:if>
											value="${item.assetId }">${item.assetId }-${item.assetBrand }-${item.assetinfoVersion }</option>
									</c:forEach>
							</select>* 
						<%-- <input type="text" name="assetId" id="assetId" value="${model.assetId }" /> --%>
						</td>
					</tr>
					<tr>
						<td class="label">原使用部门：</td>
						<td>
							<select name="originalDepartment">
									<c:forEach items="${departList }" var="item">
										<option
											<c:if test="${ item.departId eq model.originalDepartment }">selected</c:if>
											value="${item.departId }">${item.departName }</option>
									</c:forEach>
							</select>* 
							<%-- <input type="text" name="originalDepartment" id="originalDepartment" value="${model.originalDepartment }" disabled="disabled" /> --%>
						</td>
						<td class="label">原负责人：</td>
						<td>
							<select name="originalPrincipal">
									<c:forEach items="${userList }" var="item">
										<option
											<c:if test="${ item.userId eq model.originalPrincipal }">selected</c:if>
											value="${item.userId }">${item.userName }</option>
									</c:forEach>
							</select>* 
							<%-- <input type="text" name="originalPrincipal" id="originalPrincipal" value="${model.originalPrincipal}" disabled="disabled" /> --%>
						</td>
					</tr>
					<tr>
						<td class="label">现使用部门：</td>
						<td>
							<select name="nowDepartment">
									<c:forEach items="${departList }" var="item">
										<option
											<c:if test="${ item.departId eq model.nowDepartment }">selected</c:if>
											value="${item.departId }">${item.departName }</option>
									</c:forEach>
							</select>* 
							<%-- <input type="text" name="nowDepartment" id="nowDepartment" value="${model.nowDepartment}" /> --%>
						</td>
						<td class="label">现负责人：</td>
						<td>
							<select name="nowPrincipal">
									<c:forEach items="${userList }" var="item">
										<option
											<c:if test="${ item.userId eq model.nowPrincipal }">selected</c:if>
											value="${item.userId }">${item.userName }</option>
									</c:forEach>
							</select>* 
							<%-- <input type="text" name="nowPrincipal" id="nowPrincipal" value="${model.nowPrincipal}" /> --%>
						</td>
					</tr>
					<tr>
						<td class="label">调拨时间：</td>
						<td>
						<input type="text" name="changeTmie" id="changeTmie" class="Wdate" style="width:160px"
							value="${model.changeTmie}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" 
							errormsg="请选择正确的日期" />*
							
							</td>
						<td class="label">资产状态：</td>
						<td><select name="assetStatus" id="assetStatus">
								<option value="1" selected="selected">领用中</option>
								<option value="0">已归还</option>
						</select>*</td>
					</tr>
					<tr>
						<td class="label">资产附件(上传功能仅支持高版本浏览器)：</td>
						<td colspan=3>
							<input type="text" name="assetAttach" id="assetAttach" value="${model.assetAttach}" readonly style="width:160px"/>
							<%-- <a href="${model.assetAttach}" name="assetAttach" id="assetAttach" target='_blank'>${model.assetAttach}</a> --%>
							<input type="file" name="datauploadify" id="datauploadify" />
							<div id="datafileQueue"></div>
						</td>
					</tr>
					<tr>
						<td class="label">备注：</td>
						<td colspan=3><textarea name="remark" cols="100" rows="5"
								class="l-textarea" style="width: 100%x;">${model.remark}</textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="toolbottom" align="center"><c:if
								test="${empty model.aciId }">
								<input type="button" class="ui-btn ui-btn-sp" id="btnSaveNext"
									value="保存并新建" />&nbsp;&nbsp;
							</c:if> <input type="button" class="ui-btn ui-btn-sp" id="btnSave"
							value="保存" />&nbsp;&nbsp; <input type="button"
							class="ui-btn-rad button blue" id="btnClose" value="关闭" /></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>
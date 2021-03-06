<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
    <title>资产信息编辑</title>    
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
				/* var flag=checkUser();
				if(!flag){ */
					var url="${path}/assetmanage/assetinf/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,saveNext);
				/* } */
			});
			$("#btnSave").bind("click",function(){
				/* var flag=checkUser();
				if(!flag){ */
					var url="${path}/assetmanage/assetinf/save";
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
			if(${empty model.assetId}){
				$("#assetmadeTime").val("${now_time}");
				$("#assetinfoTime").val("${now_time}");
				$("#startUseTime").val("${now_time}");
				$("#usedYears").val("${now_time}");
				$("#lifeYears").val("${now_time}");
			}
			$("#datauploadify").uploadify({
	            swf: "${path}/resources/uploadify/uploadify.swf",    //指定上传控件的主体文件
	            uploader: "${path}/assetmanage/assetinf/upload",    //指定服务器端上传处理文件
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
                	$("#assetinfoPic").val('/upload/'+file.name);
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
				parent.Public.addTab("zcxq"+data.param,"资产详情","${path}/assetmanage/assetinf/detail?id="+data.param);
				parent.Public.pageTabClose(tabId);
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		
		//检查当前资产
		function checkUser(){
			var name=$("#assetName").val();
			var flag=true;
			$.ajax({
				type:"post",
				async:false,
				url:"${path}/assetmanage/assetinf/checkAssetinf",
				data:{name:name,id:"${model.assetId}"},
	    		dataType:'json',
	    		contentType:"application/x-www-form-urlencoded; charset=utf-8",	
	    		success:function(data){
	    			if(data){
	    				parent.Public.tips({type: 2, content : '资产已存在！'});
	    				flag=true;
	    			}else{
						flag=false;
	    			}
	    		},
	    		error:function(){
	    			flag=true;
	    		}
			});
			return flag;
		}
    </script>
</head>
    <body>
       <div class="man_zone">
            <form id="sub_form" action="${path }/assetmanage/assetinf/save" method="post">
            <table class="op_tb">
            	<caption style="text-align: center;">
            		<c:choose>
            			<c:when test="${empty model.assetId}">资产信息录入</c:when>
            			<c:otherwise>
            				资产信息修改
            				<input type="hidden" name="assetId" value="${model.assetId }" />
            			</c:otherwise>
            		</c:choose>
            	</caption>
                <tbody>
                    <%-- <tr>
                        <td class="label">
                            	资产编号：
                        </td>
                        <td>
                            <input type="text" name="assetId" id="assetId" value="${model.assetId }"/>
                        </td>
                    </tr> --%>
                    <tr>
                        <td class="label">资产类型：</td>
                        <td colspan=3>
                            <select name="assettypeId">
									<c:forEach items="${assettypeList }" var="item">
										<option
											<c:if test="${ item.assettypeId eq model.assettypeId }">selected</c:if>
											value="${item.assettypeId }">${item.assettypeName }</option>
									</c:forEach>
							</select>*
                            <%-- <input type="text" name="assetnameId" id="assetnameId" value="${model.assetnameId }"/> --%>
                        </td>
                    </tr>
                    <%-- <tr>
                        <td class="label">
                            	资产出厂编号：
                        </td>
                        <td>
                            <input type="text" name="assetserialCode" value="${model.assetserialCode}" />
                        </td>
                    </tr> --%>
                    <%-- <tr>
                        <td class="label">
                            	所属项目编号：
                        </td>
                        <td>
                            <input type="text" name="projectNumber" value="${model.projectNumber }" />
                        </td>
                    </tr> --%>
                    <tr>
                        <td class="label">资产品牌：</td>
                        <td ><!-- style="width: 290px; " -->
                            <input type="text" name="assetBrand" value="${model.assetBrand }" />*
                        </td>
                        <td class="label">
                            	资产型号：
                        </td>
                        <td>
                            <input type="text" name="assetinfoVersion" value="${model.assetinfoVersion }" />*
                        </td>
                        
                    </tr>                   
                    <tr>
                        <td class="label">
                            	资产价格：
                        </td>
                        <td>
                            <input type="text" name="assetinfoPrice" value="${model.assetinfoPrice }" />*
                        </td>
                        <td class="label">
                            	经办人：
                        </td>
                        <td>
                            <input type="text" name="agentPurchaser" value="${model.agentPurchaser }" />*
                        </td>
                        
                    </tr>
                    
                    <tr>
                        <td class="label">
                            	资产状态：
                        </td>
                        <td>
                        	<select name="assetStatus">
                        		
                        		<option <c:if test='${ "在用" eq model.assetStatus }'>selected</c:if> value="在用" >在用</option>
                        		<option <c:if test='${ "在修" eq model.assetStatus }'>selected</c:if> value="在修" >在修</option>
                        		<option <c:if test='${ "备用" eq model.assetStatus }'>selected</c:if> value="备用" >备用</option>
                        		<option <c:if test='${ "闲置" eq model.assetStatus }'>selected</c:if> value="闲置" >闲置</option>
                        		<option <c:if test='${ "调剂" eq model.assetStatus }'>selected</c:if> value="调剂" >调剂</option>
                        		<option <c:if test='${ "待报废" eq model.assetStatus }'>selected</c:if> value="待报废" >待报废</option>
                        		<option <c:if test='${ "报废" eq model.assetStatus }'>selected</c:if> value="报废" >报废</option>
                        	</select>*
                            <%-- <input type="text" name="assetStatus" value="${model.assetStatus }" /> --%>
                        </td>
                        <td class="label">
                            	使用者：
                        </td>
                        <td>
                            <%-- <input type="text" name="userId" value="${model.userId }" /> --%>
                            <select name="userId">
								<c:forEach items="${userList }" var="item">
									<option
										<c:if test="${ item.userId eq model.userId }">selected</c:if>
										value="${item.userId }">${item.userName }</option>
								</c:forEach>
							</select>*
                        </td>
                        
                    </tr>
                    <!-- <tr style="width: 686px; ">
                        
                    </tr> -->
                    <tr>
                        <td class="label">
                            	制造日期：
                        </td>
                        <td>
                        	<input type="text" name="assetmadeTime" id="assetmadeTime" value="${model.assetmadeTime }" class="Wdate" style="width:160px"
							value="${model.assetmadeTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" 
							errormsg="请选择正确的日期" />*
                            <%-- <input type="text" name="assetmadeTime" value="${model.assetmadeTime }" /> --%>
                        </td>
                        <td class="label">
                            	购买日期：
                        </td>
                        <td>
                        	<input type="text" name="assetinfoTime" id="assetinfoTime" value="${model.assetinfoTime }" class="Wdate" style="width:160px"
							value="${model.assetinfoTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" 
							errormsg="请选择正确的日期" />*
                            <%-- <input type="text" name="assetinfoTime" value="${model.assetinfoTime }" /> --%>
                        </td>
                        
                    </tr>
                    <tr>
                        <td class="label">
                            	启用日期：
                        </td>
                        <td>
                        	<input type="text" name="startUseTime" id="startUseTime" value="${model.startUseTime }" class="Wdate" style="width:160px"
							value="${model.startUseTime}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" 
							errormsg="请选择正确的日期" />*
                            <%-- <input type="text" name="startUseTime" value="${model.startUseTime }" /> --%>
                        </td>
                        <td class="label">
                            	厂商：
                        </td>
                        <td>
                            <select name="assetfactoryId">
									<c:forEach items="${facotryList }" var="item">
										<option
											<c:if test="${ item.factoryId eq model.assetfactoryId }">selected</c:if>
											value="${item.factoryId }">${item.factoryName }</option>
									</c:forEach>
							</select>*
                            <%-- <input type="text" name="assetfactoryId" value="${model.assetfactoryId }" /> --%>
                        </td>
                        
                    </tr>
                    <tr>
                        <td class="label">
                            	供应商：
                        </td>
                        <td>
                        	<select name="supplierId">
								<c:forEach items="${supplierList }" var="item">
									<option
										<c:if test="${ item.supplierId eq model.supplierId }">selected</c:if>
										value="${item.supplierId }">${item.supplierName }</option>
								</c:forEach>
							</select>*
                            <%-- <input type="text" name="supplierId" value="${model.supplierId }" /> --%>
                        </td>
                        <td class="label">
                            	项目：
                        </td>
                        <td>
                        	<select name="projectId">
								<c:forEach items="${projectList }" var="item">
									<option
										<c:if test="${ item.projectId eq model.projectId }">selected</c:if>
										value="${item.projectId }">${item.projectName }</option>
								</c:forEach>
							</select>*
                            <%-- <input type="text" name="projectId" value="${model.projectId }" /> --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	维护公司：
                        </td>
                        <td>
                        	<select name="maintenanceId">
								<c:forEach items="${maintenanceinfoList }" var="item">
									<option
										<c:if test="${ item.maintenanceId eq model.maintenanceId }">selected</c:if>
										value="${item.maintenanceId }">${item.maintenanceName }</option>
								</c:forEach>
							</select>*
                            <%-- <input type="text" name="maintenanceId" value="${model.maintenanceId }" /> --%>
                        </td>
                        <td class="label">
                            	安装地点：
                        </td>
                        <td>
                            <input type="text" name="instaLocation" value="${model.instaLocation }" />*
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	使用年限：
                        </td>
                        <td>
                        	<input type="text" name="usedYears" id="usedYears" value="${model.usedYears }" class="Wdate" style="width:160px"
							value="${model.usedYears}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" 
							errormsg="请选择正确的日期" />*
                            <%-- <input type="text" name="usedYears" value="${model.usedYears }" /> --%>
                        </td>
                        <td class="label">
                            	生命年限：
                        </td>
                        <td>
	                        <input type="text" name="lifeYears" id="lifeYears" value="${model.lifeYears }" class="Wdate" style="width:160px"
							value="${model.lifeYears}"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
							datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/" 
							errormsg="请选择正确的日期" />*
                            <%-- <input type="text" name="lifeYears" value="${model.lifeYears }" /> --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">备注：</td>
                        <td colspan=3>
                            <textarea name="remark" cols="100" rows="5" class="l-textarea" style="width: 600px;">${model.remark }</textarea>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	附件(上传功能仅支持高版本浏览器)：
                        </td>
                        <td colspan=3>
                            <input type="text" name="assetinfoPic" id="assetinfoPic" value="${model.assetinfoPic }" readonly style="width:160px"/>
                            <input type="file" name="datauploadify" id="datauploadify" />
                            <div id="datafileQueue"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="toolbottom" align="center">
	                        <c:if test="${empty model.assetId }">
								<input type="button" class="ui-btn ui-btn-sp" id="btnSaveNext" value="保存并新建" />&nbsp;&nbsp;
							</c:if>
							<input type="button" class="ui-btn ui-btn-sp" id="btnSave" value="保存" />&nbsp;&nbsp;
						    <input type="button" class="ui-btn-rad button blue" id="btnClose" value="关闭" />
                        </td>
                    </tr>
                </tbody>
            </table>   
            </form>
        </div>
    </body>
</html>
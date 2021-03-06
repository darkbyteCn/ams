<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
	<c:if test="${empty user.userId}"><title>新建用户</title></c:if>
	<c:if test="${not empty user.userId}"><title>用户编辑</title></c:if>
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css"> 
	<link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var oldParams=$("#sub_form").serialize();
			$("#btnSaveNext").bind("click",function(){
				var flag=checkUser();
				if(!flag){
					var url="${path}/userRole/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,saveNext);
				}
			});
			$("#btnSave").bind("click",function(){
				var flag=checkUser();
				if(!flag){
					var url="${path}/userRole/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,save);
				}
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
		});
		function saveNext(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.yhlb);
				parent.Public.tips({type: 0, content : data.message});
				window.location.reload();
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		function save(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.yhlb);
				parent.Public.tips({type: 0, content : data.message});
				var tabId=parent.tab.getSelectedTabItemID();
				parent.Public.addTab("yhxx"+data.param,"用户详细","${path}/user/detail?id="+data.param);
				parent.Public.pageTabClose(tabId);
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		
		//检查当前用户
		function checkUser(){
			var name=$("input[name='userName']").val();
			var flag=true;
			$.ajax({
				type:"post",
				async:false,
				url:"${path}/userRole/check",
				data:{userName:name},
        		dataType:'json',
        		contentType:"application/x-www-form-urlencoded; charset=utf-8",	
        		success:function(data){
        			if(data){
        				parent.Public.tips({type: 2, content : '用户名已存在！'});
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
	<div id="man_zone" class="clear">
		<form id="sub_form" action="${path }/userRole/save" method="post">
        <table class="op_tb" >
            <caption style="text-align: center;">
            	<c:if test="${empty user.userId }">用户新建</c:if>
            	<c:if test="${not empty user.userId }">
            		用户修改 NO.${user.userId}
            		<input type="hidden" name="userId" value="${user.userId }" /> 
            	</c:if>
            </caption>
            <tbody>
                <tr>
                    <td class="label">
                    	<label>用&nbsp;户&nbsp;名：</label>
                    </td>
                    <td>
                    	<c:if test="${empty user.userId }">
                        	<input type="text" name="userName"  />  
                        </c:if> 
                        <c:if test="${not empty user.userId }"> 
                        	${user.userName }
                        </c:if>                 
                    </td>
                </tr>
                <c:if test="${empty user.userId }">
                <tr>
                    <td class="label">
                       	密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码：
                    </td>
                    <td>
                        <input type="password" name="password" value="${user.password }"/>
                        <span Class="msgNormal">初始密码 " 123456 "</span>
                    </td>
                </tr>
                </c:if>
                <tr>
                	<td class="label">
                		角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：
                	</td>
                	<td>
				 		<div id="info_2" class="block" >
							<div class="pubuls" style="width: 80%;">				
								<ul class="chklist">
									<c:forEach items="${allRole }" var="item" varStatus="i">
									<li>
										<input type="checkbox" name="role" value="${item.roleId}" title="选择" <c:if test="${fn:contains(rList,item.roleId) }">checked="checked"</c:if> />
										<c:if test="${fn:length(item.roleName)>6}">${fn:substring(item.roleName,0,5)}...</c:if>
										<c:if test="${fn:length(item.roleName)<=6}">${item.roleName}</c:if>	
									</li>
									</c:forEach>
									<li class="clear" style="height:0;width:0;"></li>
								</ul>									
							</div>		
						</div>               	
                	</td>
                </tr>   
                <tr>
                    <td class="label">
                       	姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：
                    </td>
                    <td>
                        <input type="text" name="realName" value="${user.realName }"/>
                    </td>
                </tr>
                <tr>
                    <td class="label">
                       	电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：
                    </td>
                    <td>
                        <input type="text" name="phone" value="${user.phone }">
                    </td>
                </tr> 
                <tr>
                    <td class="label">
                       	部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：
                    </td>
                    <td>
                        <%-- <input type="text" name="phone" value="${user.departId }"> --%>
                        <select name="departId" id="departId">
									<c:forEach items="${departIdList }" var="item">
										<option
											<c:if test="${ item.departId eq model.departId }">selected</c:if>
											value="${item.departId }">${item.departName }</option>
									</c:forEach>
						</select>
                    </td>
                </tr> 
                <tr>
					<td colspan="2" align="center">
						<c:if test="${empty user.userId }">
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
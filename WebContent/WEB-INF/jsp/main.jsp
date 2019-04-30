<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.6.6/themes/default/easyui.css"/>
	 <!-- css是一些小图标-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jquery-easyui-1.6.6/themes/icon.css"/>
	 <!-- jquery核心库 ，query.easyui.min和jquery.min两个js的引入顺序不能搞错-->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.6.6/jquery.min.js"></script>
	<!-- easyui核心库 -->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.6.6/jquery.easyui.min.js"></script>
	 <!--有时候，我们需要进行国际化，比如一些提醒、日历等，就需要引入-->
	<script type="text/javascript" src="${pageContext.request.contextPath }/jquery-easyui-1.6.6/locale/easyui-lang-zh_CN.js"></script>
	<link href="${pageContext.request.contextPath}/style/alogin.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
		//页面加载执行
		$(function(){
			$("#tree").tree({
				line:true,
				url:"${pageContext.request.contextPath}/auth/main.do",
				onLoadSuccess:function(){
					$("#tree").tree("collapseAll")
				},
				onClick:function(node){
					if(node.id==54){
					logout();
					}else if(node.id==53){
						openPasswordModifyDialog();
					}else if(node.attributes.authPath){
						openTab(node);
					}
				}
			})
		})
		//点击节点触发事件
		function openTab(node){
			if($("#tabs").tabs("exists",node.text)){
				$("#tabs").tabs("select",node.text);
			}else{
				content="<iframe iframeboder=0 scolling='auto' style=' width:100%;height:100%' src='${pageContext.request.contextPath }/html/" + node.attributes.authPath + "'></iframe>";
				$("#tabs").tabs("add",{
					title:node.text,
					iconCls:node.iconCls,
					closable:true,
					content:content
				})
			}
		}
		//打开修改密码弹框
		function openPasswordModifyDialog(){
			$("#dlg").dialog("open");
		}
		//关闭修改密码弹框
		function closeModifyPass(){
			$("#dlg").dialog("close");
		}
		//修改密码
		function saveModifyPass(){
			$("#fm").form("clear");
			$("#fm").form("submit",{
				url:"../user/updatePassWord.do",
				onSubmit:function(){
					return $(this).form("validate"); 
				},
				success:function(result){
					var result=eval('('+result+')');
					if(result.errorMsg){
						$.messager.alert("系统提示","<font color=red>"+result.errorMsg+"</font>");
						return;
					}else{
						$.messager.alert("系统提示","密码修改成功！");
						 closeUserAddDialog();
						$("#dg").datagrid("reload");
					}
				}
			})
		}
	</script>
</head>
<body class="easyui-layout">
	<div region="north" style="height: 68px;"> 
        <div style="padding: 0px;margin: 0px;background-color: #E0ECFF;">
		<table>
		    <tr>
		          <td><img alt=“北邮在线" src="${pageContext.request.contextPath}/images/mainlogo.png"></td>
		          <td valign="bottom">欢迎：${currentUser.userName }&nbsp;&nbsp;『${currentUser.roleName }』</td>
		    </tr>
		</table>
       </div>
    </div>
	<div region="south" style="height: 25px;padding: 5px;" align="center">
		版权所有 北邮在线<a href="http://www.xianyazhuo.com" target="_blank">http://www.xianyazhuo.com</a>
	</div>

	<div data-options="region:'west',split:true,collapsible:true" title="导航菜单" style="width:100px;">
		<ul id="tree" class="eazyui-tree"></ul>
	</div>
	<div region="center">
		<div class="easyui-tabs" fit="true" border="false" id="tabs">
			<div title="首页" data-options="iconCls:'icon-home'">
				<div align="center" style="padding-top: 100px;">
					<font color="red" size="10">欢迎使用</font>
				</div>
			</div>
		</div>
    </div>
         <div id="dlg" class="easyui-dialog" style="width: 330px;height: 200px;padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		     <form id="fm" method="post">
			     <table cellspacing="5px">
					<tr>
				      	<td>原始密码：</td>
						<td>
							<input type="hidden" id="userId" name="userId" />
					      	<input type="text" id="password" name="password" class="easyui-validatebox" required="true"/>
					      </td>
					</tr>
					<tr>
						<td>新密码：</td>
				      	<td>
				      		<input type="hidden" id="roleId" name="roleId"/>
				 			<input type="text" id="roleName" name="roleName" class="easyui-validatebox" required="true" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<td>确认密码：</td>
				      	<td>
				      		<input type="hidden" id="roleId" name="roleId"/>
				 			<input type="text" id="roleName" name="roleName" class="easyui-validatebox" required="true" readonly="readonly"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div id="dlg-buttons">
	      	<a href="javascript:saveModifyPass()" class="easyui-linkbutton" iconCls="icon-ok">确定</a>
	      	<a href="javascript: closeModifyPass()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
		</div>
</body>
</html>
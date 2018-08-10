<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理系统主页</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<script type="text/javascript">

	function openPage(text,url,iconCls){ //打开页面的方法
		if($("#tabs").tabs("exists",text)){ //页面已经存在
			$("#tabs").tabs("select",text); //选择方法
		}else{   //否则打开一个新的页面
			//新建一个内容的iframe  打开page文件夹下的页面
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/page/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,     //标题
				iconCls:iconCls,  //配置按钮的图标
				closable:true,    //可关闭的
				content:content    //内容就是自己定义的
			});
		}
	}
	
	function openPasswordModifyDialog(){
		$("#dlg").dialog("open").dialog("setTitle","修改密码");
		url="${pageContext.request.contextPath}/user/modifyPassword.do?id=${currentUser.id}";
	}
	
	function modifyPassword(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				var oldPassword=$("#oldPassword").val();
				var newPassword=$("#newPassword").val();
				var newPassword2=$("#newPassword2").val();
				if(!$(this).form("validate")){
					return false;
				}
				if(oldPassword!='${currentUser.password}'){
					$.messager.alert("系统提示","用户原密码输入错误！");
					return false;
				}
				if(newPassword!=newPassword2){
					$.messager.alert("系统提示","您两次输入的密码不一致！");
					return false;
				}
				return true;
			},
			success:function(result){
				var result=eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","密码修改成功");
					resetValue();
					$("#dlg").dialog("close");
				}else{
					$.messager.alert("系统提示","密码修改失败！");
					return;
				}
			}
		 });
	}
	
	function closePasswordModifyDialog(){
		resetValue();
		$("#dlg").dialog("close");
	}
	
	function resetValue(){
		$("#oldPassword").val("");
		$("#newPassword").val("");
		$("#newPassword2").val("");
	}
	
	function logout(){    //退出需要confirm确定框
		$.messager.confirm("系统提示","您确定要退出系统吗？",function(r){
			if(r){
				window.location.href='${pageContext.request.contextPath}/user/logout.do';
			} 
		 });
	}
	
	 function openTab(text,url,iconCls){
		if($("#tabs").tabs("exists",text)){
			$("#tabs").tabs("select",text);
		}else{
			var content="<iframe frameborder=0 scrolling='auto' style='width:100%;height:100%' src='${pageContext.request.contextPath}/page/"+url+"'></iframe>";
			$("#tabs").tabs("add",{
				title:text,
				iconCls:iconCls,
				closable:true,
				content:content
			});
		}
	} 
	
</script>



</head>
<body class="easyui-layout">      <!-- easyUI布局 -->
<!-- 页面顶部及菜单栏 -->
<div region="north" style="height: 78px;background-color: #E0ECFF">
	<table style="padding: 5px" width="100%">
		<tr>
			<td width="50%">
				<img alt="logo" src="${pageContext.request.contextPath}/images/bglogo.png">
			</td>
			<td valign="bottom" align="right" width="50%" >
				<font size="3">&nbsp;&nbsp;<strong>${currentUser.roleName }：</strong>${currentUser.trueName  }&nbsp;&nbsp;&nbsp;&nbsp;</font>
				<br>
			</td>
			
		</tr>
	</table>
</div>
<!-- 主显示区域         tabs是选项卡插件-->
<div region="center">
	<div class="easyui-tabs" fit="true" border="false" id="tabs">
		<div title="主页" data-options="iconCls:'icon-home'">
		   <div align="center" style="padding-top: 60px"><font color="blue" size="7">欢迎进入云服务器租赁管理后台</font></div>
		<div><p style="text-align:center"><img alt="" src="images/cloud.jpg" width="450" height="350" ></p></div>
		</div>
	</div>
</div>
<!-- 左侧导航菜单 -->
<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
	<div title="基础信息管理"  data-options="selected:true,iconCls:'icon-jcsjgl'" style="padding:10px">
	<a href="javascript:openPage('用户角色管理','userManage.jsp','icon-user')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-user'" style="width: 150px;">用户角色管理</a>
	<a href="javascript:openPage('公告管理','noteManage.jsp','icon-note')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-note'" style="width: 150px;">公告管理</a>
		</div>
	
	<div title="租赁业务管理" data-options="iconCls:'icon-yewu'" style="padding: 10px">
	<a href="javascript:openPage('套餐资费信息管理','costManage.jsp','icon-taocan')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-taocan'" style="width: 150px;">套餐资费信息管理</a>
		<a href="javascript:openPage('业务信息管理','businessManage.jsp','icon-yxjhgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-yxjhgl'" style="width: 150px">业务信息管理</a>
		<a href="javascript:openPage('租赁业务办理','conductBusiness.jsp','icon-khkfjh')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khkfjh'" style="width: 150px">租赁业务办理</a>
		<a href="javascript:openPage('业务文件上传下载管理','fileOrUpload.jsp','icon-fwgd')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-fwgd'" style="width: 150px;">业务文件上传下载管理</a>
	</div>
	<div title="客户管理"  data-options="iconCls:'icon-khgl'" style="padding:10px;">
		<a href="javascript:openPage('客户信息管理','customerManage.jsp','icon-khxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khxxgl'" style="width: 150px;">客户信息管理</a>
		<a href="javascript:openPage('客户数据字典','dataDicManage.jsp','icon-sjzdgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-sjzdgl'" style="width: 150px;">客户数据字典</a>
	</div>
	<div title="统计报表"  data-options="iconCls:'icon-tjbb'" style="padding:10px">
		<a href="javascript:openPage('客户账单报表','accountStatement.jsp','icon-khgxfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgxfx'" style="width: 150px;">客户账单报表</a>
		<a href="javascript:openPage('客户构成报表','customerGc.jsp','icon-khgcfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgcfx'" style="width: 150px;">客户构成报表(柱状)</a>
	</div>
	
	<div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
		<a href="javascript:openPasswordModifyDialog()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-modifyPassword'" style="width: 150px;">修改密码</a>
		<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
	</div>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width:400px;height:250px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>用户名：</td>
   			<td><input type="text" id="userName" name="userName" readonly="readonly" value="${currentUser.userName }" style="width: 200px"/></td>
   		</tr>
   		<tr>
   			<td>原密码：</td>
   			<td><input type="password" id="oldPassword" name="oldPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
   		</tr>
   		<tr>
   			<td>新密码：</td>
   			<td><input type="password" id="newPassword" name="newPassword" class="easyui-validatebox" required="true" style="width: 200px"/></td>
   		</tr>
   		<tr>
   			<td>确认新密码：</td>
   			<td><input type="password" id="newPassword2" name="newPassword2" class="easyui-validatebox" required="true" style="width: 200px"/></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:modifyPassword()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closePasswordModifyDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 
 <!-- 页面底部信息 -->
<div region="south" style="height: 25px;padding: 5px" align="center">
	苏州科技大学2018毕业设计 <a href="http://www.usts.edu.cn/" target="_blank">http://www.usts.edu.cn/</a>(2018)
</div>
</body>
</html>
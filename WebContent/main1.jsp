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
			//新建一个内容的iframe
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
		   <div align="center" style="padding-top: 100px"><font color="blue" size="10">欢迎进入云服务器租赁管理后台</font></div>
		   <div><p style="text-align:center"><img alt="" src="images/cloud.jpg" width="450" height="350" ></p></div>

		</div>
	</div>
</div>
<!-- 左侧导航菜单 -->
<div region="west" style="width: 200px" title="导航菜单" split="true">
	<div class="easyui-accordion" data-options="fit:true,border:false">
	
	<div title="业务管理" data-options="selected:true,iconCls:'icon-yxgl'" style="padding: 10px">
	<a href="javascript:openPage('套餐资费信息管理','costManage.jsp','icon-cpxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-cpxxgl'" style="width: 150px;">套餐资费信息管理</a>
		<a href="javascript:openPage('业务信息管理','businessManage.jsp','icon-yxjhgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-yxjhgl'" style="width: 150px">业务信息管理</a>
		<a href="javascript:openPage('业务办理','conductBusiness.jsp','icon-khkfjh')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khkfjh'" style="width: 150px">业务办理</a>
	</div>
	<div title="客户管理"  data-options="iconCls:'icon-khgl'" style="padding:10px;">
		<a href="javascript:openPage('客户信息管理','customerManage.jsp','icon-khxxgl')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khxxgl'" style="width: 150px;">客户信息管理</a>
	</div>
	<div title="统计报表"  data-options="iconCls:'icon-tjbb'" style="padding:10px">
		<a href="javascript:openPage('客户账单报表','accountStatement.jsp','icon-khgxfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgxfx'" style="width: 150px;">客户账单报表</a>
		<a href="javascript:openPage('客户构成报表','customerGc.jsp','icon-khgcfx')" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-khgcfx'" style="width: 150px;">客户构成报表(柱状)</a>
	</div>
	
	<div title="系统管理"  data-options="iconCls:'icon-item'" style="padding:10px">
		<a href="javascript:logout()" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-exit'" style="width: 150px;">安全退出</a>
	</div>
	</div>
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
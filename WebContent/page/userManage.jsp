<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	var url;                //传递路径
 function findUser(){
	 $("#dg").datagrid('load',{
		"userName":$("#s_userName").val()    //将userName传回去
	 });
 }
 
 function openUserAddDialog(){  //添加
	 $("#dlg").dialog("open").dialog("setTitle","添加角色信息");
	 url="${pageContext.request.contextPath}/user/addOrUpdate.do";
 }
 
 function openUserModifyDialog(){  //修改
	 var selectedRows=$("#dg").datagrid("getSelections");//获取选中行 可能是多行
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要修改的记录！");
		 return;
	 }
	 var row=selectedRows[0];   //选择一条
	 $("#dlg").dialog("open").dialog("setTitle","编辑角色信息");
	 $("#fm").form("load",row);  //自动加载表单数据    修改需要加上id
	 url="${pageContext.request.contextPath}/user/addOrUpdate.do?id="+row.id;
 }
 
 function saveUser(){
	 $("#fm").form("submit",{    //提交form
		url:url,               //传递路径
		onSubmit:function(){    //验证
			if($("#roleName").combobox("getValue")==""){  //获取选择框的值
				$.messager.alert("系统提示","请选择用户角色！");
				return false; 	  //不提交
			}
			return $(this).form("validate");   	//调用系统验证  验证不通过就返回false
		},
		success:function(result){   //result是一个json串
			var result=eval('('+result+')'); //搞成json对象
			if(result.success){   			//执行成功
				$.messager.alert("系统提示","保存成功！");
				resetValue();            //自定义重置值方法
				$("#dlg").dialog("close");   //关闭对话框
				$("#dg").datagrid("reload");  //重新加载
			}else{
				$.messager.alert("系统提示","保存失败！");
				return;
			}
		}
	 });
 }
 
 function resetValue(){   // 调用jquery清空数据方法
	 $("#userName").val("");
	 $("#password").val("");
	 $("#trueName").val("");
	 $("#email").val("");
	 $("#phone").val("");
	 $("#roleName").combobox("setValue","");
 }
 
 function closeUserDialog(){  //关闭对话框
	 $("#dlg").dialog("close");
	 resetValue();
 }
 
 function deleteUser(){  //删除
	 var selectedRows=$("#dg").datagrid("getSelections");//获取选中要删除的行
	 if(selectedRows.length==0){  //判断是否选中了一行
		 $.messager.alert("系统提示","请选择要删除的角色信息！");
		 return;
	 }
	 var strIds=[];   //定义选中的id数组  可以删除多条
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].id);  //json  遍历循环选中行的id push进入数组
	 }
	 var ids=strIds.join(",");  //返回逗号分隔的字符串
	 //删除是危险操作 需要做验证
	 $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(msg){
		if(msg){  //选择确定删除
			//发起ajax请求  $.post(url,[data],[callback],[type]) 请求页面的url地址 请求参数 请求成功的回调函数 参数类型(服务器返回内容的格式)
			//使用post方法可以简便的将前台表单信息传送到后台，进行相应的处理 在把对应结果再次响应回前台
			$.post("${pageContext.request.contextPath}/user/delete.do",{ids:ids},function(result){
				if(result.success){
					 $.messager.alert("系统提示","数据已成功删除！");
					 $("#dg").datagrid("reload");//重新加载
				}else{
					$.messager.alert("系统提示","删除失败！");
				}
			},"json");  //指定参数类型 以json格式进行封装
		} 
	 });
 }
</script>
<title>角色管理</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="用户角色管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/user/list.do" fit="true" toolbar="#tb" data-options="rowStyler: function(index,row){
                  if ((index % 2)==0){
                        return 'background-color:#FFF7FB;color:#000000;font-weight:bold;'; }
              }">
   <thead>
   	<tr>	
   		<th field="id" width="50" align="center" hidden="true">编号</th>
   		<th field="userName" width="50" align="center">用户名</th>
   		<th field="password" width="50" align="center">密码</th>
   		<th field="trueName" width="50" align="center">真实姓名</th>
   		<th field="email" width="100" align="center">邮件</th>
   		<th field="phone" width="100" align="center">联系电话</th>
   		<th field="roleName" width="50" align="center">角色名称</th>
   		<th field="cb" checkbox="true" align="center">选择</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 	&nbsp;用户名：&nbsp;<input type="text" id="s_userName" size="20" onkeydown="if(event.keyCode==13) findUser()"/>
 		<a href="javascript:findUser()" class="easyui-linkbutton" iconCls="icon-search" plain="true" align = "right">查询&nbsp;&nbsp;</a>
 		<a href="javascript:openUserAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加&nbsp;</a>
 		<a href="javascript:openUserModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改&nbsp;</a>
 		<a href="javascript:deleteUser()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">&nbsp;删除</a>
 	</div>
 </div>
 
  <div id="dlg" class="easyui-dialog" style="width:620px;height:250px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons"  >
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>用户名：</td>
   			<td><input type="text" id="userName" name="userName" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>密码</td>
   			<td><input type="text" id="password" name="password" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   		</tr>
   		<tr>
   			<td>真实姓名：</td>
   			<td><input type="text" id="trueName" name="trueName" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>邮箱：</td>
   			<td><input type="text" id="email" name="email" class="easyui-validatebox" validType="email" required="true"/>&nbsp;<font color="red">*</font></td>
   		</tr>
   		<tr>
   			<td>联系电话：</td>
   			<td><input type="text" id="phone" name="phone" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>用户角色</td>
   			<td>
   				<select class="easyui-combobox" id="roleName" name="roleName" style="width: 154px" editable="false" panelHeight="auto">
   					<option value="">请选择角色...</option>
   					<option value="超级管理员">超级管理员</option>
   					<!-- <option value="销售主管">销售主管</option> -->
   					<option value="客户经理">客户经理</option>
  
   				</select>
   				&nbsp;<font color="red">*</font>
   			</td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveUser()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeUserDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>
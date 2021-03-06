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
 var url;
 function searchCustomer(){
	 $("#dg").datagrid('load',{
		"khno":$("#s_khno").val(),
		"name":$("#s_name").val()
	 });
 }
 
 function openCustomerAddDialog(){
	 $("#dlg").dialog("open").dialog("setTitle","添加客户信息");
	 url="${pageContext.request.contextPath}/customer/save.do";
 }
 
 function saveCustomer(){
	 $("#fm").form("submit",{
		url:url,
		onSubmit:function(){
			if($("#area").combobox("getValue")==""){
				$.messager.alert("系统提示","请选择客户所在地区！");
				return false;
			}
			if($("#cusManager").combobox("getValue")==""){
				$.messager.alert("系统提示","请选择客户负责人！");
				return false;
			}
			if($("#level").combobox("getValue")==""){
				$.messager.alert("系统提示","请选择客户等级！");
				return false;
			}
			if($("#xyd").combobox("getValue")==""){
				$.messager.alert("系统提示","请选择客户信用度！");
				return false;
			}
			return $(this).form("validate");
		},
		success:function(result){
			var result=eval('('+result+')');
			if(result.success){
				$.messager.alert("系统提示","保存成功！");
				resetValue();
				$("#dlg").dialog("close");
				$("#dg").datagrid("reload");
			}else{
				$.messager.alert("系统提示","保存失败！");
				return;
			}
		}
	 });
 }
 
 function resetValue(){
	 $("#name").val("");
	 $("#area").combobox("setValue","");
	 $("#cusManager").combobox("setValue","");
	 $("#level").combobox("setValue","");
	 $("#xyd").combobox("setValue","");
	 $("#address").val("");
	 $("#postCode").val("");
	 $("#phone").val("");
	 $("#khzh").val("");
 }
 
 function openCustomerModifyDialog(){  
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要编辑的数据！");
		 return;
	 }
	 var row=selectedRows[0];
	 $("#dlg").dialog("open").dialog("setTitle","编辑客户信息");
	 $("#fm").form("load",row);
	 url="${pageContext.request.contextPath}/customer/save.do?id="+row.id;
 }
 
 function deleteCustomer(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length==0){
		 $.messager.alert("系统提示","请选择要删除的数据！");
		 return;
	 }
	 var strIds=[];
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].id);
	 }
	 var ids=strIds.join(",");
	 $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
		if(r){
			$.post("${pageContext.request.contextPath}/customer/delete.do",{ids:ids},function(result){
				if(result.success){
					 $.messager.alert("系统提示","数据已成功删除！");
					 $("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","数据删除失败，请联系系统管理员！");
				}
			},"json");
		} 
	 });
 }
 
 //打开查看用户账单
 function openCustomerAccount(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要查看的数据！");
		 return;
	 }
	//调用main.jsp中的openTab方法 新建一个tab
	 window.parent.openTab('历史账单查询','accountManage.jsp?cusId='+selectedRows[0].id,'icon-lsdd');
 }
 
 function closeCustomerDialog(){
	 $("#dlg").dialog("close");
	 resetValue();
 }
 
 function exportExcel() {
	 window.location.href = "${pageContext.request.contextPath}/customer/exportCustomerExcel.do";
	 $("#dg").datagrid("reload");
	 alert("已导出到桌面！！");
}
</script>
<title>Insert title here</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="客户信息管理" class="easyui-datagrid"
    pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/customer/list.do" fit="true" toolbar="#tb">
   <thead data-options="frozen:true">
		<tr>
			<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center" hidden="true">编号</th>
	 		<th field="khno" width="150" align="center">业务账号</th>
	 		<th field="name" width="200" align="center">客户名称</th>
	 		<th field="cusManager" width="100" align="center">客户负责人</th>
	 		<th field="level" width="100" align="center">客户等级</th>
	 		<th field="phone" width="100" align="center">联系方式</th>
		</tr>
	</thead>
	<thead>
		<tr>
			<th field="area" width="80" align="center">客户所在地</th>	
	 		<th field="xyd" width="80" align="center">客户信用度</th>
	 		<th field="address" width="200" align="center" >通讯地址</th>
	 		<th field="postCode" width="100" align="center" >邮政编码</th>
	 		<th field="khzh" width="100" align="center" >账务帐号</th>
	 		
		</tr>
	</thead>
 </table>
 <div id="tb">
 <div>
	<a href="javascript:openCustomerAccount()" class="easyui-linkbutton" iconCls="icon-jwjl" plain="true">历史账单查询</a>
 	</div>
 	<div>
 		&nbsp;业务账号：&nbsp;<input type="text" id="s_khno" size="20" onkeydown="if(event.keyCode==13) searchCustomer()"/>
 		&nbsp;客户名称：&nbsp;<input type="text" id="s_name" size="20" onkeydown="if(event.keyCode==13) searchCustomer()"/>
 		<a href="javascript:searchCustomer()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 		<a href="javascript:openCustomerAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">创建</a>
 		<a href="javascript:openCustomerModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
 		<a href="javascript:deleteCustomer()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
 		 <a href="javascript:exportExcel()"  class="easyui-linkbutton" iconCls="icon-ok" plain="true">导出Excel</a>
 	</div>
 </div>
  <div id="dlg" class="easyui-dialog" style="width:650px;height:300px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>&nbsp;客户名称：</td>
   			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>&nbsp;所在地区：</td>
   			<td>
   				<select class="easyui-combobox" style="width: 154px" id="area" name="area" editable="false" panelHeight="auto" >
					<option value="">请选择地区...</option>	
					<option value="江苏">江苏</option>
					<option value="北京">北京</option>	
					<option value="上海">上海</option>	
					<option value="广州">广州</option>	
					<option value="天津">天津</option>	
					<option value="重庆">重庆</option>	
					<option value="香港">香港</option>				
                </select>&nbsp;<font color="red">*</font>
   			</td>
   		</tr>
   		<tr>
   			<td>客户负责人：</td>
   			<td>
   				<input class="easyui-combobox" id="cusManager" name="cusManager" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${pageContext.request.contextPath}/user/customerManagerComboList.do'"/>&nbsp;<font color="red">*</font>
   			</td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>客户等级：</td>
   			<td>
   				<input class="easyui-combobox" id="level" name="level" data-options="panelHeight:'auto',editable:false,valueField:'dataDicValue',textField:'dataDicValue',url:'${pageContext.request.contextPath}/dataDic/dataDicComboList.do?dataDicName=客户等级'"/>&nbsp;<font color="red">*</font>
   			</td>
   		</tr>
   		<tr>
   		<td>联系方式：</td>
   			<td><input type="text" id="phone" name="phone" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>客户信用度</td>
   			<td>
   				<select class="easyui-combobox" id="xyd" name="xyd" style="width: 154px" editable="false" panelHeight="auto">
   					<option value="">请选择...</option>
   					<option value="☆">☆</option>	
					<option value="☆☆">☆☆</option>	
					<option value="☆☆☆">☆☆☆</option>	
					<option value="☆☆☆☆">☆☆☆☆</option>		
					<option value="☆☆☆☆☆">☆☆☆☆☆</option>				
                </select>&nbsp;<font color="red">*</font>
   			</td>
   		</tr>
   		<tr>
   			<td>邮政编码：</td>
   			<td><input type="text" id="postCode" name="postCode" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>开户帐号：</td>
   			<td><input type="text" id="khzh" name="khzh" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   		</tr>
   		<tr>
   			<td>客户所在地</td>
   			<td colspan="4">
   				<input type="text" id="address" name="address" style="width: 400px" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font>
   			</td>
   		</tr>  		
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveCustomer()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeCustomerDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>
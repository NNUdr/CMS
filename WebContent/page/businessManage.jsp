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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript">
function findBusiness(){
	 $("#dg").datagrid('load',{
		"customerName":$("#s_customerName").val(), 
		"state":$("#s_state").combobox("getValue")
	 });
}
 
 function formatState(val,row){
	 if(val == 1){
		 return "开通";
	 }else {
		 return "未开通";
	 }
	 
 }
 
 $(function(){
		$("#assignMan").combobox({
			onSelect:function(record){
				if(record.trueName!=''){
					$("#assignTime").val(getCurrentDateTime());
				}else{
					$("#assignTime").val("");
				}
			}
		}); 
	 });
 
 function openBusinessAddDialog(){
	 $("#dlg").dialog("open").dialog("setTitle","添加业务信息");
	 $("#createMan").val('${currentUser.trueName}');       //赋值
	 $("#createTime").val(getCurrentDateTime());
	 url="${pageContext.request.contextPath}/business/addOrUpdate.do";
 }
 
 function openBusinessModifyDialog(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要修改的数据！");
		 return;
	 }
	 var row=selectedRows[0];
	 $("#dlg").dialog("open").dialog("setTitle","修改业务信息");
	 $("#fm").form("load",row);
	 url="${pageContext.request.contextPath}/business/addOrUpdate.do?id="+row.id;
 }
 
 function saveBusiness(){
	 $("#fm").form("submit",{    //提交form
		url:url,
		onSubmit:function(){    //验证
			return $(this).form("validate");   	//调用系统验证
		},
		success:function(result){   //result是一个json串
			//alert(result);
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
 function resetValue(){
	 $("#customerName").val("");
	 $("#linkMan").val("");
	 $("#linkPhone").val("");
	 $("#overView").val("");
	 $("#description").val("");
	 $("#createMan").val("");
	 $("#createTime").val("");
	 $("#assignMan").combobox("setValue","");
	 $("#assignTime").val("");
 }
 
 function closeBusinessDialog(){
	 $("#dlg").dialog("close");
	 resetValue();
 }
 
 function deleteBusiness(){  //删除
	 var selectedRows=$("#dg").datagrid("getSelections");//获取用户的选择
	 if(selectedRows.length==0){  //没有选择任何一条
		 $.messager.alert("系统提示","请选择要删除的数据！");
		 return;
	 }
	 var strIds=[];   //获取数组  可以删除多条
	 for(var i=0;i<selectedRows.length;i++){
		 strIds.push(selectedRows[i].id);  //json  push方法 取出id
	 }
	 var ids=strIds.join(",");  //返回逗号分隔的字符串
	 //删除是危险操作 需要做验证
	 $.messager.confirm("系统提示","您确定要删除这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
		if(r){  
			//ajax 调用
			$.post("${pageContext.request.contextPath}/business/delete.do",{ids:ids},function(result){
				if(result.success){
					 $.messager.alert("系统提示","数据已成功删除！");
					 $("#dg").datagrid("reload");//重新加载
				}else{
					$.messager.alert("系统提示","数据删除失败，请联系系统管理员！");
				}
			},"json");  //指定json进行封装
		} 
	 });
 }

</script>
<title>业务管理</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="业务信息管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/business/list.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>	
   		<th field="id" width="50" align="center">编号</th>
   		<th field="yewuSource" width="50" align="center">业务来源</th>
   		<th field="customerName" width="100" align="center">客户名称</th>
   		<th field="overView" width="100" align="center">概要</th>
   		<th field="linkMan" width="50" align="center">联系人</th>
   		<th field="linkPhone" width="50" align="center" hidden = "true">联系电话</th>
   		<th field="description" width="50" align="center" hidden = "true">业务描述</th>
   		<th field="createMan" width="50" align="center">业务创建人</th>
   		<th field="createTime" width="50" align="center" >创建时间</th>
   		<th field="assignMan" width="50" align="center" hidden = "true">业务跟踪人</th>
   		<th field="assignTime" width="50" align="center" hidden = "true">指派时间</th>
   		<th field="state" width="50" align="center" formatter = "formatState" >业务状态</th>
   		<th field="cb" checkbox="true" align="center">选择</th>
   	</tr>
   </thead>
 </table>
 
  <div id="tb">
 	<div>
 	&nbsp;客户名称：&nbsp;<input type="text" id="s_customerName" size="20" onkeydown="if(event.keyCode==13) findBusiness()"/>
 	&nbsp;业务状态：&nbsp;<select class="easyui-combobox" id="s_state"  editable = "false"  panelHeight="auto">
 			<option value="">请选择...</option>
 			<option value="1">开通</option>
 			<option value="0">未开通</option>
 	</select>
 		<a href="javascript:findBusiness()" class="easyui-linkbutton" iconCls="icon-search" plain="true" >查询&nbsp;&nbsp;</a>
 		<a href="javascript:openBusinessAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">新建&nbsp;</a>
 		<a href="javascript:openBusinessModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改&nbsp;</a>
 		<a href="javascript:deleteBusiness()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">&nbsp;删除</a>
 		
 	</div>
 </div>
   
 <div id="dlg" class="easyui-dialog" style="width:660px;height:450px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>客户名称：</td>
   			<td><input type="text" id="customerName" name="customerName" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>业务来源：</td>
   			<td><input type="text" id="yewuSource" name="yewuSource"/></td>
   		</tr>
   		<tr>
   			<td>联系人：</td>
   			<td><input type="text" id="linkMan" name="linkMan" /></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>联系方式：</td>
   			<td><input type="text" id="linkPhone" name="linkPhone" class="easyui-validatebox" validType="remark" required="true"/>&nbsp;<font color="red">*</font></td>
   		</tr>
   		<tr>
   			<td>概要：</td>
   			<td colspan="4"><input type="text" id="overView" name="overView" style="width: 420px"/></td>
   		</tr>
   		<tr><td>业务描述：</td>
   		<td colspan="4">
   		<textarea rows="5" cols="60" id="description" name="description"></textarea>
   		</tr>
   		<tr>
   			<td>创建人：</td>
   			<td><input type="text" id="createMan" name="createMan" class="easyui-validatebox" required="true" readonly="readonly" />&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>创建时间：</td>
   			<td><input type="text" id="createTime" name="createTime" readonly="readonly" />&nbsp;<font color="red">*</font></td>
   		</tr>
   		<tr>
   			<td>委派给：</td>
   			<td><input class="easyui-combobox" id="assignMan" name="assignMan" data-options="panelHeight:'auto',editable:false,valueField:'trueName',textField:'trueName',url:'${pageContext.request.contextPath}/user/customerManagerComboList.do'"/></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>委派时间：</td>
   			<td><input type="text" id="assignTime" name="assignTime" readonly="readonly"/></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveBusiness()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeBusinessDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>
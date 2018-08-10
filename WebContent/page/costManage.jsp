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
 function findCost(){
	 $("#dg").datagrid('load',{
		"name":$("#s_name").val() 
	 });
 }
 function openCostAddDialog(){  //添加
	 $("#dlg").dialog("open").dialog("setTitle","添加套餐");
	 url="${pageContext.request.contextPath}/cost/addOrUpdate.do";
 }
 
 function openCostModifyDialog(){  //修改
	 var selectedRows=$("#dg").datagrid("getSelections");//获取选中行 可能是多行
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要修改的记录！");
		 return;
	 }
	 var row=selectedRows[0];
	 $("#dlg").dialog("open").dialog("setTitle","修改套餐信息");
	 $("#fm").form("load",row);  //自动加载表单数据
	 url="${pageContext.request.contextPath}/cost/addOrUpdate.do?id="+row.id;
 }
 
 function saveCost(){
	 $("#fm").form("submit",{    //提交form
		url:url,
		onSubmit:function(){    //验证
			return $(this).form("validate");   	//调用系统验证
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
	 $("#name").val("");
	 $("#time").val("");
	 $("#price").val("");
	 $("#remark").val("");
 }
 
 function closeCostDialog(){  //关闭对话框
	 $("#dlg").dialog("close");
	 resetValue();
 }
 
 function deleteCost(){  //删除
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
			$.post("${pageContext.request.contextPath}/cost/delete.do",{ids:ids},function(result){
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
 
 function noNum(obj)
 {
 obj.value = obj.value.replace(/[^\d.]/g,""); //清除“数字”和“.”以外的字符
 obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是.
 obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的.
 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");//保证.只出现一次，而不能出现两次以上 
 }

</script>
<title>资费信息管理</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="资费信息管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/cost/list.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>	
   		<th field="id" width="20" align="center">编号</th>
   		<th field="name" width="50" align="center">套餐资费名称</th>
   		<th field="time" width="50" align="center">资费时长</th>
   		<th field="price" width="50" align="center">基本费用(元)</th>
   		<th field="remark" width="50" align="center">资费说明</th>
   		<th field="cb" checkbox="true" align="center">选择</th>
   	</tr>
   </thead>
 </table>
 
  <div id="tb">
 	<div>
 	&nbsp;资费套餐名称：&nbsp;<input type="text" id="s_name" size="20" onkeydown="if(event.keyCode==13) findCost()"/>
 		<a href="javascript:findCost()" class="easyui-linkbutton" iconCls="icon-search" plain="true" align = "right">查询&nbsp;&nbsp;</a>
 		<a href="javascript:openCostAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加&nbsp;</a>
 		<a href="javascript:openCostModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改&nbsp;</a>
 		<a href="javascript:deleteCost()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">&nbsp;删除</a>
 	</div>
 </div>
   
 <div id="dlg" class="easyui-dialog" style="width:620px;height:250px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   
   <form id="fm" method="post">
   	<table cellspacing="8px">
   		<tr>
   			<td>套餐资费名称：</td>
   			<td><input type="text" id="name" name="name" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>资费基本时长：</td>
   			<td><input type="text" id="time" name="time" class="easyui-validatebox" required="true"/>&nbsp;<font color="red">*</font></td>
   		</tr>
   		<tr>
   			<td>套餐资费：</td>
   			<td><input type="text" id="price" name="price" class="easyui-numberbox" data-options="precision:'2'" required="true" onkeyup="noNum(this)" />&nbsp;<font color="red">*</font></td>
   			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
   			<td>资费说明：</td>
   			<td><input type="text" id="remark" name="remark" class="easyui-validatebox" validType="remark" required="true"/>&nbsp;<font color="red">*</font></td>
   		</tr>
   	</table>
   </form>
 </div>
 
 <div id="dlg-buttons">
 	<a href="javascript:saveCost()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeCostDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
</body>
</html>
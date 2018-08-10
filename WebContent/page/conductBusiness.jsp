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
 

 
 function searchSaleChance(){
	 $("#dg").datagrid('load',{
		"customerName":$("#s_customerName").val(), 
		"state":$("#s_state").combobox("getValue")
	 });
 }
 
 function formatState(val,row){
	 if(val==1){
		 return "开通";
	 }else{
		 return "未开通";
	 }
 }
 
 
 
 function formatAction(val,row){
	 if(row.state==0){
		 return "<a href='javascript:updateState("+row.id+",1"+")'>开通服务</a>";
	 }else{
		 return "<a href='javascript:updateState("+row.id+",0"+")'>暂停服务</a>";
	 }
 }
 
 function updateState(id,state){
	 
	 $.post("${pageContext.request.contextPath}/business/updateState.do",{id:id,state:state},function(result){
		 if(result.success){
			 $.messager.alert("系统提示","执行成功！");
			 //刷新本页面
			 window.location.href=window.location.href;
		 }else{
			 $.messager.alert("系统提示","执行失败！");
				 }
	 },"json");
 }
 
 
 

 function saveBusiness(){
	 $("#fm").form("submit",{
		url:url,
		onSubmit:function(){
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
 
 function closeBusinessDialog(){
	 $("#dlg").dialog("close");
	 resetValue();
 }
</script>
<title>Insert title here</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="办理业务" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/business/list.do?assignMan!=null" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="cb" checkbox="true" align="center"></th>
   		<th field="id" width="50" align="center">编号</th>
   		<th field="customerName" width="80" align="center">客户名称</th>
   		<th field="overView" width="150" align="center">概要</th>
   		<th field="linkMan" width="80" align="center">联系人</th>
   		<th field="createMan" width="80" align="center">创建人</th>
   		<th field="createTime" width="150" align="center">创建时间</th>
   		<th field="assignMan" width="50" align="center" >指派人</th>
   		<th field="assignTime" width="150" align="center" >指派时间</th>
   		<th field="state" width="100" align="center" formatter="formatState">状态</th>
   		<th field="a" width="100" align="center" formatter="formatAction">操作</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		&nbsp;客户名称：&nbsp;<input type="text" id="s_customerName" size="20" onkeydown="if(event.keyCode==13) searchSaleChance()"/>
 		&nbsp;业务状态：&nbsp;<select class="easyui-combobox" id="s_state" editable="false" panelHeight="auto" >
 			<option value="">请选择...</option>
 			<option value="1">开通</option>
 			<option value="0">未开通</option>					
 		         </select>
 		<a href="javascript:searchSaleChance()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 	</div>
 </div>

  <div id="dlg-buttons">
 	<a href="javascript:saveBusiness()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeBusinessDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 
</body>
</html>
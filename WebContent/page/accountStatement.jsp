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
	
 function search(){
	 $("#dg").datagrid('load',{//load方法被调用来从服务器加载新数据
		"name":$("#s_name").val() 
	 });
 }
 function exportExcel() {
	 window.location.href = "${pageContext.request.contextPath}/customer/exportExcel.do";
	 $("#dg").datagrid("reload");
	 alert("已导出到桌面！！");
}


</script>
<title>客户账单报表</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="客户账单报表" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/customer/findCustomerGx.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>
   		<th field="name" width="300" align="center">客户名称</th>
   		<th field="totalCost" width="100" align="center">订单总金额(元)</th>
   	</tr>
   </thead>
 </table>
 <div id="tb">
 	<div>
 		&nbsp;客户名称：&nbsp;<input type="text" id="s_name" size="20" onkeydown="if(event.keyCode==13) search()"/>
 		<a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 	  <a href="javascript:exportExcel()"  class="easyui-linkbutton" iconCls="icon-ok" plain="true">导出Excel</a> 
 	</div>
 </div>
 
</body>
</html>
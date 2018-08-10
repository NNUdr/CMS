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
function findNote(){
	 $("#dg").datagrid('load',{
		"noteTitle":$("#s_noteTitle").val()
	 });
}
 
 
 function openNoteAddDialog(){
	 $("#dlg").dialog("open").dialog("setTitle","发布公告");
	 $("#noteCreateTime").val(getCurrentDateTime());
	 url="${pageContext.request.contextPath}/note/addOrUpdate.do";
 }
 
 function openNoteModifyDialog(){
	 var selectedRows=$("#dg").datagrid("getSelections");
	 if(selectedRows.length!=1){
		 $.messager.alert("系统提示","请选择一条要修改的公告！");
		 return;
	 }
	 var row=selectedRows[0];
	 $("#dlg").dialog("open").dialog("setTitle","修改公告");
	 $("#fm").form("load",row);
	 url="${pageContext.request.contextPath}/note/addOrUpdate.do?id="+row.id;
 }
 
 function saveNote(){
	 $("#fm").form("submit",{
		url:url,
		onSubmit:function(){
			return $(this).form("validate");
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
 function resetValue(){
	 $("#noteTitle").val("");
	 $("#noteCreateTime").val("");
	 $("#noteInfo").val("");
 }
 
 function closeNoteDialog(){
	 $("#dlg").dialog("close");
	 resetValue();
 }
 
 function deleteNote(){  //删除
	 var selectedRows=$("#dg").datagrid("getSelections");//获取用户的选择
	 if(selectedRows.length==0){  //没有选择任何一条
		 $.messager.alert("系统提示","请选择要删除的公告！");
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
			$.post("${pageContext.request.contextPath}/note/delete.do",{ids:ids},function(result){
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
 
 function formatAction(val,row){
	 return "<a href='javascript:openNoteDetailDialog("+row.id+")'>查看公告详细内容</a>"
 }
 function openNoteDetailDialog(noteId){       //ajax请求
		 $.post("${pageContext.request.contextPath}/note/findById.do",{noteId:noteId},function(result){
		 $("#fm").form('load',result);	
		 $("#noteTitle").val(result.noteTitle);
		 $("#noteCreateTime").val(fmtDate(result.noteCreateTime.time));
		 $("#noteInfo").val(result.noteInfo);
		
	 },"json");
	 $("#dlg").dialog("open").dialog("setTitle","公告明细");
	 
 }
 
 function fmtDate(obj){
	    var date =  new Date(obj);
	    var y = 1900+date.getYear();
	    var m = "0"+(date.getMonth()+1);
	    var d = "0"+date.getDate();
	    var h = " "+date.getHours();
	    var s = " "+date.getMinutes();
	    return y+"-"+m.substring(m.length-2,m.length)+"-"+d.substring(d.length-2,d.length)+" "+h.substring(h.lenth-2,h.lenth)+" :"+s.substring(s.lenth-2,s.lenth);
	}

</script>
<title>公告管理</title>
</head>
<body style="margin: 1px">
 <table id="dg" title="公告管理" class="easyui-datagrid"
   fitColumns="true" pagination="true" rownumbers="true"
   url="${pageContext.request.contextPath}/note/list.do" fit="true" toolbar="#tb">
   <thead>
   	<tr>	
   		<th field="cb" checkbox="true" align="center">选择</th>
   		<th field="noteTitle" width="100" align="center">公告标题</th>
   		<th field="noteInfo" width="180" align="center">内容简介</th>
   		<th field="noteCreateTime" width="60" align="center" >发布时间</th>
   		
   		<th field="a" width="50" align="center" formatter="formatAction">操作</th>
   		
   	</tr>
   </thead>
 </table>
 
  <div id="tb">
 	<div>
 	&nbsp;公告标题：&nbsp;<input type="text" id="s_noteTitle" size="20" onkeydown="if(event.keyCode==13) findNote()"/>
 	
 	</select>
 		<a href="javascript:findNote()" class="easyui-linkbutton" iconCls="icon-search" plain="true" >查询&nbsp;&nbsp;</a>
 		<a href="javascript:openNoteAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">发布公告&nbsp;</a>
 		<a href="javascript:openNoteModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改公告&nbsp;</a>
 		<a href="javascript:deleteNote()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">&nbsp;删除公告</a>
 	</div>
 </div>
   
 <div id="dlg" class="easyui-dialog" style="width:620px;height:450px;padding: 10px 20px"
   closed="true" buttons="#dlg-buttons">
   <form id="fm" method="post">
   	<table cellspacing="8px">	
   		<tr>
   			<td>公告标题：</td>
   			<td colspan="3"><input type="text" id="noteTitle" name="noteTitle" style="width: 420px"/></td>
   		</tr>
  		<tr>
  		<td>发布时间:</td>
  		<td colspan="3"><input type="text" id="noteCreateTime" name="noteCreateTime" readonly="readonly"/></td>
  		</tr>
   		<tr><td>公告内容：</td>
   		<td colspan="3">
   		<textarea rows="12" cols="50" id="noteInfo" name="noteInfo"></textarea>
   		</tr>
   	</table>
   </form>
 </div>
 
 
 
 <div id="dlg-buttons">
 	<a href="javascript:saveNote()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
 	<a href="javascript:closeNoteDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
 </div>
 
</body>
</html>
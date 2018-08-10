<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
<title>Insert title here</title>
</head>
<body>
<div class="easyui-panel" title="Upload File" style="width:500px;height:200px;padding:30px 70px 50px 70px">
	<form enctype="multipart/form-data" action="/usts_dr/upload.do" method="post">
		<tr><td><input name="file" type="file" class="easyui-filebox"  style="width:100%"></td></tr>
		<br><br>
		<tr><td>
		<input type="submit" value="Upload" class="easyui-linkbutton" style="width:50%" /></td></tr>
	</form>
	</div>
	 
	
	<div class="easyui-panel" title="Download File" style="width:500px;height:300px;padding:30px 70px 50px 70px">
	<table  border="1">
	<tr>
	<th>文件名</th>
	<th>上传人</th>
	</tr>
		<c:forEach items="${files}" var="item">
	<tr>
	<td>
	<a href="/usts_dr/download.do?file=${item }"><font size="2" color="red">${item }下载</font></a>
		</td>
		<td>
		${currentUser.trueName}
		</td>
	</tr>
		</c:forEach>
	</table>
		</div>
	
</body>
</html>
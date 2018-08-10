<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基于SSM框架技术的后台管理系统</title>
<link rel="stylesheet" type="text/css" href="css/less.css">
<link rel="stylesheet" type="text/css" href="css/basic.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript">
	function login(){
		var userName=$("#userName").val();
		var password=$("#password").val();
		var roleName=$("#roleName").val();
		if(userName==null||userName==""){
			alert("用户名不能为空！");
			return;
		}
		if(password==null||password==""){
			alert("密码不能为空！");
			return;
		}
		if(roleName==null||roleName==""){
			alert("请选择用户类型！");
			return;
		}
		$("#adminlogin").submit();			
		
	}
</script>
<script type=text/javascript>
	if('${errorMsg}'!=''){
		alert('${errorMsg}');
	}
</script>
</head>
<body>
<form id=adminlogin  method=post
	name=adminlogin action="${pageContext.request.contextPath}/user/login.do"  >

  <div class="login-top">
  <div style="height: 60px;background-color: white;">
	<div style=";margin-left: 160px;">
	</div>
  </div>
    <div class="login-topBg">
      <div class="login-topBg1">
        
        <div class="login-topStyle" >
          
         
          <div class="login-topStyle3" id="loginStyle" style="margin-top: 75px;">
            <h3 align="center">管理登录</h3>
           
            <div class="ui-form-item loginUsername">
              <input type="text"  style="width:230px;height:32px" value="${user.userName }" name="userName" id="userName" placeholder="用户名">
            </div>
            <div class="ui-form-item loginPassword">
              <input  type="password" value="${user.password }" name="password" id="password" placeholder="请输入密码" style="width:227px;height:20px">
             
            </div>
     
            <div class="login_reme">
              <select id="roleName" name="roleName" style="width: 235px;height: 35px">
								<option value="">请选择角色类型...</option>
								<option value="超级管理员"  ${'超级管理员'==user.roleName?'selected':'' }>超级管理员</option>
								<%-- <option value="销售主管"  ${'销售主管'==user.roleName?'selected':'' }>销售主管</option> --%>
								<option value="客户经理"  ${'客户经理'==user.roleName?'selected':'' }>客户经理</option>
								</select>
               </div>
          <!-- return flase 输入错误不提交到服务器端 -->
             <a class="btnStyle btn-register" onclick="javascript:login();return false;"> 立即登录</a> </div>
        </div>
      </div>
    </div>
  </div></form>
  
  
  <div class="loginCen" style="margin-top: 55px;">
    <div class="login-center">
      <div class="loginCenter-moudle">
        <div class="loginCenter-moudleLeft" style="margin-right: 60px;"> &nbsp;</div>
        <div class="loginCenter-moudleRight" style="  width: 1067px;"> 
          <!--第一个--> 
          <a class="loginCenter-mStyle loginCenter-moudle1" id="moudleRemove" style=" display:block;width: 340px;">
           <span class="moudle-img"><img src="images/login_bg_01.png"></span>
            <span class="moudle-text"> 
            <span class="moudle-text1" style="font-family:'微软雅黑'">省时    ·   便捷     ·   高效 
</span> 
            <span class="moudle-text2" style="font-family:'微软雅黑'">Timesaving  ·  Convenient  ·  Efficient</span> 
            </span>
             </a> 
           <!--第二个--> 
          <a class="loginCenter-mStyle loginCenter-moudle2" style=" display:block; width: 357px;" id="moudleRemove2" > 
          <span class="moudle-img"><img src="images/login_bg_02.png"></span> 
           <span class="moudle-text">
            <span class="moudle-text1" style="font-family:'微软雅黑'"> 云计算  · 大数据  · 分布式  
</span>
            <span class="moudle-text2" style="font-family:'微软雅黑'">Cloud · computing · Big data · Distributed</span> 
           </span>
             </a> 
            <!--第三个--> 
                 <a class="loginCenter-mStyle loginCenter-moudle3" style=" display:block;" id="moudleRemove3" > 
                 <span class="moudle-img"><img src="images/login_bg_03.png"></span> 
                   <span class="moudle-text"> 
                 <span class="moudle-text"> <span class="moudle-text1" style="font-family:'微软雅黑'">管理简单而不简约
</span>
                  <span class="moudle-text2" style="font-family:'微软雅黑'">Simple management</span>
            </span>
            </span>
                    </a> 
         
             </div>
      </div>
    </div>
  </div>
</body>
</html>

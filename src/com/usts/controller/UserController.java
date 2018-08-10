package com.usts.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.usts.entity.User;
import com.usts.service.UserService;
import com.usts.utils.PageBean;
import com.usts.utils.ResponseUtil;
import com.usts.utils.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//用户controller层

@Controller
@RequestMapping("/user")
public class UserController {
	@Resource
	private UserService userService;
	
	@RequestMapping("/login")
	public String login(User user,HttpServletRequest request)throws Exception{
		User result = userService.login(user);
		if(result == null) {  //查找的结果为null 即未查到
			request.setAttribute("user", user); //回显用户输入
			request.setAttribute("errorMsg", "用户名或者密码输入错误！");
			return "login";    //后缀已经配置为.jsp
		}else {
			//把当前用户信息放入session
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", result);
			if(result.getRoleName().equals("超级管理员")) {
			return "redirect:/main.jsp";   //重定向到主页
			}else {
				return "redirect:/main1.jsp";	
			}
		}
	}
	//修改密码
	@RequestMapping("/modifyPassword")
	public String modifyPassword(Integer id,String newPassword,HttpServletResponse response)throws Exception{
		User user=new User();
		user.setId(id);
		user.setPassword(newPassword);
		int resultTotal=userService.update(user);
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	//退出登录
	@RequestMapping("/logout")
	public String logout(HttpSession session)throws Exception{
		session.invalidate();  //注销session
		return "redirect:/login.jsp";  //重定向到登录页面
	}
	
		//分页查询
	@RequestMapping("/list")
	public String list(@RequestParam(value = "page",required = false)String page,@RequestParam(value = "rows",required = false)String rows,User s_user,HttpServletResponse response)throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows)); //page为start rows为size
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("userName", StringUtil.formatLike(s_user.getUserName()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<User> userList = userService.find(map);
		Long totalNum = userService.getTotal(map); //总记录数
		JSONObject result = new JSONObject();
		//JavaBean转JSON
		JSONArray jsonArray = JSONArray.fromObject(userList);
		result.put("rows", jsonArray);
		result.put("total", totalNum);
		ResponseUtil.write(response, result); //
		return null;
	}
	
	//添加或者更新角色信息
	@RequestMapping("/addOrUpdate")
	public  String addOrUpdate(User user,HttpServletResponse response)throws Exception{
		int resultNum = 0; // 操作的记录个数
		if(user.getId()==null) {
			resultNum = userService.add(user);
		}else {
			resultNum = userService.update(user);
		}
		JSONObject  result = new JSONObject();
		if(resultNum > 0) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	//删除角色信息
	@RequestMapping("/delete")
	public String delete(@RequestParam(value = "ids")String ids,HttpServletResponse response)throws Exception{
		String [] deleteids = ids.split(",");
		for(int i = 0;i < deleteids.length;i++) {
			userService.delete(Integer.parseInt(deleteids[i]));
		}
		//创建JSON对象
		JSONObject  result = new JSONObject();
		//将结果放入JSON
		result.put("success", true);
		//返回
		ResponseUtil.write(response, result);
		return null;
	}
	//获取客户经理信息
	@RequestMapping("/customerManagerComboList")
	public String customerManagerComboList(HttpServletResponse response)throws Exception{
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("roleName", "客户经理");
		List<User> userList=userService.find(map);
		JSONArray row=JSONArray.fromObject(userList); //把值封装到JSONArray里
		ResponseUtil.write(response, row);
		return null;
	}
}

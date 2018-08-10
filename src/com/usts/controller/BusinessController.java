package com.usts.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.usts.entity.Business;
import com.usts.service.BusinessService;
import com.usts.utils.DateJsonValueProcessor;
import com.usts.utils.PageBean;
import com.usts.utils.ResponseUtil;
import com.usts.utils.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

//业务controller层

@Controller
@RequestMapping("/business")
public class BusinessController {
	@Resource
	private BusinessService businessService;
	//日期格式的绑定   经过springmvc  将日期格式转换为字符串
	 @InitBinder
	 public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		// 设置lenient为false. 否则SimpleDateFormat会比较宽松地验证日期，比如2018/02/29会被接受，并转换成2018/03/01
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
	}
		//分页查询
	@RequestMapping("/list")
	public String list(@RequestParam(value = "page",required = false)String page,@RequestParam(value = "rows",required = false)String rows,Business s_business,HttpServletResponse response)throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows)); //page为start rows为size
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("customerName", StringUtil.formatLike(s_business.getCustomerName()));
		map.put("state", s_business.getState());
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Business> businessList = businessService.find(map);
		Long totalNum = businessService.getTotal(map); //总记录数
		JSONObject result = new JSONObject();
		//日期类型过滤转换成字符串  JsonConfig将date转换器注册进去
		JsonConfig jsconfig = new JsonConfig();
		jsconfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm"));
		JSONArray jsonArray = JSONArray.fromObject(businessList,jsconfig);
		result.put("rows", jsonArray);
		result.put("total", totalNum);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/addOrUpdate")
	public  String addOrUpdate(Business business,HttpServletResponse response)throws Exception{
		int resultNum = 0; // 操作的记录个数
		if(business.getId()==null) {
			business.setState(0);   //添加业务时 默认是注销状态
			resultNum = businessService.add(business);
		}else {
			resultNum = businessService.update(business);
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
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value = "ids")String ids,HttpServletResponse response)throws Exception{
		String [] deleteids = ids.split(",");
		//遍历 进行批量删除
		for(int i = 0;i < deleteids.length;i++) {
			businessService.delete(Integer.parseInt(deleteids[i]));
		}
		JSONObject  result = new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/updateState")
	public String updateState(@RequestParam(value="id")String id,@RequestParam(value="state")String state,HttpServletResponse response)throws Exception{
		Business business=new Business();
		business.setId(Integer.parseInt(id));
		business.setState(Integer.parseInt(state));
		int resultTotal=businessService.update(business);
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
}

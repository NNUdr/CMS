package com.usts.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.usts.entity.Account;
import com.usts.service.AccountService;
import com.usts.utils.DateJsonValueProcessor;
import com.usts.utils.PageBean;
import com.usts.utils.ResponseUtil;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/account")
public class AccountController {
		
		@Resource
		private AccountService accountService;
		 // 分页条件查询账单
		@RequestMapping("/list")
		public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,@RequestParam(value="cusId",required=false)String cusId,HttpServletResponse response)throws Exception{
			PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("cusId", cusId);
			map.put("start", pageBean.getStart());
			map.put("size", pageBean.getPageSize());
			List<Account> accountList=accountService.find(map);
			JsonConfig jsonConfig=new JsonConfig();
			jsonConfig.setExcludes(new String[]{"account"});
			jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
			JSONObject result=new JSONObject();
			Long total=accountService.getTotal(map);
			JSONArray jsonArray=JSONArray.fromObject(accountList,jsonConfig);
			result.put("rows", jsonArray);
			result.put("total", total);
			ResponseUtil.write(response, result);
			return null;
		}
		
		@RequestMapping("/findById")
		public String findById(@RequestParam(value="id")String id,HttpServletResponse response)throws Exception{
			Account account = accountService.findById(Integer.parseInt(id));
			JsonConfig jsonConfig=new JsonConfig();
			jsonConfig.setExcludes(new String[]{"account"});
			jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
			JSONObject jsonObject=JSONObject.fromObject(account,jsonConfig);
			ResponseUtil.write(response, jsonObject);
			return null;
		}
}

package com.usts.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.usts.entity.AccountDetail;
import com.usts.service.AccountDetailService;
import com.usts.utils.PageBean;
import com.usts.utils.ResponseUtil;
import com.usts.utils.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/accountDetail")
public class AccountDetailController {
		
	@Resource
	private AccountDetailService accountDetailService;
	
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,@RequestParam(value="accountId",required=false)String accountId,HttpServletResponse response)throws Exception{
		if(StringUtil.isEmpty(accountId)){
			return null;
		}
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("accountId", accountId);
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<AccountDetail> accountDetailList=accountDetailService.find(map);
		Long total=accountDetailService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(accountDetailList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	

	@RequestMapping("/getTotalPrice")   //获取总金额
	public String getTotalPrice(String accountId,HttpServletResponse response)throws Exception{
		double totalMoney=accountDetailService.getTotalSumByAccountId(Integer.parseInt(accountId));
		JSONObject result=new JSONObject();
		result.put("totalMoney", totalMoney);
		ResponseUtil.write(response, result);
		return null;
	}
}

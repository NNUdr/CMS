package com.usts.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.usts.entity.AccountStatement;
import com.usts.entity.Customer;
import com.usts.entity.CustomerGc;
import com.usts.service.CustomerService;
import com.usts.utils.DateUtil;
import com.usts.utils.PageBean;
import com.usts.utils.ResponseUtil;
import com.usts.utils.StringUtil;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//客户信息controller层
@Controller
@RequestMapping("/customer")
public class CustomerController {
	@Resource
	private CustomerService customerService;
	
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,Customer s_customer,HttpServletResponse response)throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("khno", StringUtil.formatLike(s_customer.getKhno()));
		map.put("name", StringUtil.formatLike(s_customer.getName()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Customer> customerList=customerService.find(map);
		Long total=customerService.getTotal(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(customerList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	@RequestMapping("/save")
	public String save(Customer customer,HttpServletResponse response)throws Exception{
		int resultTotal=0; // 操作的记录条数
		if(customer.getId()==null){
			customer.setKhno("YeWu"+DateUtil.getCurrentDateStr()); // 动态生成业务账号
			resultTotal=customerService.add(customer);
		}else{
			resultTotal=customerService.update(customer);
		}
		JSONObject result=new JSONObject();
		if(resultTotal>0){
			result.put("success", true);
		}else{
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value = "ids")String ids,HttpServletResponse response)throws Exception{
		String [] deleteids = ids.split(",");
		for(int i = 0;i < deleteids.length;i++) {
			customerService.delete(Integer.parseInt(deleteids[i]));
		}
		JSONObject  result = new JSONObject();
		result.put("success", true);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/findById")
	public String findById(@RequestParam(value="id")String id,HttpServletResponse response)throws Exception{
		Customer customer=customerService.findById(Integer.parseInt(id));
		JSONObject jsonObject=JSONObject.fromObject(customer);
		ResponseUtil.write(response, jsonObject);
		return null;
	}
	
	//客户消费金额报表
	@RequestMapping("/findCustomerGx") 
	public String findCustomerGx(@RequestParam(value="page",required=false)String page,@RequestParam(value="rows",required=false)String rows,String name,HttpServletResponse response)throws Exception{
		PageBean pageBean=new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("name", StringUtil.formatLike(name));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<AccountStatement> customerGxList=customerService.findCustomerGx(map);
		Long total=customerService.getTotalCost(map);
		JSONObject result=new JSONObject();
		JSONArray jsonArray=JSONArray.fromObject(customerGxList);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	//客户构成报表
	@RequestMapping("/findCustomerGc")
	public String findCustomerGc(HttpServletResponse response)throws Exception{
		List<CustomerGc> customerGcList=customerService.findCustomerGc();
		JSONArray jsonArray=JSONArray.fromObject(customerGcList);
		ResponseUtil.write(response, jsonArray);
		return null;
	}
	
	
	 @RequestMapping("/exportExcel")
	    public void export(HttpServletResponse response){    
	        response.setContentType("application/binary;charset=UTF-8");
	        try{
	            ServletOutputStream out=response.getOutputStream();
//	            String fileName=new String(("CustomerTotalCost "+ new SimpleDateFormat("yyyy-MM-dd").format(new Date())).getBytes(),"UTF-8");
//	            response.setHeader("Content-disposition", "attachment; filename=" + fileName + ".xls");
	            String[] titles = { "客户名称", "消费总金额" }; 
	            customerService.export(titles, out);
	           
	        } catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	 
	 @RequestMapping("/exportCustomerExcel")
	    public void exportCustomerExcel(HttpServletResponse response){    
	        response.setContentType("application/binary;charset=UTF-8");
	        try{
	            ServletOutputStream out=response.getOutputStream();
	            String[] titles = { "业务账号", "客户名称","客户所在地区", "客户负责人","客户等级", "客户信用度", "客户地址","邮箱", "客户联系方式","开户账号" }; 
	            customerService.exportCustomerExcel(titles, out);
	           
	        } catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	
}

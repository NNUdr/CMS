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

import com.usts.entity.Cost;
import com.usts.service.CostService;
import com.usts.utils.PageBean;
import com.usts.utils.ResponseUtil;
import com.usts.utils.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

//套餐资费controller层

@Controller
@RequestMapping("/cost")
public class CostController {
	@Resource
	private CostService costService;
	
		//分页查询
	@RequestMapping("/list")
	public String list(@RequestParam(value = "page",required = false)String page,@RequestParam(value = "rows",required = false)String rows,Cost s_cost,HttpServletResponse response)throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows)); //page为start rows为size
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("name", StringUtil.formatLike(s_cost.getName()));
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Cost> costList = costService.find(map);
		Long totalNum = costService.getTotal(map); //总记录数
		JSONObject result = new JSONObject();
		JSONArray jsonArray = JSONArray.fromObject(costList);
		result.put("rows", jsonArray);
		result.put("total", totalNum);
		ResponseUtil.write(response, result);
		return null;
	}
	
	//添加或者更新套餐资费信息
		@RequestMapping("/addOrUpdate")
		public  String addOrUpdate(Cost cost,HttpServletResponse response)throws Exception{
			int resultNum = 0; // 操作的记录个数
			if(cost.getId()==null) {
				resultNum = costService.add(cost);
			}else {
				resultNum = costService.update(cost);
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
		
		//删除资费信息
		@RequestMapping("/delete")
		public String delete(@RequestParam(value = "ids")String ids,HttpServletResponse response)throws Exception{
			String [] deleteids = ids.split(",");
			for(int i = 0;i < deleteids.length;i++) {
				costService.delete(Integer.parseInt(deleteids[i]));
			}
			JSONObject  result = new JSONObject();
			result.put("success", true);
			ResponseUtil.write(response, result);
			return null;
		}
	
	
}

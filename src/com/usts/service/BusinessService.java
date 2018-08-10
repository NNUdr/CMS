package com.usts.service;

import java.util.List;
import java.util.Map;

import com.usts.entity.Business;


public interface BusinessService {
	//查询业务集合
		public List<Business> find(Map<String,Object> map);
		//查询所有记录
		public Long getTotal(Map<String,Object> map);
		//增加业务
		public int add(Business business);
		//修改业务
		public int update(Business business);
		//删除业务
		public int delete(Integer id);
	
}

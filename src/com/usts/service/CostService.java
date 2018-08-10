package com.usts.service;

import java.util.List;
import java.util.Map;
import com.usts.entity.Cost;


public interface CostService {
	//查询资费信息集合
	public List<Cost> find(Map<String,Object> map);
	//查询所有记录
	public Long getTotal(Map<String,Object> map);
	//添加
	public  int add(Cost cost);
	//修改资费信息
	public int update(Cost cost);
	//删除资费信息
	public int delete(Integer id);
}

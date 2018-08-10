package com.usts.dao;

import java.util.List;
import java.util.Map;
import com.usts.entity.DataDic;

//用户DAO接口
public interface DataDicDao {
	
	//查询字典集合
	public List<DataDic> find(Map<String,Object> map);
	//查询所有记录
	public Long getTotal(Map<String,Object> map);
	//查询集合名称
	public List<DataDic>findAll();
	//添加
	public  int add(DataDic dataDic);
	//修改
	public int update(DataDic dataDic);
	//删除
	public int delete(Integer id);
}

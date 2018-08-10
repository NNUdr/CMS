package com.usts.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import com.usts.entity.AccountStatement;
import com.usts.entity.Customer;
import com.usts.entity.CustomerGc;

//客户信息dao接口
public interface CustomerDao {
	//查询资费信息集合
	public List<Customer> find(Map<String,Object> map);
	//查询所有记录
	public Long getTotal(Map<String,Object> map);
	//添加
	public  int add(Customer customer);
	//修改
	public int update(Customer customer);
	//删除
	public int delete(Integer id);
	//通过id查找实体
	public Customer findById(Integer id);
	//查询客户消费金额
	public List<AccountStatement> findCustomerGx(Map<String,Object> map);
	//查询总金额
	public Long getTotalCost(Map<String,Object> map);
	//客户构成报表
	public List<CustomerGc> findCustomerGc();
	//导出客户消费Excel
	public void export(String[] titles, ServletOutputStream out);
	//导出客户信息Excel
	public void exportCustomerExcel(String[] titles, ServletOutputStream out);
}

package com.usts.service;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;

import com.usts.entity.AccountStatement;
import com.usts.entity.Customer;
import com.usts.entity.CustomerGc;

public interface CustomerService {
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
		//导出Excel
		public void export(String[] titles, ServletOutputStream out);
		public void exportCustomerExcel(String[] titles, ServletOutputStream out);
}

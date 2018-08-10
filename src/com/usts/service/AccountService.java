package com.usts.service;

import java.util.List;
import java.util.Map;

import com.usts.entity.Account;

public interface AccountService {
	public List<Account> find(Map<String,Object> map);
	public Long getTotal(Map<String,Object> map);
	//通过id查找实体
	public Account findById(Integer id);
}

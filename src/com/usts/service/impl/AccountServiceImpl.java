package com.usts.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.usts.dao.AccountDao;
import com.usts.entity.Account;
import com.usts.service.AccountService;

@Service("accountService")
public class AccountServiceImpl implements AccountService{
	@Resource
	private AccountDao accountDao;

	@Override
	public List<Account> find(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return accountDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return accountDao.getTotal(map);
	}

	@Override
	public Account findById(Integer id) {
		// TODO Auto-generated method stub
		return accountDao.findById(id);
	}

}

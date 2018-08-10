package com.usts.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.usts.dao.AccountDetailDao;
import com.usts.entity.AccountDetail;
import com.usts.service.AccountDetailService;

@Service("accountDetailService")
public class AccountDetailServiceImpl implements AccountDetailService{
	@Resource
	private AccountDetailDao accountDetailDao;

	@Override
	public List<AccountDetail> find(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return accountDetailDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return accountDetailDao.getTotal(map);
	}

	@Override
	public double getTotalSumByAccountId(Integer accountId) {
		// TODO Auto-generated method stub
		return accountDetailDao.getTotalSumByAccountId(accountId);
	}

	
}

package com.usts.dao;

import java.util.List;
import java.util.Map;

import com.usts.entity.Account;
import com.usts.entity.AccountDetail;

public interface AccountDetailDao {
	public List<AccountDetail> find(Map<String,Object> map);
	public Long getTotal(Map<String,Object> map);
		//获取订单总金额
	public double getTotalSumByAccountId(Integer accountId);
}

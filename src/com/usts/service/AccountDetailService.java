package com.usts.service;

import java.util.List;
import java.util.Map;

import com.usts.entity.Account;
import com.usts.entity.AccountDetail;

public interface AccountDetailService {
	public List<AccountDetail> find(Map<String,Object> map);
	public Long getTotal(Map<String,Object> map);
	//获取订单总金额
	public double getTotalSumByAccountId(Integer accountId);
}

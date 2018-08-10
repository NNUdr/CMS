package com.usts.service.impl;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.usts.dao.BusinessDao;
import com.usts.entity.Business;
import com.usts.service.BusinessService;

//service实现类
@Service("businessService")
public class BusinessServiceImpl implements BusinessService {
	@Resource
	private BusinessDao businessDao;

	@Override
	public List<Business> find(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return businessDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return businessDao.getTotal(map);
	}

	@Override
	public int add(Business business) {
		// TODO Auto-generated method stub
		return businessDao.add(business);
	}

	@Override
	public int update(Business business) {
		// TODO Auto-generated method stub
		return businessDao.update(business);
	}

	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return businessDao.delete(id);
	}

	
	
	
}

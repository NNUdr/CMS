package com.usts.service.impl;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.usts.dao.CostDao;
import com.usts.entity.Cost;
import com.usts.service.CostService;

//service实现类
@Service("costService")
public class CostServiceImpl implements CostService {
	@Resource
	private CostDao costDao;
	@Override
	public List<Cost> find(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return costDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return costDao.getTotal(map);
	}

	@Override
	public int add(Cost cost) {
		// TODO Auto-generated method stub
		return costDao.add(cost);
	}

	@Override
	public int update(Cost cost) {
		// TODO Auto-generated method stub
		return costDao.update(cost);
	}

	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return costDao.delete(id);
	}
	
	
}

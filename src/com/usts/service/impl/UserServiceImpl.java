package com.usts.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.usts.dao.UserDao;
import com.usts.entity.User;
import com.usts.service.UserService;

//service实现类   使用注解来暴露和引入相关的Service和DAO对应的BEAN

@Service("userService")
public class UserServiceImpl implements UserService {
	//注入Dao
	@Resource   //安装名称装配
	private UserDao userDao;

	@Override
	public User login(User user) {
		// TODO Auto-generated method stub
		return userDao.login(user);
	}

	@Override
	public List<User> find(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.getTotal(map);
	}

	@Override
	public int add(User user) {
		// TODO Auto-generated method stub
		return userDao.add(user);
	}

	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		return userDao.update(user);
	}

	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return userDao.delete(id);
	} 
}

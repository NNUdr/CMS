package com.usts.service;

import java.util.List;
import java.util.Map;

import com.usts.entity.User;

public interface UserService {
	//登录
	public User login(User user);
	//查询用户
	public List<User> find(Map<String,Object> map);
	//查询所有记录
	public Long getTotal(Map<String,Object> map);
	//添加用户角色信息
	public  int add(User user);
	//修改用户角色信息
	public int update(User user);
	//删除角色信息
	public int delete(Integer id);
}

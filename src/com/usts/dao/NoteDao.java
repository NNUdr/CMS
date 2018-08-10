package com.usts.dao;

import java.util.List;
import java.util.Map;

import com.usts.entity.Account;
import com.usts.entity.Note;

//业务管理Dao
public interface NoteDao {
	//查询公告集合
	public List<Note> find(Map<String,Object> map);
	//查询所有记录
	public Long getTotal(Map<String,Object> map);
	//添加公告
	public int add(Note note);
	//修改公告内容
	public int update(Note note);
	//删除公告
	public int delete(Integer id);
	//通过id查找实体
	public Note findById(Integer id);
}

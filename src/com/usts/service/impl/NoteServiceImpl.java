package com.usts.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.usts.dao.NoteDao;
import com.usts.entity.Note;
import com.usts.service.NoteService;

@Service("noteService")
public class NoteServiceImpl implements NoteService {
	
	@Resource
	private NoteDao noteDao;
	
	@Override
	public List<Note> find(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return noteDao.find(map);
	}

	@Override
	public Long getTotal(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return noteDao.getTotal(map);
	}

	@Override
	public int add(Note note) {
		// TODO Auto-generated method stub
		return noteDao.add(note);
	}

	@Override
	public int update(Note note) {
		// TODO Auto-generated method stub
		return noteDao.update(note);
	}

	@Override
	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return noteDao.delete(id);
	}

	@Override
	public Note findById(Integer id) {
		// TODO Auto-generated method stub
		return noteDao.findById(id);
	}

}

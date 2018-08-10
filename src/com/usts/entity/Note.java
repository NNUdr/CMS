package com.usts.entity;

import java.util.Date;

//公告实体类
public class Note {
	private Integer id;//公告编号
	private String noteTitle;//公告标题
	private Date noteCreateTime; //公告发布时间
	private String noteInfo; //公告内容
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getNoteTitle() {
		return noteTitle;
	}
	public void setNoteTitle(String noteTitle) {
		this.noteTitle = noteTitle;
	}
	public Date getNoteCreateTime() {
		return noteCreateTime;
	}
	public void setNoteCreateTime(Date noteCreateTime) {
		this.noteCreateTime = noteCreateTime;
	}
	public String getNoteInfo() {
		return noteInfo;
	}
	public void setNoteInfo(String noteInfo) {
		this.noteInfo = noteInfo;
	}
	
}

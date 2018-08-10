package com.usts.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.usts.entity.Note;
import com.usts.service.NoteService;
import com.usts.utils.DateJsonValueProcessor;
import com.usts.utils.PageBean;
import com.usts.utils.ResponseUtil;
import com.usts.utils.StringUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/note")
public class NoteController {
	@Resource
	private NoteService noteService;
	
	//日期格式的绑定   经过springmvc  将日期格式转换为字符串
		 @InitBinder
		 public void initBinder(WebDataBinder binder) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			dateFormat.setLenient(false);
			binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
		}
		 
			//分页查询
			@RequestMapping("/list")
			public String list(@RequestParam(value = "page",required = false)String page,@RequestParam(value = "rows",required = false)String rows,Note s_note,HttpServletResponse response)throws Exception{
				PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows)); //page为start rows为size
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("noteTitle", StringUtil.formatLike(s_note.getNoteTitle()));
				map.put("start", pageBean.getStart());
				map.put("size", pageBean.getPageSize());
				List<Note> noteList = noteService.find(map);
				Long totalNum = noteService.getTotal(map); //总记录数
				JSONObject result = new JSONObject();
				//日期类型过滤转换成字符串
				JsonConfig jsconfig = new JsonConfig();
				jsconfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm"));
				JSONArray jsonArray = JSONArray.fromObject(noteList,jsconfig);
				result.put("rows", jsonArray);
				result.put("total", totalNum);
				ResponseUtil.write(response, result);
				return null;
			}
			
			@RequestMapping("/addOrUpdate")
			public  String addOrUpdate(Note note,HttpServletResponse response)throws Exception{
				int resultNum = 0; // 操作的记录个数
				if(note.getId()==null) {
					resultNum = noteService.add(note);
				}else {
					resultNum = noteService.update(note);
				}
				JSONObject  result = new JSONObject();
				if(resultNum > 0) {
					result.put("success", true);
				}else {
					result.put("success", false);
				}
				ResponseUtil.write(response, result);
				return null;
			}
			
			@RequestMapping("/delete")
			public String delete(@RequestParam(value = "ids")String ids,HttpServletResponse response)throws Exception{
				String [] deleteids = ids.split(",");
				for(int i = 0;i < deleteids.length;i++) {
					noteService.delete(Integer.parseInt(deleteids[i]));
				}
				JSONObject  result = new JSONObject();
				result.put("success", true);
				ResponseUtil.write(response, result);
				return null;
			}
			
			@RequestMapping("/findById")
			public String findById(@RequestParam(value="noteId")String id,HttpServletResponse response)throws Exception{
				Note note = noteService.findById(Integer.parseInt(id));
				JsonConfig jsonConfig=new JsonConfig();
				jsonConfig.setExcludes(new String[]{"note"});
				JSONObject jsonObject=JSONObject.fromObject(note,jsonConfig);
				ResponseUtil.write(response, jsonObject);
				return null;
			}
}

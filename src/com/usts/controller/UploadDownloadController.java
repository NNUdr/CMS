package com.usts.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadDownloadController {
	
	private static final String FILE_PATH = "E:\\skdSoftWare\\code\\usts_dr\\file";
	
	private List<String> files = new ArrayList();
	
	@RequestMapping("/upload")
	public String upload(@RequestParam("file")MultipartFile file,HttpSession session) throws IOException{
		//获取上传文件的原始名称
		IOUtils.copy(file.getInputStream(), new FileOutputStream(new File("E:\\skdSoftWare\\code\\usts_dr\\file",file.getOriginalFilename())));
		System.out.println(file.getOriginalFilename());
		session.setAttribute("files",files);
		files.add(file.getOriginalFilename());
		return "page/fileOrUpload";
	}
	
	@RequestMapping("/download")
	public ResponseEntity<byte[]> download(@RequestParam("file") String fileName,HttpServletResponse response) throws Exception{
		File file=new File(FILE_PATH,fileName); 
        System.out.println(fileName);
        //处理显示中文文件名的问题
        fileName = new String(fileName.getBytes("UTF-8"),"iso-8859-1");
        //设置请求头内容,告诉浏览器代开下载窗口
        HttpHeaders headers = new HttpHeaders();   
        headers.add("Content-Disposition", "attachment;fileName="
                + fileName); 
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
                                          headers, HttpStatus.CREATED);  
	}
}

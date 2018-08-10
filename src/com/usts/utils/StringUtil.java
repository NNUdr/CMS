package com.usts.utils;


//字符串工具类
public class StringUtil {
	//判断是否为空字符
	public static boolean isEmpty(String str){
		if(str==null||"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}
	
	// 判断是否不是空
	public static boolean isNotEmpty(String str){
		if((str!=null)&&!"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}
	
	//格式化模糊查询
	public static String formatLike(String str){
		if(isNotEmpty(str)){  //字符串不为空
			return "%"+str+"%";
		}else{
			return null;
		}
	}
}

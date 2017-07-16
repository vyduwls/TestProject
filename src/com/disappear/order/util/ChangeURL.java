package com.disappear.order.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class ChangeURL {
	public static String getUrlFormat(String oriName){
		
		String newName = null;
		
		try {
			newName = URLEncoder.encode(oriName,"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return newName;
	}
	
	public static String getUrlDecode(String newName){
		
		String oriName = newName;
		
		try {
			oriName = URLDecoder.decode(oriName,"EUC-KR");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		return oriName;
	}
}

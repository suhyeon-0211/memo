package com.memo.test;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {
	
	@RequestMapping("/test1")
	@ResponseBody
	public String test1() {
		return "hello world!!!!!!";
	}
	
	@RequestMapping("/test2")
	@ResponseBody
	public Map<String, String> test2() {
		Map<String, String> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	
	@RequestMapping("/test3")
	public String test3() {
		return "test/test";
	}
}

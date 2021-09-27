package com.memo.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.memo.test.bo.TestBO;

@Controller
public class TestController {
	
	@Autowired
	private TestBO testBO;
	
	// String Response 테스트
	@RequestMapping("/test1")
	@ResponseBody
	public String test1() {
		return "hello world!!!!!!";
	}
	
	// json으로 데이터 변환
	@RequestMapping("/test2")
	@ResponseBody
	public Map<String, String> test2() {
		Map<String, String> map = new HashMap<>();
		map.put("result", "success");
		return map;
	}
	
	// jsp 연결 테스트
	@RequestMapping("/test3")
	public String test3() {
		return "test/test";
	}
	
	// DB 연동 테스트
	@RequestMapping("/test4")
	@ResponseBody
	public List<Map<String, Object>> test4() {
		return testBO.getUserList();
	}
	
}

package com.memo.sign;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SignController {

	@RequestMapping("/user/sign_in_view")
	public String signIn() {
		return "sign_in_view";
	}
	
	@RequestMapping("/user/sign_up_view")
	public String signUp() {
		return "sign_up_view";
	}
}

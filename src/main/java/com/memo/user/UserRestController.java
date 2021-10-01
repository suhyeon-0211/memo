package com.memo.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.memo.common.EncryptUtils;
import com.memo.user.bo.UserBO;
import com.memo.user.model.User;

@RequestMapping("/user")
@RestController
public class UserRestController {
	
	@Autowired
	private UserBO userBO;
	
	/**
	 * 아이디 중복확인
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Boolean> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		// 로그인 아이디 중복 여부 DB 조회
		// 중복여부에 대한 결과 MAP 생성
		Map<String, Boolean> result = new HashMap<>();
		result.put("result", userBO.existLoginId(loginId));
		
		// return map
		return result;
	}
	
	/**
	 * 회원가입
	 * @param user
	 * @return
	 */
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@ModelAttribute User user) {
		// 비밀번호 해싱
		user.setPassword(EncryptUtils.md5(user.getPassword()));
		// DB insert
		int insertCnt = userBO.addUser(user);
		
		// 응답값 생성
		Map<String, Object> result = new HashMap<>();
		if (insertCnt > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		// return map
		return result;
	}
	
	/**
	 * 로그인
	 * @param loginId
	 * @param password
	 * @return
	 */
	@PostMapping("/sign_in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, HttpServletRequest request) {
		// 파라미터로 받은 비번을 해싱한다.
		String encryptPassword = EncryptUtils.md5(password);
		
		// DB SELECT - 아이디, 해싱된 암호
		User user = userBO.getUserByLoginIdAndPassword(loginId, encryptPassword);
		
		Map<String, Object> result = new HashMap<>();
		if (user != null) {
			// 있으면 성공	(세션)
			result.put("result", "success");
			
			// 로그인 처리 - 세션에 저장 (로그인 상태 유지)
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userName", user.getName());
			session.setAttribute("userLoginId", user.getLoginId());
		} else {
			// 없으면 로그인 실패
			result.put("result", "fail");
		}
		
		
		// 결과 리턴
		return result;
	}
}

package com.memo.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.memo.user.dao.UserDAO;
import com.memo.user.model.User;

@Service
public class UserBO {
	
	@Autowired
	private UserDAO userDAO;
	
	public boolean existLoginId(String loginId) {
		return userDAO.existLoginId(loginId);
	}
	
	public int addUser(User user) {
		return userDAO.inserUser(user);
	}
	
	public User getUserByLoginIdAndPassword(String loginId, String encryptPassword) {
		return userDAO.selectUserByLoginIdAndPassword(loginId, encryptPassword);
	}
}

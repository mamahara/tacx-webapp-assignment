package com.tacx.assignment.service;

import com.tacx.assignment.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.tacx.assignment.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserRepository userRepository;

	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;

	@Override
	public void save(User user) {
		user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));

		userRepository.save(user);
	}

	@Override
	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	@Override
	public User getLoggedUserDetails(String username) {
		return userRepository.getLoggedUserDetails(username);
	}

	@Override
	public void updateUserDetails(String person_id, String persistent_face_id,String username) {
		userRepository.updateUserDetails(person_id, persistent_face_id, username);
	}

	@Override
	public User getDetailsFromUsername(String username) {
		return userRepository.getDetailsFromUsername(username);
	}

}

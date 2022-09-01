package com.tacx.assignment.service;

import java.util.HashSet;
import java.util.Set;

import com.tacx.assignment.model.User;
import com.tacx.assignment.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
	@Autowired
	private UserRepository userRepository;

	@Override
	@Transactional(readOnly = true)
	public UserDetails loadUserByUsername(String username) {
		User user = userRepository.findByUsername(username);
		Set<GrantedAuthority> grantedAuthorities = new HashSet<>();
		if (user != null) {

			return new org.springframework.security.core.userdetails.User(
					user.getUsername(), user.getPassword(), grantedAuthorities);
		}
		return null;

	}
}

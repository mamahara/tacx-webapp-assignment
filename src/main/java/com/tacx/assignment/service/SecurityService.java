package com.tacx.assignment.service;

public interface SecurityService {
	String findLoggedInUsername();

	void autologin(String username, String password);
	void autofacelogin(String username);
}

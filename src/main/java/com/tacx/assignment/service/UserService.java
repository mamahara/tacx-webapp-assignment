package com.tacx.assignment.service;

import com.tacx.assignment.model.User;

public interface UserService {
	void save(User user);

	User findByUsername(String username);
	User getLoggedUserDetails(String username);

    void updateUserDetails(String person_id, String persistent_face_id,String loggedInUsername);

    User getDetailsFromUsername(String username);
}

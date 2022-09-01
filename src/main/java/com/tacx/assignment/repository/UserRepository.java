package com.tacx.assignment.repository;

import com.tacx.assignment.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

public interface UserRepository extends JpaRepository<User, Long> {

	public static final String GET_USER_DETAILS = "SELECT * FROM tbl_user where username=?";
	public static final String UPDATE_USER_DETAILS = "UPDATE tbl_user SET person_id = ?,persistent_face_id=?  where username=?";

	User findByUsername(String username);

	@Query(value = GET_USER_DETAILS, nativeQuery = true)
	User getLoggedUserDetails(String username);

	@Transactional
	@Modifying
	@Query(value = UPDATE_USER_DETAILS, nativeQuery = true)
    void updateUserDetails(String person_id, String persistent_face_id, String username);

	@Query(value = GET_USER_DETAILS, nativeQuery = true)
	User getDetailsFromUsername(String username);
}

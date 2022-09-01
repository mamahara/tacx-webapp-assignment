package com.tacx.assignment.repository;

import java.util.List;

import com.tacx.assignment.model.Profile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface ProfileRepository extends JpaRepository<Profile, Long> {
    public static final String FIND_PROFILES = "SELECT * FROM tbl_profile";
    public static final String SEARCH_PROFILES_USING_PASSPORT_NUMBER = "SELECT * FROM tbl_profile where passport_number=?";
    public static final String SAVE_PROFILE = "(passport_number, name, Country, passport_type, blacklisted, preclearance_done) values(?,?,?,?,?, ? );";

    @Query(value = FIND_PROFILES, nativeQuery = true)
    public List<Profile> getAllProfiles();

    @Query(value = SEARCH_PROFILES_USING_PASSPORT_NUMBER, nativeQuery = true)
    public List<Profile> searchProfiles(String passportNumber);
}
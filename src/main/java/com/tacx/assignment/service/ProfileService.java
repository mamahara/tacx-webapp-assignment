package com.tacx.assignment.service;

import java.util.List;

import com.tacx.assignment.model.Profile;

public interface ProfileService {

    List<Profile> getAllProfiles();
    List<Profile> searchProfile(String passportNumber);

    List<Profile> getProfileByPassportNUmber(String passportNumber);

    void saveProfile(Profile profile);
}
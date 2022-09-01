package com.tacx.assignment.service;

import java.util.List;

import com.tacx.assignment.model.Profile;
import com.tacx.assignment.repository.ProfileRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProfileServiceImpl implements ProfileService {

    @Autowired
    private ProfileRepository profileRepository;

    @Override
    public List<Profile> getAllProfiles() {
        return profileRepository.getAllProfiles();
    }

    @Override
    public List<Profile> searchProfile(String passportNumber) {
        return profileRepository.searchProfiles(passportNumber);
    }

    @Override
    public List<Profile> getProfileByPassportNUmber(String passportNumber) {
        return profileRepository.searchProfiles(passportNumber);
    }

    @Override
    public void saveProfile(Profile profile) {
        System.out.println("In profileServiceIMp");
        profileRepository.save(profile);
    }
}

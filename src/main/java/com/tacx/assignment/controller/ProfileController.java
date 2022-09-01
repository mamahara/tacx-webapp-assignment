package com.tacx.assignment.controller;

import com.tacx.assignment.model.Profile;
import com.tacx.assignment.service.ProfileService;
import com.tacx.assignment.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/profile")
@RestController
public class ProfileController {
    @Autowired
    ProfileService profileService;

    @RequestMapping(Constants.GET_ALL_PROFILE)
    public List<Profile> getAllProfiles() {
        return profileService.getAllProfiles();
    }

    @RequestMapping(Constants.GET_PROFILE_BY_PASSPORTNUMBER)
    public List<Profile> getProfileByPassportNumber(@PathVariable String passportNumber) {
        return profileService.getProfileByPassportNUmber(passportNumber);
    }

    @RequestMapping(value= Constants.SAVE_PROFILE, method= RequestMethod.POST)
    public void saveUser(@RequestBody Profile profile) {
        profileService.saveProfile(profile);
    }

}

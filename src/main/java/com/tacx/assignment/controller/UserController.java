package com.tacx.assignment.controller;

import com.tacx.assignment.model.User;
import com.tacx.assignment.service.ProfileService;
import com.tacx.assignment.service.SecurityService;
import com.tacx.assignment.service.UserService;
import com.tacx.assignment.utils.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class UserController {
    @Autowired
    ProfileService profileService;

    @Autowired
    SecurityService securityService;

    @Autowired
    UserService userService;

    @RequestMapping(value= Constants.GET_LOGGED_IN_USER_DETAILS, method= RequestMethod.GET)
    public User getLoggedUserDetails() {
        String loggedInUsername = securityService.findLoggedInUsername();
        System.out.println("username " + loggedInUsername);
        return userService.getLoggedUserDetails(loggedInUsername);
    }

    @RequestMapping(value= Constants.GET_USER_DETAILS_FROM_USERNAME, method= RequestMethod.POST)
    public User getDetailsFromUsername(@RequestBody User user) {
        System.out.println("username " + user.getUsername());
        return userService.getDetailsFromUsername(user.getUsername());
    }

    @RequestMapping(value= Constants.UPDATE_LOGGED_IN_USER_DETAILS, method= RequestMethod.POST)
    public void updateLoggedUserDetails(@RequestBody User user) {
        String loggedInUsername = securityService.findLoggedInUsername();
        System.out.println("username " + loggedInUsername);

        System.out.println("personId" + user.getPersonId());
        userService.updateUserDetails(user.getPersonId(),user.getPersistentFaceId(),loggedInUsername);
    }
}

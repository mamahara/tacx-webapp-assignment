package com.tacx.assignment.converter;

import com.tacx.assignment.dto.ProfileDto;
import com.tacx.assignment.model.Profile;

public class ProfileConverter {
	public static Profile dtoToEntity(ProfileDto profileDto) {
		Profile profile = new Profile();
		profile.setName(profileDto.getName());
		return profile;
	}
}

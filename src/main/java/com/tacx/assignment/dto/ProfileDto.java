package com.tacx.assignment.dto;

import java.util.ArrayList;
import java.util.List;

public class ProfileDto {

    private String passportNumber;
    private String name;
    private String Country;
    private String passportType;
    private boolean isBlacklisted;
    private boolean isPreclearanceDone;

    public ProfileDto(String passportNumber, String name, String Country, String passportType,
                        boolean isBlacklisted, boolean isPreclearanceDone ) {
        this.passportNumber=passportNumber;
        this.name=name;
        this.Country=Country;
        this.passportType=passportType;
        this.isBlacklisted=isBlacklisted;
        this.isPreclearanceDone=isPreclearanceDone;
    }

    public ProfileDto() {
    }

    public String getPassportNumber() {
        return passportNumber;
    }

    public void setPassportNumber(String passportNumber) {
        this.passportNumber = passportNumber;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountry() {
        return Country;
    }

    public void setCountry(String country) {
        Country = country;
    }

    public String getPassportType() {
        return passportType;
    }

    public void setPassportType(String passportType) {
        this.passportType = passportType;
    }

    public boolean isBlacklisted() {
        return isBlacklisted;
    }

    public void setBlacklisted(boolean blacklisted) {
        isBlacklisted = blacklisted;
    }

    public boolean isPreclearanceDone() {
        return isPreclearanceDone;
    }

    public void setPreclearanceDone(boolean preclearanceDone) {
        isPreclearanceDone = preclearanceDone;
    }


}

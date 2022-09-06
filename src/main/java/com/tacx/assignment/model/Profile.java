package com.tacx.assignment.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_profile")
public class Profile {
    @Id
    private String passportNumber;
    private String name;
    private String Country;
    private String passportType;
    private boolean isBlacklisted;
    private boolean isPreclearanceDone;


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
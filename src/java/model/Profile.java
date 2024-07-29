package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author DELL
 */
public class Profile {
    public String userId,username, fullname, email, linkAvatar, phoneNumber, status, creationDate, lastLoginDate;

    public Profile(String userId, String username, String fullname, String email, String linkAvatar, String phoneNumber, String status, String creationDate, String lastLoginDate) {
        this.userId = userId;
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.linkAvatar = linkAvatar;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.creationDate = creationDate;
        this.lastLoginDate = lastLoginDate;
    }

    public String getLastLoginDate() {
        return lastLoginDate;
    }

    public void setLastLoginDate(String lastLoginDate) {
        this.lastLoginDate = lastLoginDate;
    }

    public Profile(String userId, String username, String fullname, String email, String linkAvatar, String phoneNumber, String status, String creationDate) {
        this.userId = userId;
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.linkAvatar = linkAvatar;
        this.phoneNumber = phoneNumber;
        this.status = status;
        this.creationDate = creationDate;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public Profile(String userId, String username, String fullname, String email, String linkAvatar, String phoneNumber, String status) {
        this.userId = userId;
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.linkAvatar = linkAvatar;
        this.phoneNumber = phoneNumber;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Profile(String userId, String username, String fullname, String email, String linkAvatar, String phoneNumber) {
        this.userId = userId;
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.linkAvatar = linkAvatar;
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

  

    public Profile() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLinkAvatar() {
        return linkAvatar;
    }

    public void setLinkAvatar(String linkAvatar) {
        this.linkAvatar = linkAvatar;
    }

    @Override
    public String toString() {
        return "Profile{" + "userId=" + userId + ", username=" + username + ", fullname=" + fullname + ", email=" + email + ", linkAvatar=" + linkAvatar + ", phoneNumber=" + phoneNumber + ", status=" + status + '}';
    }
    

}

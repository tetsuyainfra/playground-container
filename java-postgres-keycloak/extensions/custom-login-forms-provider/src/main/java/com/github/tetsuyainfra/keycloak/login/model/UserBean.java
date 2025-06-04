package com.github.tetsuyainfra.keycloak.login.model;

import org.keycloak.models.UserModel;

public class UserBean {
    private String id;
    private String username;
    private String email;
    private String firstName;
    private String lastName;

    public UserBean(UserModel user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.firstName = user.getFirstName();
        this.lastName = user.getLastName();
    }

    public String getId() {
        return id;
    }
    public String getUsername() {
        return username;
    }
    public String getEmail() {
        return email;
    }
    public String getFirstName() {
        return firstName;
    }
    public String getLastName() {
        return lastName;
    }
}

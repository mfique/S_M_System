package main.service;

public interface UserService {
    boolean authenticate(String username, String password);
}

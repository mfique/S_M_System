package main.service.impl;

import main.dao.UserDAO;
import main.dao.impl.UserDAOImpl;
import main.model.User;
import main.service.UserService;

public class UserServiceImpl implements UserService {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public boolean authenticate(String username, String password) {
        return userDAO.findByUsername(username)
                .map(user -> user.getPassword().equals(password))
                .orElse(false);
    }
}

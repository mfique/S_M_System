package main.dao;

import main.model.User;
import java.util.Optional;

public interface UserDAO {
    Optional<User> findByUsername(String username);
}

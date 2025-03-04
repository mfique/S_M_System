package main.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DatabaseConfig {

    private static HikariDataSource dataSource;

    static {
        try {
            // Ensure PostgreSQL driver is loaded
            Class.forName("org.postgresql.Driver");

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl("jdbc:postgresql://localhost:5432/school_management"); // Your DB URL
            config.setUsername("postgres"); // DB username
            config.setPassword("fiqueboi"); // DB password
            config.setMaximumPoolSize(10); // Set max pool size (optional)
            dataSource = new HikariDataSource(config);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("PostgreSQL JDBC driver not found", e);
        }
    }

    // Get connection from the pool
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    // Close connection (if needed)
    public static void close(Connection connection) throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}

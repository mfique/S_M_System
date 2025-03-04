package main.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import main.config.DatabaseConfig;
import java.io.*;
import java.sql.*;

public class AddStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        int age = Integer.parseInt(ageStr);

        try (Connection connection = DatabaseConfig.getConnection()) {
            String sql = "INSERT INTO students (name, age) VALUES (?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, name);
                preparedStatement.setInt(2, age);

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("dashboard");
                } else {
                    response.sendRedirect("error.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
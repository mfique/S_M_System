package main.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import main.config.DatabaseConfig;

import java.io.*;
import java.sql.*;

@WebServlet("/updateStudentServlet")
public class UpdateStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentIDStr = request.getParameter("studentID");
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");

        int studentID = Integer.parseInt(studentIDStr);
        int age = Integer.parseInt(ageStr);

        try (Connection connection = DatabaseConfig.getConnection()) {
            String sql = "UPDATE students SET name = ?, age = ? WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, name);
                preparedStatement.setInt(2, age);
                preparedStatement.setInt(3, studentID);

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
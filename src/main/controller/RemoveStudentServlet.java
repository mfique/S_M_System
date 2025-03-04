package main.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import main.config.DatabaseConfig;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/removeStudent")
public class RemoveStudentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentID = request.getParameter("studentID");

        if (studentID == null || studentID.isEmpty()) {
            response.sendRedirect("dashboard.jsp?error=No student ID provided");
            return;
        }

        try (Connection connection = DatabaseConfig.getConnection()) {
            String deleteSQL = "DELETE FROM students WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(deleteSQL)) {
                preparedStatement.setInt(1, Integer.parseInt(studentID));

                int rowsAffected = preparedStatement.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("dashboard.jsp?success=Student removed successfully");
                } else {
                    response.sendRedirect("dashboard.jsp?error=Student not found");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=Database error occurred");
        }
    }
}
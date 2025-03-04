package main.controller;

import main.service.UserService;
import main.service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the necessary attributes for the login page
        request.setAttribute("title", "Login Page");
        request.setAttribute("cardLabel", "Username");
        request.setAttribute("pinLabel", "Password");
        request.setAttribute("cardPlaceholder", "Enter your username");
        request.setAttribute("pinPlaceholder", "Enter your password");
        request.setAttribute("loginButton", "Login");

        // Forward to the login page (index.jsp)
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username and password from request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check if user credentials are valid
        if (userService.authenticate(username, password)) {
            // Store the username in session
            request.getSession().setAttribute("user", username);
            // Redirect to the dashboard page
            response.sendRedirect("dashboard");
        } else {
            // Redirect back to the login page with an error parameter
            response.sendRedirect("index.jsp?error=invalid_credentials");
        }
    }
}

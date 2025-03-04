<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ResourceBundle" %>
<%@ page import="java.sql.*" %>
<%
    // Set language for the page (from session)
    String lang = (String) session.getAttribute("language");
    if (lang == null) lang = "en";
    ResourceBundle messages = ResourceBundle.getBundle("messages", new java.util.Locale(lang));

    // Check if user is logged in
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("home");
        return;
    }

    // JDBC connection details
    String URL = "jdbc:postgresql://localhost:5432/school_management";
    String DB_USER = "postgres";
    String DB_PASSWORD = "fiqueboi";
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;

    try {
        // Register and establish connection
        Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
        statement = connection.createStatement();
        String sql = "SELECT id, name, age FROM students";  // SQL to fetch students
        resultSet = statement.executeQuery(sql);
%>

<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h1 class="welcome-message"><%= messages.getString("dashboard.welcome") %>, <%= user %>!</h1>

        <!-- Language Switch -->
        <div class="language-switch">
            <h3>Change Language</h3>
            <a href="language?lang=en">English</a> | <a href="language?lang=fr">Français</a>
        </div>

        <!-- Add Student Button -->
        <h3><a class="add-student-btn" href="addStudent">Add New Student</a></h3>

        <!-- List of Students -->
        <h3>All Students</h3>
        <table class="students-table">
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Display students list from database
                    while (resultSet.next()) {
                        int studentID = resultSet.getInt("id");
                        String name = resultSet.getString("name");
                        int age = resultSet.getInt("age");
                %>
                <tr>
                    <td><%= studentID %></td>
                    <td><%= name %></td>
                    <td><%= age %></td>
                    <td>
                        <!-- Update Student Form -->
                        <form action="updateStudentServlet" method="post" class="student-form">
                            <input type="hidden" name="studentID" value="<%= studentID %>">
                            <input type="text" name="name" value="<%= name %>" required>
                            <input type="number" name="age" value="<%= age %>" required>
                            <button type="submit" class="update-btn">Update</button>
                        </form>

                        <!-- Remove Student Form -->
                        <form action="removeStudentServlet" method="post" class="student-form">
                            <input type="hidden" name="studentID" value="<%= studentID %>">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Logout -->
        <div class="logout">
            <a href="logout.jsp">Logout</a>
        </div>
    </div>

    <%
        // Close the database resources
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>

<!-- CSS Styles (styles.css) -->
<style>
/* General Styles */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f7f8fa;
    margin: 0;
    padding: 0;
}

/* Centering the content */
.container {
    width: 100%;
    max-width: 1000px;
    margin: 20px auto;
    background: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.1);
    text-align: center;
}

/* Header Styles */
.welcome-message {
    font-size: 24px;
    color: #333;
}

/* Language Switch */
.language-switch {
    margin: 15px 0;
    font-size: 16px;
}

.language-switch a {
    color: #007bff;
    text-decoration: none;
    margin: 0 5px;
}

.language-switch a:hover {
    text-decoration: underline;
}

/* Add Student Button */
.add-student-btn {
    font-size: 18px;
    color: #fff;
    background: #007bff;
    padding: 10px 15px;
    border-radius: 5px;
    text-decoration: none;
}

.add-student-btn:hover {
    background: #0056b3;
}

/* Table Styles */
.students-table {
    width: 100%;
    margin-top: 20px;
    border-collapse: collapse;
}

.students-table th, .students-table td {
    padding: 12px;
    text-align: left;
    border: 1px solid #ddd;
}

.students-table th {
    background-color: #007bff;
    color: white;
}

.students-table tr:nth-child(even) {
    background-color: #f2f2f2;
}

.students-table tr:hover {
    background-color: #e0e0e0;
}

/* Form Inputs */
input[type="text"],
input[type="number"] {
    padding: 8px;
    margin: 5px 0;
    border-radius: 5px;
    border: 1px solid #ddd;
    width: 200px;
}

/* Button Styles */
button {
    padding: 10px 15px;
    border-radius: 5px;
    font-size: 14px;
    color: #fff;
    background-color: #28a745;
    border: none;
    cursor: pointer;
}

button:hover {
    background-color: #218838;
}

/* Update and Remove Buttons */
.update-btn {
    background-color: #007bff;
}

.update-btn:hover {
    background-color: #0056b3;
}

.remove-btn {
    background-color: #dc3545;
}

.remove-btn:hover {
    background-color: #c82333;
}

/* Logout Button */
.logout {
    margin-top: 20px;
}

.logout a {
    font-size: 16px;
    color: red;
    text-decoration: none;
}

.logout a:hover {
    text-decoration: underline;
}
</style>

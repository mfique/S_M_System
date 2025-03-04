<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>

<%
    // Retrieve the language from session or request, default to English if not found
    String lang = (String) session.getAttribute("language");
    if (lang == null) {
        lang = "en";  // Default language to English
    }

    // Set default language if not already set in the request
    if (request.getAttribute("title") == null) {
        request.getRequestDispatcher("language?lang=" + lang).forward(request, response);
    }
%>

<!DOCTYPE html>
<html lang="<%= lang %>">
<head>
    <meta charset="UTF-8">
    <title><%= request.getAttribute("title") %></title>

    <!-- Inline CSS for Styling -->
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Language Switcher - Top Right */
        .language-switch {
            position: absolute;
            top: 10px;
            right: 20px;
            display: flex;
            align-items: center;
        }

        .language-switch a {
            margin-left: 10px;
            text-decoration: none;
            font-size: 16px;
            color: #333;
            display: flex;
            align-items: center;
            transition: color 0.3s;
        }

        .language-switch a img {
            width: 20px;
            height: 15px;
            margin-right: 5px;
        }

        .language-switch a.selected {
            font-weight: bold;
            color: #007bff;
        }

        .language-switch a:hover {
            color: #0056b3;
        }

        /* Container Styles */
        .container {
            width: 100%;
            max-width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .container:hover {
            transform: translateY(-2px);
            box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
        }

        /* Form Inputs */
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        /* Input Focus Effect */
        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0px 0px 6px rgba(0, 123, 255, 0.4);
        }

        /* Buttons */
        button {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        button:hover {
            background: #0056b3;
            transform: scale(1.03);
        }

        /* Error Message */
        .error {
            color: red;
            font-weight: bold;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <!-- Language Switcher with Flags -->
    <div class="language-switch">
        <a href="language?lang=en" class="<%= lang.equals("en") ? "selected" : "" %>">🌎 English</a>
        <a href="language?lang=fr" class="<%= lang.equals("fr") ? "selected" : "" %>"> 🔴Français</a>
    </div>

    <!-- Main Content -->
    <div class="container">
        <h2><%= request.getAttribute("title") %></h2>
        <form action="login" method="post">
            <label><%= request.getAttribute("cardLabel") %></label>
            <input type="text" name="username" required placeholder="<%= request.getAttribute("cardPlaceholder") %>">

            <label><%= request.getAttribute("pinLabel") %></label>
            <input type="password" name="password" required placeholder="<%= request.getAttribute("pinPlaceholder") %>">

            <button type="submit"><%= request.getAttribute("loginButton") %></button>
        </form>

        <% if (request.getParameter("error") != null) { %>
            <p class="error">Invalid username or password.</p>
        <% } %>
    </div>
</body>
</html>

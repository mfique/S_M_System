package main.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/language")
public class LanguageServlet extends HttpServlet {
    // Define a map to store the translations for different languages
    private static final Map<String, Map<String, String>> LANGUAGE_MAP = new HashMap<>();

    static {
        // English translations
        Map<String, String> en = new HashMap<>();
        en.put("title", "Login");
        en.put("cardLabel", "Username");
        en.put("cardPlaceholder", "password");
        en.put("pinLabel", "password");
        en.put("pinPlaceholder", "Enter your PIN");
        en.put("loginButton", "Login");
        LANGUAGE_MAP.put("en", en);

        // French translations
        Map<String, String> fr = new HashMap<>();
        fr.put("title", "Connexion");
        fr.put("cardLabel", "Nom d'utilisateur");
        fr.put("cardPlaceholder", "votre nom");
        fr.put("pinLabel", "mod de passe");
        fr.put("pinPlaceholder", "mod de passe");
        fr.put("loginButton", "Connexion");
        LANGUAGE_MAP.put("fr", fr);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the language parameter, default to "en" (English) if not present
        String lang = request.getParameter("lang");

        // If no language is selected, default to English
        if (lang == null || !LANGUAGE_MAP.containsKey(lang)) {
            lang = "en";
        }

        // Store the selected language in session
        request.getSession().setAttribute("language", lang);

        // Get the localized messages from the selected language
        Map<String, String> languageData = LANGUAGE_MAP.get(lang);
        request.setAttribute("title", languageData.get("title"));
        request.setAttribute("cardLabel", languageData.get("cardLabel"));
        request.setAttribute("cardPlaceholder", languageData.get("cardPlaceholder"));
        request.setAttribute("pinLabel", languageData.get("pinLabel"));
        request.setAttribute("pinPlaceholder", languageData.get("pinPlaceholder"));
        request.setAttribute("loginButton", languageData.get("loginButton"));

        // Forward to the index.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
}

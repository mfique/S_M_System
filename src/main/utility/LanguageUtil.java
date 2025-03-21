package main.utility;

import java.util.Locale;
import java.util.ResourceBundle;

public class LanguageUtil {
    public static String getMessage(String key, String lang) {
        Locale locale = lang.equals("fr") ? Locale.FRENCH : Locale.ENGLISH;
        ResourceBundle bundle = ResourceBundle.getBundle("messages", locale);
        return bundle.getString(key);
    }
}

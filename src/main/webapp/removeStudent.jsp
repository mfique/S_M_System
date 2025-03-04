import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class RemoveStudentServlet extends HttpServlet {

    private static final String URL = "jdbc:postgresql://localhost:5432/your_database";
    private static final String USER = "your_db_user";
    private static final String PASSWORD = "your_db_password";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentIDStr = request.getParameter("studentID");
        int studentID = Integer.parseInt(studentIDStr);

        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD)) {
            String sql = "DELETE FROM students WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, studentID);
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

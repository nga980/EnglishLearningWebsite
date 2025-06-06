package controller;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet xử lý việc hiển thị trang quản lý người dùng cho Admin.
 */
@WebServlet(name = "ManageUsersServlet", urlPatterns = {"/admin/manage-users"})
public class ManageUsersServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<User> userList = userDAO.getAllUsers();
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("/admin/manageUsers.jsp").forward(request, response);
    }
}
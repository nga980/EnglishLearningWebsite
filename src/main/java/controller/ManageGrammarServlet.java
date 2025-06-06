package controller; // Hoặc package controller của bạn

import dao.GrammarTopicDAO; // Hoặc package dao của bạn
import model.GrammarTopic;  // Hoặc package model của bạn
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet này xử lý việc hiển thị trang quản lý chủ đề ngữ pháp cho Admin.
 */
@WebServlet(name = "ManageGrammarServlet", urlPatterns = {"/admin/manage-grammar"})
public class ManageGrammarServlet extends HttpServlet {

    private GrammarTopicDAO grammarTopicDAO;

    @Override
    public void init() {
        grammarTopicDAO = new GrammarTopicDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<GrammarTopic> grammarTopicList = grammarTopicDAO.getAllGrammarTopics();
        request.setAttribute("grammarTopicList", grammarTopicList);

        request.getRequestDispatcher("/admin/manageGrammar.jsp").forward(request, response);
    }
}
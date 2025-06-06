package controller; // Hoặc package controller của bạn

import dao.VocabularyDAO; // Hoặc package dao của bạn
import model.Vocabulary;  // Hoặc package model của bạn
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet này xử lý việc hiển thị trang quản lý từ vựng cho Admin.
 */
@WebServlet(name = "ManageVocabularyServlet", urlPatterns = {"/admin/manage-vocabulary"})
public class ManageVocabularyServlet extends HttpServlet {

    private VocabularyDAO vocabularyDAO;

    @Override
    public void init() {
        vocabularyDAO = new VocabularyDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<Vocabulary> vocabularyList = vocabularyDAO.getAllVocabulary();
        request.setAttribute("vocabularyList", vocabularyList);

        request.getRequestDispatcher("/admin/manageVocabulary.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing vocabulary (listing vocabulary for admin)";
    }
}
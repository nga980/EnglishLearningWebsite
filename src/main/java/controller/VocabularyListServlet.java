/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.VocabularyDAO;
import model.Vocabulary;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "VocabularyListServlet", urlPatterns = {"/vocabulary"}) // Ánh xạ servlet tới URL /vocabulary
public class VocabularyListServlet extends HttpServlet {

    private VocabularyDAO vocabularyDAO;

    @Override
    public void init() {
        vocabularyDAO = new VocabularyDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Lấy tất cả từ vựng
        // Tùy chọn: Nếu bạn muốn lọc từ vựng theo bài học, bạn có thể kiểm tra request parameter "lessonId" ở đây
        // String lessonIdParam = request.getParameter("lessonId");
        // List<Vocabulary> vocabularyList;
        // if (lessonIdParam != null && !lessonIdParam.isEmpty()) {
        // try {
        // int lessonId = Integer.parseInt(lessonIdParam);
        // vocabularyList = vocabularyDAO.getVocabularyByLessonId(lessonId);
        // request.setAttribute("filterLessonId", lessonId); // Để JSP biết đang lọc theo bài nào
        // } catch (NumberFormatException e) {
        // vocabularyList = vocabularyDAO.getAllVocabulary(); // Nếu lessonId không hợp lệ, lấy tất cả
        // }
        // } else {
        // vocabularyList = vocabularyDAO.getAllVocabulary();
        // }

        List<Vocabulary> vocabularyList = vocabularyDAO.getAllVocabulary();
        request.setAttribute("vocabularyList", vocabularyList);

        request.getRequestDispatcher("vocabulary.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể xử lý POST nếu cần, ví dụ: tìm kiếm từ vựng
        doGet(request, response); // Hiện tại, xử lý POST giống như GET
    }
}
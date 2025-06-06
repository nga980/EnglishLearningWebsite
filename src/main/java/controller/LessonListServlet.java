package controller;

import dao.LessonDAO;
import model.Lesson;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LessonListServlet", urlPatterns = {"/lessons"}) // Ánh xạ servlet tới URL /lessons
public class LessonListServlet extends HttpServlet {

    private LessonDAO lessonDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        lessonDAO = new LessonDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            List<Lesson> lessonList = lessonDAO.getAllLessons();
            request.setAttribute("lessonList", lessonList);
            request.getRequestDispatcher("lessons.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách bài học: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Tạm thời xử lý POST như GET. Có thể thay đổi để hỗ trợ tìm kiếm bài học, lọc, v.v.
        doGet(request, response);
    }
}

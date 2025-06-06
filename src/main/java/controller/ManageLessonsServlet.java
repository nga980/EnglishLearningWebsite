package controller; // Hoặc package controller của bạn

import dao.LessonDAO; // Hoặc package dao của bạn
import model.Lesson;  // Hoặc package model của bạn
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet này xử lý việc hiển thị trang quản lý bài học cho Admin.
 * Nó lấy danh sách bài học và chuyển đến manageLessons.jsp.
 * Được bảo vệ bởi AdminAuthFilter.
 */
@WebServlet(name = "ManageLessonsServlet", urlPatterns = {"/admin/manage-lessons"})
public class ManageLessonsServlet extends HttpServlet {

    private LessonDAO lessonDAO;

    @Override
    public void init() {
        lessonDAO = new LessonDAO(); // Khởi tạo DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<Lesson> lessonList = lessonDAO.getAllLessons();
        request.setAttribute("lessonList", lessonList);

        // Chuyển tiếp đến trang JSP trong thư mục admin
        request.getRequestDispatcher("/admin/manageLessons.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể dùng cho các action như xóa nhiều bài, tìm kiếm (nếu cần)
        doGet(request, response); // Hiện tại, POST sẽ làm giống GET
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing lessons (listing lessons for admin)";
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author admin
 */
import model.Lesson;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LessonDAO {
    private static final Logger LOGGER = Logger.getLogger(LessonDAO.class.getName());

    /**
     * Lấy tất cả các bài học từ CSDL.
     * @return Danh sách các đối tượng Lesson.
     */
    public List<Lesson> getAllLessons() {
        List<Lesson> lessons = new ArrayList<>();
        String query = "SELECT lesson_id, title, content, created_at FROM lessons ORDER BY created_at DESC";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonId(rs.getInt("lesson_id"));
                lesson.setTitle(rs.getString("title"));
                lesson.setContent(rs.getString("content")); // Cân nhắc chỉ lấy content khi xem chi tiết nếu content quá dài
                lesson.setCreatedAt(rs.getTimestamp("created_at"));
                lessons.add(lesson);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy danh sách bài học", e);
        }
        return lessons;
    }

    /**
     * Lấy một bài học cụ thể bằng ID.
     * @param lessonId ID của bài học.
     * @return Đối tượng Lesson hoặc null nếu không tìm thấy.
     */
    public Lesson getLessonById(int lessonId) {
        String query = "SELECT lesson_id, title, content, created_at FROM lessons WHERE lesson_id = ?";
        Lesson lesson = null;
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, lessonId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    lesson = new Lesson();
                    lesson.setLessonId(rs.getInt("lesson_id"));
                    lesson.setTitle(rs.getString("title"));
                    lesson.setContent(rs.getString("content"));
                    lesson.setCreatedAt(rs.getTimestamp("created_at"));
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy bài học với ID: " + lessonId, e);
        }
        return lesson;
    }

    /**
     * Thêm một bài học mới vào CSDL (dành cho Admin).
     * @param lesson Đối tượng Lesson chứa thông tin bài học mới.
     * @return true nếu thêm thành công, false nếu thất bại.
     */
    public boolean addLesson(Lesson lesson) {
        String query = "INSERT INTO lessons (title, content, created_at) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) { // Lấy ID được tạo

            ps.setString(1, lesson.getTitle());
            ps.setString(2, lesson.getContent());
            ps.setTimestamp(3, new Timestamp(System.currentTimeMillis())); // Hoặc lấy từ lesson.getCreatedAt() nếu được set trước

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                // Lấy lesson_id được tự động tạo (nếu cần)
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        lesson.setLessonId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi thêm bài học mới: " + lesson.getTitle(), e);
        }
        return false;
    }

    /**
     * Cập nhật thông tin một bài học (dành cho Admin).
     * @param lesson Đối tượng Lesson chứa thông tin cần cập nhật.
     * @return true nếu cập nhật thành công, false nếu thất bại.
     */
    public boolean updateLesson(Lesson lesson) {
        String query = "UPDATE lessons SET title = ?, content = ? WHERE lesson_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, lesson.getTitle());
            ps.setString(2, lesson.getContent());
            ps.setInt(3, lesson.getLessonId());

            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi cập nhật bài học ID: " + lesson.getLessonId(), e);
        }
        return false;
    }

    /**
     * Xóa một bài học (dành cho Admin).
     * @param lessonId ID của bài học cần xóa.
     * @return true nếu xóa thành công, false nếu thất bại.
     */
    public boolean deleteLesson(int lessonId) {
        // Cân nhắc: Khi xóa bài học, bạn có muốn xóa các câu hỏi quiz liên quan không? (ON DELETE CASCADE trong CSDL)
        String query = "DELETE FROM lessons WHERE lesson_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, lessonId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa bài học ID: " + lessonId, e);
        }
        return false;
    }
    /**
     * Đếm tổng số bài học trong CSDL.
     * @return Tổng số bài học.
     */
    public int countTotalLessons() {
        String query = "SELECT COUNT(*) FROM lessons";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi đếm tổng số bài học", e);
        }
        return 0;
    }
}

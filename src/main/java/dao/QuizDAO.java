package dao; // Hoặc package dao của bạn

import model.QuizOption;
import model.QuizQuestion;
import utils.DBContext; // Đảm bảo bạn đã có lớp này
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class QuizDAO {
    private static final Logger LOGGER = Logger.getLogger(QuizDAO.class.getName());

    /**
     * Lấy tất cả các câu hỏi và các lựa chọn tương ứng của một bài học.
     * @param lessonId ID của bài học.
     * @return Danh sách các đối tượng QuizQuestion.
     */
    public List<QuizQuestion> getQuestionsByLessonId(int lessonId) {
        List<QuizQuestion> questions = new ArrayList<>();
        String questionQuery = "SELECT question_id, question_text FROM quiz_questions WHERE lesson_id = ?";
        String optionQuery = "SELECT option_id, option_text, is_correct FROM quiz_options WHERE question_id = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement psQuestions = conn.prepareStatement(questionQuery)) {

            psQuestions.setInt(1, lessonId);
            try (ResultSet rsQuestions = psQuestions.executeQuery()) {
                while (rsQuestions.next()) {
                    int questionId = rsQuestions.getInt("question_id");
                    String questionText = rsQuestions.getString("question_text");

                    QuizQuestion question = new QuizQuestion(questionId, lessonId, questionText);

                    // Với mỗi câu hỏi, lấy các lựa chọn của nó
                    try (PreparedStatement psOptions = conn.prepareStatement(optionQuery)) {
                        psOptions.setInt(1, questionId);
                        try (ResultSet rsOptions = psOptions.executeQuery()) {
                            while (rsOptions.next()) {
                                QuizOption option = new QuizOption();
                                option.setOptionId(rsOptions.getInt("option_id"));
                                option.setQuestionId(questionId);
                                option.setOptionText(rsOptions.getString("option_text"));
                                option.setIsCorrect(rsOptions.getBoolean("is_correct"));
                                question.addOption(option);
                            }
                        }
                    }
                    questions.add(question);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi lấy câu hỏi cho bài học ID: " + lessonId, e);
        }
        return questions;
    }

    /**
     * Thêm một câu hỏi mới cùng với các lựa chọn của nó vào CSDL.
     * Sử dụng transaction để đảm bảo tính toàn vẹn dữ liệu.
     * @param question Đối tượng QuizQuestion chứa đầy đủ thông tin.
     * @return true nếu thêm thành công, false nếu thất bại.
     */
    public boolean addQuestionWithOptions(QuizQuestion question) {
        String questionInsertQuery = "INSERT INTO quiz_questions (lesson_id, question_text) VALUES (?, ?)";
        String optionInsertQuery = "INSERT INTO quiz_options (question_id, option_text, is_correct) VALUES (?, ?, ?)";
        Connection conn = null;
        boolean success = false;

        try {
            conn = DBContext.getConnection();
            // Bắt đầu transaction
            conn.setAutoCommit(false);

            // Thêm câu hỏi trước để lấy question_id
            try (PreparedStatement psQuestion = conn.prepareStatement(questionInsertQuery, Statement.RETURN_GENERATED_KEYS)) {
                psQuestion.setInt(1, question.getLessonId());
                psQuestion.setString(2, question.getQuestionText());
                psQuestion.executeUpdate();

                // Lấy question_id vừa được tạo
                try (ResultSet generatedKeys = psQuestion.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int newQuestionId = generatedKeys.getInt(1);
                        question.setQuestionId(newQuestionId);

                        // Thêm các lựa chọn với question_id mới
                        try (PreparedStatement psOption = conn.prepareStatement(optionInsertQuery)) {
                            for (QuizOption option : question.getOptions()) {
                                psOption.setInt(1, newQuestionId);
                                psOption.setString(2, option.getOptionText());
                                psOption.setBoolean(3, option.isIsCorrect());
                                psOption.addBatch(); // Thêm vào batch để thực thi cùng lúc
                            }
                            psOption.executeBatch(); // Thực thi batch
                        }
                    } else {
                        throw new SQLException("Thêm câu hỏi thất bại, không nhận được ID.");
                    }
                }
            }

            conn.commit(); // Hoàn tất transaction
            success = true;
            LOGGER.log(Level.INFO, "Thêm câu hỏi và các lựa chọn thành công cho lesson ID: {0}", question.getLessonId());

        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi thêm câu hỏi và lựa chọn. Đang rollback transaction.", e);
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback nếu có lỗi
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Lỗi khi rollback transaction.", ex);
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true); // Trả lại trạng thái auto-commit mặc định
                    conn.close();
                } catch (SQLException ex) {
                    LOGGER.log(Level.SEVERE, "Lỗi khi đóng kết nối.", ex);
                }
            }
        }
        return success;
    }

    /**
     * Xóa một câu hỏi (và các lựa chọn liên quan nếu CSDL được thiết lập ON DELETE CASCADE).
     * @param questionId ID của câu hỏi cần xóa.
     * @return true nếu xóa thành công, false nếu thất bại.
     */
    public boolean deleteQuestion(int questionId) {
        String query = "DELETE FROM quiz_questions WHERE question_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, questionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xóa câu hỏi ID: " + questionId, e);
        }
        return false;
    }
}
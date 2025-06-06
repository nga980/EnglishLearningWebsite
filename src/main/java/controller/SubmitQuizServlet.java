package controller;

import dao.QuizDAO;
import model.QuizOption;
import model.QuizQuestion;
import model.QuizResultDetail; // Import lớp mới
import model.User;
import java.io.IOException;
import java.util.ArrayList; // Import ArrayList
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "SubmitQuizServlet", urlPatterns = {"/submit-quiz"})
public class SubmitQuizServlet extends HttpServlet {
    private QuizDAO quizDAO;

    @Override
    public void init() {
        quizDAO = new QuizDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String lessonIdStr = request.getParameter("lessonId");
        if (lessonIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/lessons");
            return;
        }

        try {
            int lessonId = Integer.parseInt(lessonIdStr);
            List<QuizQuestion> correctQuestions = quizDAO.getQuestionsByLessonId(lessonId);

            int score = 0;
            int totalQuestions = correctQuestions.size();

            // Tạo danh sách để lưu kết quả chi tiết
            List<QuizResultDetail> detailedResults = new ArrayList<>();

            for (QuizQuestion question : correctQuestions) {
                QuizResultDetail resultDetail = new QuizResultDetail();
                resultDetail.setQuestion(question); // Gán câu hỏi gốc

                String selectedOptionIdStr = request.getParameter("question_" + question.getQuestionId());
                int selectedOptionId = -1; // -1 nghĩa là không trả lời

                if (selectedOptionIdStr != null) {
                    selectedOptionId = Integer.parseInt(selectedOptionIdStr);
                    resultDetail.setSelectedOptionId(selectedOptionId); // Ghi nhận lựa chọn của người dùng

                    // Kiểm tra xem lựa chọn có đúng không
                    boolean isAnswerCorrect = false;
                    for (QuizOption option : question.getOptions()) {
                        if (option.isIsCorrect() && option.getOptionId() == selectedOptionId) {
                            score++;
                            isAnswerCorrect = true;
                            break;
                        }
                    }
                    resultDetail.setWasCorrect(isAnswerCorrect); // Ghi nhận câu này đúng hay sai
                } else {
                    // Người dùng không trả lời câu này
                    resultDetail.setSelectedOptionId(-1);
                    resultDetail.setWasCorrect(false);
                }

                detailedResults.add(resultDetail); // Thêm kết quả chi tiết của câu hỏi vào danh sách
            }

            request.setAttribute("score", score);
            request.setAttribute("totalQuestions", totalQuestions);
            request.setAttribute("lessonId", lessonId);
            request.setAttribute("detailedResults", detailedResults); // Gửi danh sách kết quả chi tiết tới JSP

            request.getRequestDispatcher("quizResult.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/lessons");
        }
    }
}
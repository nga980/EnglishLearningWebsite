package controller; 

import dao.GrammarTopicDAO;
import model.GrammarTopic;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GrammarListServlet", urlPatterns = {"/grammar"}) // Ánh xạ servlet tới URL /grammar
public class GrammarListServlet extends HttpServlet {

    private GrammarTopicDAO grammarTopicDAO;

    @Override
    public void init() {
        grammarTopicDAO = new GrammarTopicDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        List<GrammarTopic> grammarTopicList = grammarTopicDAO.getAllGrammarTopics();
        request.setAttribute("grammarTopicList", grammarTopicList);

        request.getRequestDispatcher("grammar.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
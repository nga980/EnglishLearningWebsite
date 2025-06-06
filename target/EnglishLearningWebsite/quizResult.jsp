<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Kết Quả Trắc Nghiệm</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .result-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f8f9fa;
        }
        .score {
            font-size: 3rem;
            font-weight: bold;
            color: #007bff;
        }
        .score-text {
            font-size: 1.5rem;
            margin-bottom: 30px;
        }
        .review-question {
            text-align: left;
            margin-top: 30px;
            border-top: 1px solid #ccc;
            padding-top: 20px;
        }
        .review-question p {
            font-size: 1.1rem;
            font-weight: bold;
        }
        /* Định dạng cho các lựa chọn */
        .option-item {
            border-left: 5px solid #ccc;
            padding-left: 15px;
            margin-bottom: 5px;
        }
        .option-item.correct-answer { /* Đáp án đúng */
            border-left-color: #28a745;
            background-color: #e9f7ef;
            font-weight: bold;
        }
        .option-item.wrong-choice { /* Lựa chọn sai của người dùng */
            border-left-color: #dc3545;
            background-color: #fce8e6;
            text-decoration: line-through;
        }
    </style>
</head>
<body>
    <jsp:include page="common/header.jsp"/>

    <div class="container">
        <div class="result-container">
            <div class="text-center">
                <h1 class="mb-3">Kết Quả Bài Trắc Nghiệm</h1>
                <p class="score-text">Chúc mừng bạn đã hoàn thành bài kiểm tra!</p>
                <p class="score">
                    <c:out value="${score}"/> / <c:out value="${totalQuestions}"/>
                </p>
                <p>Bạn đã trả lời đúng <c:out value="${score}"/> trên tổng số <c:out value="${totalQuestions}"/> câu hỏi.</p>

                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/take-quiz?lessonId=${lessonId}" class="btn btn-primary">
                        Làm lại bài này
                    </a>
                    <a href="${pageContext.request.contextPath}/lesson-detail?lessonId=${lessonId}" class="btn btn-secondary">
                        Quay lại bài học
                    </a>
                    <a href="${pageContext.request.contextPath}/lessons" class="btn btn-info">
                        Xem các bài học khác
                    </a>
                </div>
            </div>

            <%-- PHẦN HIỂN THỊ CHI TIẾT KẾT QUẢ --%>
            <div class="review-question">
                <h3 class="text-center">Xem Lại Bài Làm</h3>
                <c:forEach var="result" items="${detailedResults}" varStatus="loop">
                    <div class="review-question">
                        <p>${loop.count}. <c:out value="${result.question.questionText}"/></p>
                        <ul class="list-unstyled">
                            <c:forEach var="option" items="${result.question.options}">
                                <%-- Xác định class CSS cho mỗi lựa chọn --%>
                                <c:set var="optionClass" value=""/>
                                <c:if test="${option.isCorrect}"> <%-- Nếu đây là đáp án đúng --%>
                                    <c:set var="optionClass" value="correct-answer"/>
                                </c:if>
                                <c:if test="${option.optionId == result.selectedOptionId && !option.isCorrect}"> <%-- Nếu đây là lựa chọn sai của người dùng --%>
                                    <c:set var="optionClass" value="wrong-choice"/>
                                </c:if>

                                <li class="p-2 option-item ${optionClass}">
                                    <c:out value="${option.optionText}"/>
                                    <c:if test="${option.optionId == result.selectedOptionId}">
                                        <span class="badge badge-pill badge-dark ml-2">Lựa chọn của bạn</span>
                                    </c:if>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Làm Bài - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .table th {
            background-color: #f8f9fa;
        }
        .score {
            font-weight: bold;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
    <%-- Nhúng header chung và truyền tham số để tô sáng mục menu --%>
    <jsp:include page="common/header.jsp">
         <jsp:param name="activePage" value="quiz-history"/>
    </jsp:include>

    <div class="container mt-4">
        <h2>Lịch Sử Làm Bài Của Bạn</h2>
        <hr>
        
        <%-- Sử dụng choose/when/otherwise để xử lý trường hợp có hoặc không có lịch sử --%>
        <c:choose>
            <c:when test="${not empty quizHistory}">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Bài học</th>
                                <th scope="col">Điểm số</th>
                                <th scope="col">Ngày làm bài</th>
                                <th scope="col">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${quizHistory}" varStatus="loop">
                                <tr>
                                    <th scope="row">${loop.count}</th>
                                    <td><c:out value="${item.lessonTitle}"/></td>
                                    <td class="score"><c:out value="${item.score}"/> / <c:out value="${item.totalQuestions}"/></td>
                                    <td><fmt:formatDate value="${item.attemptedAt}" pattern="HH:mm 'ngày' dd/MM/yyyy"/></td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/take-quiz?lessonId=${item.lessonId}" class="btn btn-sm btn-primary">Làm lại</a>
                                        <a href="${pageContext.request.contextPath}/lesson-detail?lessonId=${item.lessonId}" class="btn btn-sm btn-secondary">Xem lại bài học</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info">
                    <h4 class="alert-heading">Chưa có dữ liệu!</h4>
                    <p>Bạn chưa có lịch sử làm bài nào. Hãy bắt đầu làm một bài quiz để theo dõi tiến độ học tập của mình nhé!</p>
                    <hr>
                    <a href="${pageContext.request.contextPath}/lessons" class="btn btn-primary">Bắt đầu học</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chủ Đề Ngữ Pháp - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .topic-card { margin-bottom: 20px; }
        .topic-card .card-title a { color: #007bff; text-decoration: none; }
        .topic-card .card-title a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp">
        <jsp:param name="activePage" value="grammar"/>
    </jsp:include>

    <div class="container mt-4">
        <h2>Chủ Đề Ngữ Pháp</h2>
        <hr>
        <c:choose>
            <c:when test="${not empty grammarTopicList}">
                <div class="list-group">
                    <c:forEach var="topic" items="${grammarTopicList}">
                        <a href="${pageContext.request.contextPath}/grammar-detail?topicId=${topic.topicId}" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1"><c:out value="${topic.title}"/></h5>
                                <small><fmt:formatDate value="${topic.createdAt}" pattern="dd/MM/yyyy"/></small>
                            </div>
                            <c:if test="${not empty topic.difficultyLevel}">
                                <small class="text-muted">Mức độ: <c:out value="${topic.difficultyLevel}"/></small>
                            </c:if>
                        </a>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="alert alert-info">Hiện chưa có chủ đề ngữ pháp nào.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
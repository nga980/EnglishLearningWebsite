<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:set var="topicTitle" value="${not empty grammarTopic ? grammarTopic.title : 'Chi Tiết Ngữ Pháp'}"/>
    <title><c:out value="${topicTitle}"/> - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .grammar-content, .example-sentences { white-space: pre-wrap; /* Giữ định dạng xuống dòng, khoảng trắng */ }
        .example-sentences { margin-top: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 5px; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">English Learning</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
             <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/lessons">Bài Học</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/vocabulary">Từ Vựng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/grammar">Ngữ Pháp</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <%
                    User loggedInUser = (User) session.getAttribute("loggedInUser");
                    if (loggedInUser != null) {
                %>
                    <li class="nav-item">
                        <span class="navbar-text mr-3">Xin chào, <%= loggedInUser.getFullName() != null && !loggedInUser.getFullName().isEmpty() ? loggedInUser.getFullName() : loggedInUser.getUsername() %>!
                            <% if ("ADMIN".equals(loggedInUser.getRole())) { %> (Admin) <% } %>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-danger" href="${pageContext.request.contextPath}/logout">Đăng Xuất</a>
                    </li>
                <%
                    } else {
                %>
                     <li class="nav-item">
                        <a class="btn btn-outline-primary mr-2" href="${pageContext.request.contextPath}/login.jsp">Đăng Nhập</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-primary" href="${pageContext.request.contextPath}/register.jsp">Đăng Ký</a>
                    </li>
                <%
                    }
                %>
            </ul>
        </div>
    </nav>

    <div class="container mt-4">
        <c:choose>
            <c:when test="${not empty grammarTopic}">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/grammar">Chủ đề ngữ pháp</a></li>
                        <li class="breadcrumb-item active" aria-current="page"><c:out value="${grammarTopic.title}"/></li>
                    </ol>
                </nav>
                <h1><c:out value="${grammarTopic.title}"/></h1>
                <p class="text-muted">
                    Ngày tạo: <fmt:formatDate value="${grammarTopic.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                    <c:if test="${not empty grammarTopic.difficultyLevel}">
                        | Mức độ: <c:out value="${grammarTopic.difficultyLevel}"/>
                    </c:if>
                </p>
                <hr>
                <div class="grammar-content">
                    <c:out value="${grammarTopic.content}" escapeXml="false"/>
                </div>

                <c:if test="${not empty grammarTopic.exampleSentences}">
                    <h4 class="mt-4">Ví dụ minh họa:</h4>
                    <div class="example-sentences">
                        <c:out value="${grammarTopic.exampleSentences}" escapeXml="false"/>
                    </div>
                </c:if>

            </c:when>
            <c:otherwise>
                <div class="alert alert-warning" role="alert">
                    Không tìm thấy thông tin chủ đề ngữ pháp. <a href="${pageContext.request.contextPath}/grammar" class="alert-link">Quay lại danh sách</a>.
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
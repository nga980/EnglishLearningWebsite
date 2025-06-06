<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Lesson"%> <%-- Giữ nguyên theo yêu cầu của bạn --%>
<%@page import="model.User"%>   <%-- Giữ nguyên theo yêu cầu của bạn --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <%-- SỬA LẠI URI CHO JAKARTA EE / TOMCAT 11 --%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %> <%-- SỬA LẠI URI CHO JAKARTA EE / TOMCAT 11 --%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <c:set var="lessonTitle" value="${not empty lesson ? lesson.title : 'Chi Tiết Bài Học'}"/>
    <title><c:out value="${lessonTitle}"/> - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .lesson-content { white-space: pre-wrap; /* Giữ nguyên định dạng xuống dòng và khoảng trắng */ }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp">
        <jsp:param name="activePage" value="lessons"/>
    </jsp:include>

    <div class="container mt-4">
        <c:choose>
            <c:when test="${not empty lesson}">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/lessons">Danh sách bài học</a></li>
                        <li class="breadcrumb-item active" aria-current="page"><c:out value="${lesson.title}"/></li>
                    </ol>
                </nav>
                <h1><c:out value="${lesson.title}"/></h1>
                <p class="text-muted">
                    Ngày tạo: <fmt:formatDate value="${lesson.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                </p>
                <hr>
                <div class="lesson-content">
                    <c:out value="${lesson.content}" escapeXml="false"/>
                </div>
                
                <%-- THÊM PHẦN QUIZ VÀ THÔNG BÁO --%>
                <hr>
                <div class="text-center mt-4">
                    <c:if test="${not empty requestScope.quizMessage}">
                        <div class="alert alert-info">
                            <c:out value="${requestScope.quizMessage}"/>
                        </div>
                    </c:if>
                    
                    <h4>Kiểm tra kiến thức của bạn!</h4>
                    <p>Hãy làm bài trắc nghiệm ngắn để củng cố kiến thức từ bài học này.</p>
                    <a href="${pageContext.request.contextPath}/take-quiz?lessonId=${lesson.lessonId}" class="btn btn-success btn-lg">
                        Làm Bài Trắc Nghiệm
                    </a>
                </div>

            </c:when>
            <c:otherwise>
                <div class="alert alert-warning" role="alert">
                    Không tìm thấy thông tin bài học. <a href="${pageContext.request.contextPath}/lessons" class="alert-link">Quay lại danh sách bài học</a>.
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- THÊM SCRIPT CHO BOOTSTRAP --%>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
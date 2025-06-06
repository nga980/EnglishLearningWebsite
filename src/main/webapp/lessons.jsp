<%@page import="model.User"%> <%-- SỬA Ở ĐÂY: Tên package đầy đủ --%>
<%@page import="model.Lesson"%> <%-- SỬA Ở ĐÂY: Tên package đầy đủ --%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh Sách Bài Học - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .lesson-card { margin-bottom: 20px; }
        .lesson-card .card-title a { color: #007bff; text-decoration: none; }
        .lesson-card .card-title a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp">
        <jsp:param name="activePage" value="lessons"/>
    </jsp:include>

    <div class="container mt-4">
        <h2>Danh Sách Bài Học</h2>
        <hr>
        <c:choose>
            <c:when test="${not empty lessonList}">
                <div class="row">
                    <c:forEach var="lesson" items="${lessonList}">
                        <div class="col-md-12">
                            <div class="card lesson-card">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <a href="${pageContext.request.contextPath}/lesson-detail?lessonId=${lesson.lessonId}">
                                            <c:out value="${lesson.title}" />
                                        </a>
                                    </h5>
                                    <p class="card-text">
                                        <small class="text-muted">
                                            Ngày tạo: <fmt:formatDate value="${lesson.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </small>
                                    </p>
                                    <a href="${pageContext.request.contextPath}/lesson-detail?lessonId=${lesson.lessonId}" class="btn btn-sm btn-primary">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="alert alert-info">Hiện chưa có bài học nào.</p>
            </c:otherwise>
        </c:choose>
        <%--  KHỐI PHÂN TRANG --%>
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <%-- Nút Previous --%>
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/lessons?page=${currentPage - 1}">Trước</a>
                    </li>

                    <%-- Các nút số trang --%>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/lessons?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <%-- Nút Next --%>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/lessons?page=${currentPage + 1}">Sau</a>
                    </li>
                </ul>
            </nav>
        </c:if>        
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
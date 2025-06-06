<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .jumbotron {
            background: url('https://images.unsplash.com/photo-1524178232363-1fb2b075b655?q=80&w=2070&auto=format&fit=crop') no-repeat center center;
            background-size: cover;
            color: white;
            text-shadow: 2px 2px 4px #000000;
        }
        .card-text {
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            min-height: 60px;
        }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp">
        <jsp:param name="activePage" value="home"/>
    </jsp:include>

    <div class="jumbotron jumbotron-fluid">
        <div class="container text-center">
            <h1 class="display-4">Học Tiếng Anh Mỗi Ngày</h1>
            <p class="lead">Nâng cao kỹ năng của bạn với các bài học, từ vựng và bài tập trắc nghiệm đa dạng.</p>
            <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/lessons" role="button">Bắt đầu học ngay</a>
        </div>
    </div>

    <div class="container mt-4">
        <h2>Các bài học mới nhất</h2>
        <hr>
        <c:choose>
            <c:when test="${not empty recentLessonList}">
                <div class="row">
                    <c:forEach var="lesson" items="${recentLessonList}">
                        <div class="col-md-4 mb-4">
                            <div class="card h-100">
                                <%-- Có thể thêm ảnh cho bài học ở đây nếu muốn --%>
                                <%-- <img src="..." class="card-img-top" alt="..."> --%>
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title"><c:out value="${lesson.title}"/></h5>
                                    <p class="card-text">
                                        <%-- Lấy một đoạn ngắn của nội dung để làm mô tả --%>
                                        <c:out value="${lesson.content}"/>
                                    </p>
                                    <a href="${pageContext.request.contextPath}/lesson-detail?lessonId=${lesson.lessonId}" class="btn btn-outline-primary mt-auto">Xem chi tiết</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <p class="alert alert-info">Chưa có bài học nào để hiển thị.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
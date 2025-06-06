<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>       <%-- Giữ nguyên theo yêu cầu của bạn --%>
<%@page import="model.Vocabulary"%> <%-- THÊM IMPORT CHO VOCABULARY (để nhất quán nếu dùng scriptlet) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh Sách Từ Vựng - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .vocab-table th { background-color: #f8f9fa; }
        .vocab-word { font-weight: bold; }
    </style>
</head>
<body>
    <jsp:include page="/common/header.jsp">
        <jsp:param name="activePage" value="vocabulary"/>
    </jsp:include>

    <div class="container mt-4">
        <h2>Danh Sách Từ Vựng</h2>
        <hr>
        <%-- Tùy chọn: Nếu bạn có lọc theo lessonId, bạn có thể hiển thị thông tin bài học đang lọc ở đây --%>
        <%-- <c:if test="${not empty filterLessonId}">
                <h4>Từ vựng cho Bài học ID: <c:out value="${filterLessonId}"/></h4>
            </c:if> --%>

        <c:choose>
            <c:when test="${not empty vocabularyList}">
                <table class="table table-bordered table-hover vocab-table">
                    <thead class="thead-light">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Từ (Word)</th>
                            <th scope="col">Nghĩa (Meaning)</th>
                            <th scope="col">Ví dụ (Example)</th>
                            <th scope="col">Ngày tạo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="vocab" items="${vocabularyList}" varStatus="loop">
                            <tr>
                                <th scope="row">${loop.count}</th>
                                <td class="vocab-word"><c:out value="${vocab.word}"/></td>
                                <td><c:out value="${vocab.meaning}"/></td>
                                <td><c:out value="${vocab.example}"/></td>
                                <td><fmt:formatDate value="${vocab.createdAt}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p class="alert alert-info">Hiện chưa có từ vựng nào.</p>
            </c:otherwise>
        </c:choose>
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/vocabulary?page=${currentPage - 1}">Trước</a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/vocabulary?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/vocabulary?page=${currentPage + 1}">Sau</a>
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
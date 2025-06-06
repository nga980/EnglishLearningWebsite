<%@page import="model.User"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Trang Chủ - English Learning</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="/common/header.jsp">
        <jsp:param name="activePage" value="home"/>
    </jsp:include>

    <div class="container mt-4">
        <h1>Chào mừng đến với Website Học Tiếng Anh!</h1>
        <p>Đây là trang chủ của bạn. Các chức năng khác sẽ được phát triển sau.</p>
        
        <%-- SỬA LẠI ĐOẠN CODE KIỂM TRA ĐĂNG NHẬP BẰNG JSTL --%>
        <c:if test="${empty sessionScope.loggedInUser}">
            <p>Vui lòng <a href="${pageContext.request.contextPath}/login.jsp">đăng nhập</a> hoặc <a href="${pageContext.request.contextPath}/register.jsp">đăng ký</a> để sử dụng đầy đủ các tính năng.</p>
        </c:if>

    </div>

    <%-- Bootstrap JS (cần cho các component như navbar toggler) --%>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
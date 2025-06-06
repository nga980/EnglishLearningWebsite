<%-- File: /common/header.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%> <%-- Import User để có thể lấy thông tin từ session --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">English Learning</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <%-- Các mục điều hướng chính --%>
        <ul class="navbar-nav mr-auto">
            <li class="nav-item ${param.activePage == 'home' ? 'active' : ''}">
                <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang Chủ</a>
            </li>
            <li class="nav-item ${param.activePage == 'lessons' ? 'active' : ''}">
                <a class="nav-link" href="${pageContext.request.contextPath}/lessons">Bài Học</a>
            </li>
            <li class="nav-item ${param.activePage == 'vocabulary' ? 'active' : ''}">
                <a class="nav-link" href="${pageContext.request.contextPath}/vocabulary">Từ Vựng</a>
            </li>
            <li class="nav-item ${param.activePage == 'grammar' ? 'active' : ''}">
                <a class="nav-link" href="${pageContext.request.contextPath}/grammar">Ngữ Pháp</a>
            </li>
        </ul>
        <%-- FORM TÌM KIẾM Ở ĐÂY --%>
        <form class="form-inline mx-auto" action="${pageContext.request.contextPath}/search" method="GET">
            <input class="form-control mr-sm-2" type="search" name="keyword" placeholder="Tìm kiếm bài học, từ vựng..." aria-label="Search" value="<c:out value='${param.keyword}'/>">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Tìm</button>
        </form>    

        <%-- Thông tin người dùng và các nút chức năng --%>
        <ul class="navbar-nav ml-auto">
            <%
                User loggedInUser = (User) session.getAttribute("loggedInUser");
                if (loggedInUser != null) {
                %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span data-feather="user" class="mr-1"></span>
                            <%= loggedInUser.getFullName() != null && !loggedInUser.getFullName().isEmpty() ? loggedInUser.getFullName() : loggedInUser.getUsername() %>
                            <% if ("ADMIN".equals(loggedInUser.getRole())) { %> (Admin) <% } %>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">Hồ sơ của tôi</a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/quiz-history">Lịch sử học tập</a>
                            <% if ("ADMIN".equals(loggedInUser.getRole())) { %>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/dashboard">Trang quản trị</a>
                            <% } %>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                        </div>
                    </li>
                <%} else {
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
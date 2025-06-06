<%-- File: /common/header.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%> <%-- Import User để có thể lấy thông tin từ session --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">English Learning</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <%-- Các mục điều hướng chính --%>
        <ul class="navbar-nav mr-auto">
            <li class="nav-item ${param.activePage == 'home' ? 'active' : ''}">
                <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Trang Chủ</a>
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

        <%-- Thông tin người dùng và các nút chức năng --%>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 현재 세션 무효화
    session.invalidate();

    // 로그인 상태를 표시하는 쿠키 삭제 (선택적)
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("isLogin")) {
                Cookie logoutCookie = new Cookie("isLogin", "");
                logoutCookie.setMaxAge(0); // 쿠키 삭제
                response.addCookie(logoutCookie);
            }
        }
    }

    // 로그인 페이지로 리다이렉트
    response.sendRedirect("index.jsp?page=login_page");
%>

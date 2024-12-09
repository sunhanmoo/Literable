<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    String dbUrl = "jdbc:mysql://localhost:3306/literable";
    String dbUser = "root";
    String dbPass = "Abcd123@";
    boolean withdrawSuccess = false;

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        // 세션에서 사용자 ID 가져오기
        Integer userId = (Integer) session.getAttribute("id");

        if (userId != null) {
            // 회원정보 삭제
            String query = "DELETE FROM User WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                withdrawSuccess = true;
            }

            stmt.close();
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (withdrawSuccess) {
        // 세션 무효화
        session.invalidate();

     // 로그인 상태를 표시하는 쿠키 삭제 (선택적)
     Cookie[] cookies = request.getCookies();
     if (cookies != null) {
         for (Cookie cookie : cookies) {
             if (cookie.getName().equals("isLogin")) {
                 Cookie withdrawCookie = new Cookie("isLogin", "");
                 withdrawCookie.setMaxAge(0); // 쿠키 삭제
                 response.addCookie(withdrawCookie);
             }
         }
     }

     // 탈퇴 완료 페이지 또는 로그인 페이지로 이동
        response.sendRedirect("index.jsp?page=login_page");
    } else {
        // 탈퇴 실패 처리
        request.setAttribute("errorMessage", "회원탈퇴에 실패했습니다. 다시 시도해주세요.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("withdraw_page.jsp");
        dispatcher.forward(request, response);
    }
%>

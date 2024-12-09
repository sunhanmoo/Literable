<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    String dbUrl = "jdbc:mysql://localhost:3306/literable";
    String dbUser = "root";
    String dbPass = "Abcd123@";
    boolean loginSuccess = false;
    String id = "";

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String query = "SELECT * FROM User WHERE userId = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            loginSuccess = true;
            id = rs.getString("id"); // 유저의 ID 저장
            out.println(id); // 디버깅용 출력

            // id를 int로 변환하여 세션에 저장
            int userId = Integer.parseInt(id); // 문자열을 int로 변환
            session.setAttribute("id", userId); // 유저 ID를 세션에 설정
            
            // 로그인 성공 시 쿠키 설정
            Cookie loginCookie = new Cookie("isLogin", "true");
            loginCookie.setMaxAge(60 * 60 * 24); // 쿠키 유효 기간 1일
            response.addCookie(loginCookie);
        }

        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 로그인 성공 시 index.jsp로 리디렉션
    if (loginSuccess) {
        response.sendRedirect("index.jsp?page=main_page"); // id를 URL 파라미터로 전달하지 않음
    } else {
        // 로그인 실패 시 에러 메시지를 request에 설정
 		System.out.print("오류");
        request.setAttribute("errorMessage", "아이디 또는 비밀번호를 확인하여 다시 입력해주세요.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
%>
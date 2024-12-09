<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String dbUrl = "jdbc:mysql://localhost:3306/literable"; 
    String dbUser = "root";
    String dbPass = "Abcd123@";
    String action = request.getParameter("action");

    if ("checkDuplicate".equals(action)) {
        String field = request.getParameter("field"); // username 또는 nickname
        String value = request.getParameter("value");

        // 디버깅 로그 추가
        System.out.println("Received action: " + action);
        System.out.println("Received field: " + field);
        System.out.println("Received value: " + value);

        boolean isDuplicate = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            String query = "";
            if ("username".equals(field)) {
                query = "SELECT COUNT(*) FROM User WHERE userId = ?";
            } else if ("nickname".equals(field)) {
                query = "SELECT COUNT(*) FROM User WHERE nickname = ?";
            }

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, value);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int count = rs.getInt(1);
                isDuplicate = count > 0;
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("Field: " + field + ", Value: " + value);
        System.out.println("IsDuplicate: " + isDuplicate);
        out.print(isDuplicate); // 중복 여부 반환
        return; // 중복 확인 완료 후 더 이상 실행하지 않음
    }

    // 회원가입 로직
    boolean connect = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");
        String interest1 = request.getParameter("interest1");
        String interest2 = request.getParameter("interest2");

        String query = "INSERT INTO User (userId, password, nickname, interest_category1, interest_category2) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);
        stmt.setString(3, nickname);
        stmt.setString(4, interest1);
        stmt.setString(5, interest2);

        int result = stmt.executeUpdate();
        if (result > 0) {
            connect = true;
            response.sendRedirect("index.jsp?page=login_page"); // 회원가입 성공 시 로그인 페이지로 리디렉션
        }

        stmt.close();
        conn.close();
    } catch (Exception e) {
        connect = false;
        out.print(e);
    }
%>

<html>
<head></head>
<body>
    <% if (connect) { %>
        <p>회원가입이 완료되었습니다. 로그인 페이지로 이동합니다...</p>
    <% } else { %>
        <p>회원가입에 실패하였습니다.</p>
    <% } %>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리터러블</title>
    <link rel="icon" href="./assets/header_logo.svg" type="image/x-icon">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 0;
            padding: 0;
        }
        #header {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
            padding: 20px;
            font-size: 18px;
            color: #5C6C7E;
        }
        .headerDiv {
            display: flex;
            gap: 40px;
            margin-left: 320px;
            margin-right: 214px;
        }
        #he1_header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            max-width: 1200px;
            padding: 20px;
        }
        #he1_header img {
            height: 40px;
        }
        .he1_nav-links {
            display: flex;
            gap: 40px;
            font-size: 18px;
            color: #5C6C7E;
        }
        .he1_nav-links a {
            text-decoration: none;
            color: #5C6C7E;
            font-weight: 700;
        }
        .he1_auth-buttons {
            display: flex;
            gap: 10px;
        }
        .he1_login-btn, .he1_signup-btn {
            height: 43px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
        }
        .he1_login-btn {
            width: 94px;
            background-color: #FFFFFF;
            color: #5C6C7E;
            border: 1px solid #67696A;
        }
        .he1_signup-btn {
            width: 111px;
            background-color: #9B7EBD;
            color: white;
        }
        img {
            margin-right: 20px;
        }
        .isLoginSection {
            font-size: 18px;
            color: #3B1E54;
            text-align: center;
        }
        .highlight {
            color: #965CB6;
        }
        a {
            text-decoration: none;
            font-size: 18px;
            color: #5C6C7E;
            font-weight: 700;
            line-height: 150%;
        }
        footer {
            width: 1440px;
            padding: 10px;
            border-top: 0.3px solid #000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        #footer_p {
            margin: 0;
            color: #535353;
            font-size: 12px;
            font-weight: 300;
        }
    </style>
    <script>
        window.onload = function() {
            const currentPath = window.location.search;
            const items = document.querySelectorAll('.headerDiv a');
            
            items.forEach(item => item.classList.remove('highlight'));

            // URL에 따라 하이라이트 설정
            if (currentPath === '' || currentPath.includes('page=main_page')) {
                items[0].classList.add('highlight'); // Home 하이라이트
            } else if (currentPath.includes('page=article_page')) {
                items[1].classList.add('highlight'); // Article 하이라이트
            } else if (currentPath.includes('page=quiz_page')||currentPath.includes('page=quiz_result_page')) {
                items[2].classList.add('highlight'); // Quiz 하이라이트
            } else if (currentPath.includes('page=mypage_page')||currentPath.includes('page=withdraw_page')) {
                items[3].classList.add('highlight'); // My Page 하이라이트
            }
        };
    </script>
</head>
<body>
<%
    String pageUrl = request.getParameter("page");
    String articleId = request.getParameter("id");
    boolean isLogin = false;
    String nickname = ""; // 닉네임을 저장할 변수

    // 쿠키 검사
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("isLogin") && cookie.getValue().equals("true")) {
                isLogin = true;
                break;
            }
        }
    }

    // 로그인 상태에 따라 페이지 설정 및 닉네임 가져오기
    if (isLogin) {
        // 세션에서 userId 가져오기
        Integer userId = (Integer) session.getAttribute("id");

        // userId가 null일 경우 기본값 설정 (예: 1)
        if (userId == null) {
            userId = 1; // 기본값 설정
            session.setAttribute("id", userId);
        }

        // 데이터베이스에서 닉네임 가져오기
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
            conn = DriverManager.getConnection(dbUrl, "root", "Abcd123@");

            // 사용자 정보 가져오기
            String sql = "SELECT nickname FROM User WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                nickname = rs.getString("nickname"); // 닉네임 저장
            }
        } catch (SQLException e) {
            out.println("DB 연동 오류입니다. : " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("DB 드라이버 오류입니다. : " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
        if (articleId != null && !articleId.isEmpty()) {
            pageUrl = "article_detail_page";
        } else if (pageUrl == null || pageUrl.isEmpty()) {
            pageUrl = "main_page";
        }
    } else {
        if (pageUrl == null || "login_page".equals(pageUrl)) {
            pageUrl = "login_page"; 
        } else {
            pageUrl = "signup_page"; 
        }
    }

    System.out.println("pageUrl: " + pageUrl);
%>

    <div id="header">
        <%
            if (isLogin) { // 로그인 상태일 때
        %>
            <a href="index.jsp?page=main_page">
                <img src="./assets/header_logo.svg" alt="logo"/>
            </a>
            <div class="headerDiv">
                <a href="index.jsp?page=main_page">Home</a>
                <a href="index.jsp?page=article_page">아티클</a>
                <a href="index.jsp?page=quiz_page">퀴즈</a>
                <a href="index.jsp?page=mypage_page">마이페이지</a>
            </div>
            <p class="isLoginSection"><%= nickname %>님, 안녕하세요!</p>
        <%
            } else {
        %>
            <header id="he1_header">
                <img src="./assets/header_logo.svg" alt="로고">
                <div class="he1_auth-buttons">
                    <button class="he1_login-btn" onclick="location.href='index.jsp'">로그인</button>
                    <button class="he1_signup-btn" onclick="location.href='index.jsp?page=signup_page'">회원가입</button>
                </div>
            </header>
        <%
            }
        %>
    </div>

    <main>
        <%
            String includePage = pageUrl + ".jsp";
        %>
        <jsp:include page="<%= includePage %>" />
    </main>

    <footer>
    	<a href="landing_page.jsp">
    		<p id="footer_p">리터러블을 만든이 | 리터러블과 함께하는 여정</p>
    	</a>
        <p id="footer_p">@webprogramming web🕸️ team</p>
    </footer>
</body>
</html>
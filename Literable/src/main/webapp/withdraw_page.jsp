<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
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
        #he2_mypage-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 50px;
            width: 960px;
            margin: 50px auto;
            margin-bottom: 523px;
        }
        #he2_sidebar {
            width: 200px;
            font-size: 18px;
            color: #5C6C7E;
            margin-right: 100px;
        }
        #he2_sidebar h3 {
            font-size: 30px;
            font-weight: 700;
            color: #333;
            margin-bottom: 20px;
        }
        #he2_sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        #he2_sidebar ul li {
            margin: 10px 0;
        }
        #he2_sidebar ul li:first-child {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        #he2_sidebar ul li a {
            text-decoration: none;
            color: inherit;
            font-weight: 500;
        }
        #he2_main-content {
            flex: 1;
            background-color: #fff;
            padding: 30px;
        }
        .he2_withdraw-section {
            text-align: left;
        }
        .he2_withdraw-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 20px;
        }
        .he2_withdraw-subtitle {
            font-size: 24px;
            font-weight: 500;
            color: #965CB6;
            margin-bottom: 10px;
        }
        .he2_withdraw-description {
            font-size: 16px;
            font-weight: 400;
            color: #5C6C7E;
            margin-bottom: 30px;
        }
        .he2_withdraw-button {
            padding: 10px 30px;
            border-radius: 30px;
            background-color: #735177;
            width: 224px;
            height: 48px;
            color: #FFFFFF;
            font-size: 25px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            display: block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div id="he2_mypage-container">
        <div id="he2_sidebar">
            <h3>마이페이지</h3>
            <ul>
                <li>회원관리</li>
                <li><a href="logout_process.jsp" style="text-decoration: none; color: inherit;">- 로그아웃</a></li>
                <li><a href="withdraw_page.jsp" style="font-weight: bold;">- 회원탈퇴</a></li>
            </ul>
        </div>
        <div id="he2_main-content">
            <div class="he2_withdraw-section">
                <% 
                    // 세션에서 닉네임 가져오기
                    String nickname = (String) session.getAttribute("nickname");
                    if (nickname == null || nickname.isEmpty()) {
                        nickname = "회원"; // 기본값 설정
                    }
                %>
                <h1 class="he2_withdraw-title"><%= nickname %>님,<br>탈퇴하시겠습니까?</h1>
                <p class="he2_withdraw-subtitle">리터러블 탈퇴 전 확인하세요!</p>
                <p class="he2_withdraw-description">탈퇴하시면 이용 중인<br>모든 데이터는 복구가 불가능합니다.</p>
                <button class="he2_withdraw-button" onclick="location.href='withdraw_process.jsp'">탈퇴하기</button>
            </div>
        </div>
    </div>
</body>
</html>
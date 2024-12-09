<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #FFFFFF;
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
        #he1_login_section {
        	display: flex;
        	flex-direction: column;
        	justify-content: center;
        	align-items: center;
        	margin-top: 207px;
        }
        .he1_login-title {
            margin-bottom: 40px;
            font-size: 36px;
            font-weight: bold;
            text-align: center;
        }
        .he1_login-form {
            width: 100%;
            max-width: 440px;
        }
        .he1_form-group {
            margin-bottom: 20px;
        }
        .he1_form-group label {
            display: block;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 9px;
        }
        .he1_form-group input {
            width: 440px;
            height: 37px;
            border: none;
            border-bottom: 1px solid #D1D5DB;
            padding: 8px;
            font-size: 16px;
            box-sizing: border-box;
            color: #6B6B6B;
        }
        .he1_form-group input::placeholder {
            font-size: 16px;
            color: #6B6B6B;
            font-weight: 400;
        }
        .he1_form-group input:focus {
            outline: none;
            border-bottom: 2px solid #9B7EBD;
        }
        .he1_login-submit {
            margin-top: 58px; /* 로그인 버튼과 비밀번호 입력창 사이의 간격 */
            display: flex;
            justify-content: center;
        }
        .he1_login-submit button {
            width: 224px;
            height: 48px;
            background-color: #735177;
            color: white;
            border: none;
            border-radius: 30px;
            font-size: 25px;
            font-weight: 600;
            cursor: pointer;
        }
        .he1_signup-link {
            margin-top: 13px; /* 회원가입 버튼과 로그인 버튼 사이의 간격 */
            text-align: center;
        }
        .he1_signup-link a {
            font-size: 18px;
            color: #6B6B6B;
            text-decoration: none;
            border-bottom: 1px solid #6B6B6B;
        }
        .error-message {
            font-size: 15px;
            font-weight: 500;
            color: #FF3333;
            text-align: center;
            margin-top: 10px;
        }
        footer {
            width: 1150px;
            padding: 11px;
            border-top: 0.3px solid #000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        #footer_p {
            margin: 0;
            color: #535353;
            text-align: center;
            font-size: 12px;
            font-style: normal;
            font-weight: 300;
            line-height: normal;
        }
    </style>
</head>
<body>
    <main id="he1_login_section">
        <h1 class="he1_login-title">로그인</h1>
        <form class="he1_login-form" action="login_process.jsp" method="POST">
            <div class="he1_form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" name="username" placeholder="아이디를 입력해주세요" required>
            </div>
            <div class="he1_form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요" required>
            </div>
            
            <% 
                String errorMessage = request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage").toString() : "";
                if (!errorMessage.isEmpty()) { 
            %>
                <div class="error-message">
                    아이디 또는 비밀번호를 확인하여 다시 입력해주세요.
                </div>
            <% } %>

            <div class="he1_login-submit">
                <button type="submit">로그인</button>
            </div>
            <div class="he1_signup-link" style="margin-top: 13px; margin-bottom: 265px;">
                <a href="index.jsp?page=signup_page">회원가입</a>
                
            </div>
        </form>
    </main>
</body>
</html>

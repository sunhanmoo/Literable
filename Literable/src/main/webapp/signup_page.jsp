<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
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
        .he_signup-title {
            margin-top: 40px;
            margin-bottom: 40px;
            font-size: 36px;
            font-weight: bold;
            text-align: center;
        }
        .he_form-title {
            display: flex;
            align-items: center;
            font-size: 25px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .he_form-title .he_required-star {
            font-size: 20px;
            font-weight: 300;
            color: #FF6F6F;
            margin-left: 217px;
        }
        .he_form-title .he_required-text {
            font-size: 13px;
            font-weight: 300;
            color: #000000;
            margin-left: 5px;
        }
        .he_form-group {
            margin-bottom: 20px;
            position: relative;
        }
        .he_form-group label {
            display: flex;
            align-items: center;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .he_form-group label .he_required-star {
            font-size: 20px;
            color: #FF6F6F;
            font-weight: 300;
            margin-left: 6px;
        }
        .he_form-group input {
            width: 100%;
            height: 40px;
            border: none;
            border-bottom: 1px solid #D1D5DB;
            padding: 8px;
            padding-right: 100px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .he_form-group input:focus {
            outline: none;
            border-bottom: 2px solid #9B7EBD;
        }
        .he_form-group select {
            width: 385px;
            height: 42px;
            border: 1px solid #D1D5DB;
            border-radius: 10px;
            padding: 8px;
            font-size: 16px;
            box-sizing: border-box;
            background-color: #FFFFFF;
            color: #6B6B6B;
        }
        .he_form-group button {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-20%);
            width: 89px;
            height: 33px;
            padding: 0 12px;
            background-color: rgba(209, 181, 215, 0.6);
            color: #000000;
            border: none;
            border-radius: 40px;
            font-size: 16px;
            cursor: pointer;
        }
        .he_form-submit {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .he_form-submit button {
            background-color: #735177;
            color: white;
            width: 224px;
            height: 48px;
            border: none;
            border-radius: 30px;
            font-size: 25px;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
    <script>
        function validateForm() {
            const username = document.getElementById('username').value;
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const nickname = document.getElementById('nickname').value;

            if (!/^[a-zA-Z0-9]{7,20}$/.test(username)) {
                alert('아이디는 영문과 숫자를 조합하여 7~20자 이내로 입력하세요.');
                return false;
            }

            if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test(password)) {
                alert('비밀번호는 최소 8자 이상이고, 영문과 숫자를 포함해야 합니다.');
                return false;
            }

            if (password !== confirmPassword) {
                alert('비밀번호가 일치하지 않습니다.');
                return false;
            }

            if (!/^[가-힣a-zA-Z0-9]+$/.test(nickname)) {
                alert('닉네임은 공백 없이 입력하세요.');
                return false;
            }

            return true;
        }

        function checkDuplicate(field) {
            const value = document.getElementById(field).value.trim();
            if (!value) {
                alert(field === 'username' ? '아이디를 입력하세요.' : '닉네임을 입력하세요.');
                return;
            }

            // URL에 action, field, value 포함
            const url = 'signup_process.jsp?action=checkDuplicate&field=' + field + '&value=' + encodeURIComponent(value);
            console.log("중복 확인 요청 URL:", url);

            fetch(url)
                .then(response => response.text())
                .then(data => {
                    console.log("서버 응답 데이터:", data.trim());
                    if (data.trim() === 'true') {
                        alert(field === 'username' ? '이미 사용 중인 아이디입니다.' : '이미 사용 중인 닉네임입니다.');
                    } else {
                        alert(field === 'username' ? '사용 가능한 아이디입니다.' : '사용 가능한 닉네임입니다.');
                    }
                })
                .catch(err => console.error('중복 확인 에러:', err));
        }
    </script>
</head>
<body>
    <main>
    <div class="he_signup-title">
        회원가입
    </div>
    <div class="he_form-container">
        <div class="he_form-title">
            회원정보
            <span class="he_required-star">*</span>
            <span class="he_required-text">필수입력사항</span>
        </div>
        <form action="signup_process.jsp" method="POST" onsubmit="return validateForm()">
            <div class="he_form-group">
                <label for="username">아이디 <span class="he_required-star">*</span></label>
                <input type="text" id="username" name="username" placeholder="영문, 숫자를 조합하여 7-20자" required>
               <button type="button" onclick="checkDuplicate('username')">중복확인</button>
            </div>
            <div class="he_form-group">
                <label for="password">비밀번호 <span class="he_required-star">*</span></label>
                <input type="password" id="password" name="password" placeholder="영문, 숫자 최소 8자 이상" required>
            </div>
            <div class="he_form-group">
                <label for="confirm-password">비밀번호 확인 <span class="he_required-star">*</span></label>
                <input type="password" id="confirm-password" name="confirm-password" placeholder="비밀번호 다시 입력" required>
            </div>
            <div class="he_form-group" style="margin-bottom: 47px;">
                <label for="nickname">닉네임 <span class="he_required-star">*</span></label>
                <input type="text" id="nickname" name="nickname" placeholder="닉네임" required>
                <button type="button" onclick="checkDuplicate('nickname')">중복확인</button>
            </div>
            <h2 class="he_form-title">관심 주제 등록</h2>
            <div class="he_form-group">
                <label for="interest1">관심 주제1 <span class="he_required-star">*</span></label>
                <select id="interest1" name="interest1" required>
                    <option value="">아티클 카테고리</option>
                    <option value="dev">자기개발</option>
                    <option value="edu">교육</option>
                    <option value="beauty">뷰티</option>
                    <option value="game">게임</option>
                    <option value="cook">요리</option>
                    <option value="code">코딩</option>
                    <option value="culture">문화</option>
                    <option value="health">건강</option>
                    <option value="show">전시회</option>
                    <option value="art">그림</option>
                    <option value="travel">여행</option>
                    <option value="science">과학</option>
                </select>
            </div>
            <div class="he_form-group" style="margin-bottom: 67px;">
                <label for="interest2">관심 주제2 <span class="he_required-star">*</span></label>
                <select id="interest2" name="interest2" required>
                    <option value="">아티클 카테고리</option>
                    <option value="dev">자기개발</option>
                    <option value="edu">교육</option>
                    <option value="beauty">뷰티</option>
                    <option value="game">게임</option>
                    <option value="cook">요리</option>
                    <option value="code">코딩</option>
                    <option value="culture">문화</option>
                    <option value="health">건강</option>
                    <option value="show">전시회</option>
                    <option value="art">그림</option>
                    <option value="travel">여행</option>
                    <option value="science">과학</option>
                </select>
            </div>
            <div class="he_form-submit" style="margin-bottom: 54px;">
                <button type="submit">회원가입</button>
            </div>
        </form>
    </div>
</main>
</body>
</html>
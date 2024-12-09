<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // GET 요청으로 전달된 URL 파라미터 값 가져오기
    String articleIdParam = request.getParameter("articleId");
    String userOxAnswer = request.getParameter("ox_answer");
    String userBlankA = request.getParameter("blankA");
    String userBlankB = request.getParameter("blankB");

    

    Integer articleId = null;

    // articleId 검증 및 파싱
    try {
        if (articleIdParam != null && !articleIdParam.trim().isEmpty()) {
            articleId = Integer.parseInt(articleIdParam);
        } else {
            throw new IllegalArgumentException("articleId가 유효하지 않습니다.");
        }
    } catch (NumberFormatException e) {
        out.println("<p>잘못된 숫자 형식의 articleId: " + articleIdParam + "</p>");
        return;
    } catch (IllegalArgumentException e) {
        out.println("<p>오류: " + e.getMessage() + "</p>");
        return;
    }

    // DB 연결 정보
    String url = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "Abcd123@";
	
    // 초기값 설정
    String articleTitle = "제목 없음";
    String author = "작성자 없음";
    String date = "날짜 없음";
    String category = "카테고리 없음";
    String oxQuizContent = "OX 문제 없음";
    String blankQuizContent = "빈칸 채우기 문제 없음";
    String oxAnswer = "false"; // Default value
    String correctBlankA = "모름";
    String correctBlankB = "모름";

    try (Connection connection = DriverManager.getConnection(url, dbUser, dbPassword)) {
        // Article 데이터 가져오기
        String articleQuery = "SELECT article_title, author, date, category FROM Article WHERE id = ?";
        try (PreparedStatement articlePs = connection.prepareStatement(articleQuery)) {
            articlePs.setInt(1, articleId);
            try (ResultSet articleRs = articlePs.executeQuery()) {
                if (articleRs.next()) {
                    articleTitle = articleRs.getString("article_title");
                    author = articleRs.getString("author");
                    date = articleRs.getString("date");
                    category = articleRs.getString("category");
                }
            }
        }

        // OX 퀴즈 데이터 가져오기
        String oxQuizQuery = "SELECT quiz_content, ox_answer FROM Quiz WHERE article_id = ? AND question_type = 'ox' LIMIT 1";
        try (PreparedStatement oxQuizPs = connection.prepareStatement(oxQuizQuery)) {
            oxQuizPs.setInt(1, articleId);
            try (ResultSet oxQuizRs = oxQuizPs.executeQuery()) {
                if (oxQuizRs.next()) {
                    oxQuizContent = oxQuizRs.getString("quiz_content");
                    oxAnswer = oxQuizRs.getString("ox_answer");
                }
            }
        }

        // 빈칸 채우기 퀴즈 데이터 가져오기
        String blankQuizQuery = "SELECT quiz_content, blank1_answer, blank2_answer FROM Quiz WHERE article_id = ? AND question_type = 'blank' LIMIT 1";
        try (PreparedStatement blankQuizPs = connection.prepareStatement(blankQuizQuery)) {
            blankQuizPs.setInt(1, articleId);
            try (ResultSet blankQuizRs = blankQuizPs.executeQuery()) {
                if (blankQuizRs.next()) {
                    blankQuizContent = blankQuizRs.getString("quiz_content");
                    correctBlankA = blankQuizRs.getString("blank1_answer");
                    correctBlankB = blankQuizRs.getString("blank2_answer");
                }
            }
        }
    } catch (SQLException e) {
        out.println("<p>오류: " + e.getMessage() + "</p>");
        return;
    }

    // 사용자 입력값 매핑 (true/false → o/x)
    String mappedOxAnswer = null;
    if ("true".equalsIgnoreCase(userOxAnswer)) {
        mappedOxAnswer = "o";
    } else if ("false".equalsIgnoreCase(userOxAnswer)) {
        mappedOxAnswer = "x";
    }

    // 정답 여부 확인
    boolean isOxCorrect = mappedOxAnswer != null && mappedOxAnswer.equalsIgnoreCase(oxAnswer);
    boolean isBlankACorrect = userBlankA != null && userBlankA.equalsIgnoreCase(correctBlankA);
    boolean isBlankBCorrect = userBlankB != null && userBlankB.equalsIgnoreCase(correctBlankB);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>퀴즈 결과 페이지</title>
    <style>
        /* Global Styles */
        body {
            font-family: 'Pretendard';
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            margin: 0;
            padding: 0;
        }
        .kgw_frame {
            width: 800px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }
        .kgw_submit {
            display: flex;
            width: 160px;
            height: 48px;
            align-items: center;
            justify-content: center;
            background-color: #9b7ebd;
            border-radius: 30px;
            margin: 20px 0;
            font-size: 20px;
        }
        .kgw_submit a {
            font-weight: 600;
            color: #ffffff;
            font-size: 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            width: 100%;
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        /* Article Detail Styles */
        .kgw_frame {
            width: 900px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
        }
        .kgw_titleBox {
            width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: flex-start;
            gap: 16px;
        }
        .kgw_iconBox {
            width: 64px;
            margin-left: 11px;
            margin-top: 4px;
        }
        #kgw_icon {
            width: 64px;
        }
        .kgw_title {
            font-family: 'Pretendard';
            font-weight: 600;
            color: #3b1e54;
            font-size: 54px;
            letter-spacing: -5.4px;
        }
        .kgw_detail {
            width: 100%;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center; 
            gap: 12px;
            font-size: 20px;
        }
        .kgw_author {
            font-weight: 800;
            color: #000;
        }
        .kgw_divider {
            color: #000; 
        }
        .kgw_date {
            color: #000;
            font-weight: 400;
            font-size: 16px;
        }
        .kgw_theme {
            border-radius: 30px;
            background-color: #E3D2E7;
            color: #630C92;
            font-size: 16px;
            font-weight: 400;
            padding: 4px 16px;
        }
        /* Quiz Result Styles */
        .kgw_rowQ {
            width: 100%;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
            justify-content: flex-start;
            padding-left: 10px;
            height: auto;
            margin-top: 30px;
            margin-bottom: 12px;
        }
        .kgw_qnum {
            color: #6B6B6B;
            font-size: 24px;
            font-weight: 600;
        }
        .kgw_O {
            width: 160px;
            font-size: 24px;
            font-weight: 800;
            color: #630C92;
        }
        .kgw_X{
        	width: 160px;
            color: #000000;
            font-size: 24px;
            font-weight: 800;
        }
        .kgw_question {
            width: 100%;
            height: fit-content;
            display: flex;
            flex-direction: row;
            justify-self: flex-start;
            text-align: left;
            align-items: center;
            font-size: 24px;
            font-weight: 600;
            color: #000; 
            padding-left: 10px;
            margin-bottom: 18px;
        }
        .kgw_Box{
            width: 800px;
            min-height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            margin-top: 20px;
        }
        .kgw_line {
            width: 100%;
            color: #9a9a9a;
        }
        .kgw_answerBox {
            width: 800px;
            border-radius: 18px;
            background-color: #ECE7F5;
            padding: 20px 25px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 20px;
            margin-top: 12px;
        }
        .kgw_Arow {
            width: 100%;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
        }
        #kgw_ATtitle {
            font-size: 22px;
            font-weight: 800;
        }
        #kgw_AAnswer {
            font-size: 16px;
            font-weight: 400;
        }
        .kgw_ADetail {
            font-size: 16px;
            line-height: 1.5;
        }
    </style>
</head>
<body>
    <main>
        <div class="kgw_frame">
            <!-- Article 정보 표시 -->
            <div class="kgw_titleBox">
                <div class="kgw_iconBox">
                    <img id="kgw_icon" src="./assets/q_icon.svg" alt="Quiz Icon">
                </div>
                <div class="kgw_title"><%= articleTitle %></div>
            </div>
            <div class="kgw_detail">
                <p class="kgw_author"><%= author %></p>
                <p class="kgw_divider">|</p>
                <p class="kgw_date"><%= date %></p>
                <p class="kgw_theme"><%= category %></p>
            </div>

            <!-- OX 퀴즈 결과 -->
            <div class="kgw_Box">
                <div class="kgw_rowQ" style="color: <%= isOxCorrect ? "#630C92" : "#000000" %>;">
                    <div class="kgw_qnum" style="color: <%= isOxCorrect ? "#630C92" : "#000000" %>;">Q1</div>
                    <% if (isOxCorrect) { %>
                        <div class="kgw_O">👏 정답입니다.</div>
                    <% } else { %>
                        <div class="kgw_X">❌ 오답입니다.</div>
                    <% } %>
                </div>
                <div class="kgw_question"  style="color: <%= isOxCorrect ? "#630C92" : "#000000" %>;"><%= oxQuizContent %></div>
                <hr class="kgw_line">
                
                <div class="kgw_answerBox">
                    <div class="kgw_Arow">
                        <div id="kgw_ATtitle">사용자 답</div>
                        <div id="kgw_AAnswer"><%= mappedOxAnswer != null ? (mappedOxAnswer.equalsIgnoreCase("o") ? "O" : "X") : "응답 없음" %></div>
                    </div>
                    <div class="kgw_Arow">
                        <div id="kgw_ATtitle">정답</div>
                        <div id="kgw_AAnswer"><%= oxAnswer.equalsIgnoreCase("o") ? "O" : "X" %></div>
                    </div>
                </div>
            </div>

            <!-- 빈칸 채우기 결과 -->
            <div class="kgw_Box">
                <div class="kgw_rowQ" style="color: <%= isBlankACorrect && isBlankBCorrect ? "#630C92" : "#000000" %>;">
                    <div class="kgw_qnum" style="color: <%= isBlankACorrect && isBlankBCorrect ? "#630C92" : "#000000" %>;">Q2</div>
                    <% if (isBlankACorrect && isBlankBCorrect) { %>
                        <div class="kgw_O">👏 정답입니다.</div>
                    <% } else { %>
                        <div class="kgw_X">❌ 오답입니다.</div>
                    <% } %>
                </div>
                <div class="kgw_question"  style="color: <%= isBlankACorrect && isBlankBCorrect ? "#630C92" : "#000000" %>;"><%= blankQuizContent %></div>
                <hr class="kgw_line">
                <div class="kgw_answerBox">
                    <div class="kgw_Arow">
                        <div id="kgw_ATtitle">사용자 답</div>
                        <div id="kgw_AAnswer">A: <%= userBlankA != null ? userBlankA : "응답 없음" %>, B: <%= userBlankB != null ? userBlankB : "응답 없음" %></div>
                    </div>
                    <div class="kgw_Arow">
                        <div id="kgw_ATtitle">정답</div>
                        <div id="kgw_AAnswer">A: <%= correctBlankA %>, B: <%= correctBlankB %></div>
                    </div>
                </div>
            </div>

            <!-- 돌아가기 버튼 -->
            <div class="kgw_submit">
                <a href="index.jsp?page=article_page">아티클 페이지로</a>
            </div>
        </div>
    </main>
</body>
</html>

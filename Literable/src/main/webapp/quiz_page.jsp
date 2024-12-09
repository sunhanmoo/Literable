<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Retrieve parameters from POST request
    String articleIdParam = request.getParameter("articleId");
    String userOxAnswer = request.getParameter("ox_answer");
    String userBlankA = request.getParameter("blankA");
    String userBlankB = request.getParameter("blankB");

    Integer articleId = null;
    try {
        if (articleIdParam != null && !articleIdParam.trim().isEmpty()) {
            articleId = Integer.parseInt(articleIdParam);
        } else {
            throw new IllegalArgumentException("articleId가 유효하지 않습니다.");
        }
    } catch (NumberFormatException e) {
        out.println("<p>잘못된 숫자 형식의 articleId: " + articleIdParam + "</p>");
        return; // 더 이상 진행하지 않음
    } catch (IllegalArgumentException e) {
        out.println("<p>오류: " + e.getMessage() + "</p>");
        return; // 더 이상 진행하지 않음
    }

    // DB connection info
    String url = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "Abcd123@";

    // Variables to store article and quiz details
    String articleTitle = "제목 없음";
    String author = "작성자 없음";
    String date = "날짜 없음";
    String category = "카테고리 없음";
    String oxQuizTitle = "OX 퀴즈 제목 없음";
    String oxQuizContent = "OX 문제 없음";
    String oxAnswer = "false"; // Default value
    String blankQuizContent = "빈칸 채우기 문제 없음";
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
        String oxQuizQuery = "SELECT quiz_title, quiz_content, ox_answer FROM Quiz WHERE article_id = ? AND question_type = 'ox' LIMIT 1";
        try (PreparedStatement oxQuizPs = connection.prepareStatement(oxQuizQuery)) {
            oxQuizPs.setInt(1, articleId);
            try (ResultSet oxQuizRs = oxQuizPs.executeQuery()) {
                if (oxQuizRs.next()) {
                    oxQuizTitle = oxQuizRs.getString("quiz_title");
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

    // Check if the user's answers are correct
    boolean isOxCorrect = userOxAnswer != null && userOxAnswer.equalsIgnoreCase(oxAnswer);
    boolean isBlankACorrect = userBlankA != null && userBlankA.equalsIgnoreCase(correctBlankA);
    boolean isBlankBCorrect = userBlankB != null && userBlankB.equalsIgnoreCase(correctBlankB);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>퀴즈 페이지</title>
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
            width: 900px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            gap: 10px;
            margin-top: 10px;
        }
        .kgw_quizBox{
            width: 800px;
            min-height: 300px;
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            align-items: center;
            margin-top: 20px;
        }
        .kgw_qnum {
            color: #6B6B6B;
            font-size: 24px;
            font-weight: 600;
            width: 100%;
            padding-left: 10px;
            height: auto;
            margin-top: 30px;
            margin-bottom: 12px;
        }
        .kgw_question {
            width: 100%;
            height: auto;
            max-height: 60px;
            display: flex;
            flex-direction: row;
            justify-self: flex-start;
            text-align: left;
            align-items: center;
            font-size: 24px;
            font-weight: 600;
            color: #000; 
            padding-left: 10px;
            margin-bottom: 20px;
        }
        .kgw_line {
            width: 100%;
            color: #9a9a9a;
        }
        .kgw_oxBox {
            width: 750px;
            height: 50px;
            border: 1px solid #D0D0D0;
            border-radius: 10px;
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
            position: relative;
            gap: 12px;
            margin-top: 24px;
            input[type='radio'] {
                position: absolute;
                right: 14px;
                top: 13px;
                -webkit-appearance: none;
                -moz-appearance: none;  
                appearance: none; 
                width: 20px;
                height: 20px;
                border: 1px solid #3b1e54; 
                border-radius: 50%;
                outline: none; 
                cursor: pointer;
            }
            input[type='radio']:checked {
            background-color: #E3D2E7; 
            border: 1px solid #000;
            box-shadow: 0 0 0 1px #3b1e54;
            }
        }
        .kgw_oxText {
            width: fit-content;
            color: #000;
            font-size: 24px;
        }
        .kgw_oxicon {
            width: 24px;
            padding-left: 14px;
        }
        .kgw_blankBox {
            width: 700px;
            border: 2px solid #D0D0D0;
            border-radius: 10px;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            padding: 26px 24px;
            color: black;
            font-size: 24px;
            margin-top: 16px;
        }
        .kgw_inputBox {
            width: 750px;
            height: 40px;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            gap: 12px;
            margin-top: 20px;
        }
        .kgw_blankType {
            width: auto;
            font-size: 24px;
            color: #965CB6;
        }
        .kgw_fillBlank {
            width: 300px;
            height: 40px;
            border: 1px solid #D0D0D0;
            border-radius: 10px;
            padding-left: 14px;
            font-size: 16px;
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
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
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
        .kgw_submit {
            display: flex;
            width: 150px;
            height: 48px;
            align-items: center;
            justify-content: center;
            background-color: #9b7ebd;
            border-radius: 30px;
            font-size: 20px;
            color: #ffffff;
            margin-top: 60px;
            margin-bottom: 20px;
            box-shadow: none;
            border: none;
        }
        
    </style>
</head>
<body>
    <main>
        <form action="index.jsp" method="GET">
            <input type="hidden" name="page" value="quiz_result_page">
            <input type="hidden" name="articleId" value="<%= articleId %>" />    
            <div class="kgw_frame">
                <div class="kgw_titleBox">
                    <div class="kgw_iconBox">
                        <img id="kgw_icon" src="./assets/q_icon.svg" alt="babo"></img>
                    </div>
                    <div class="kgw_title">
                        <%= articleTitle %>
                    </div>
                </div>
                <div class="kgw_detail">
                    <p class="kgw_author"><%= author %></p>
                    <p class="kgw_divider">|</p>
                    <p class="kgw_date"><%= date %></p>
                    <p class="kgw_theme"><%= category %></p>
                </div>
                <div class="kgw_quizBox">
                    <div class="kgw_qnum">Q1</div>
                    <div class="kgw_question"><%= oxQuizContent %></div>
                    <hr class="kgw_line">
                    <!-- 맞아요 -->
                    <label class="kgw_oxBox">
                        <img class="kgw_oxicon" src="./assets/oIcon.svg">
                        <div class="kgw_oxText">맞아요</div>
                        <input type="radio" name="ox_answer" value="true" ">
                    </label>

                    <!-- 아니에요 -->
                    <label class="kgw_oxBox">
                        <img class="kgw_oxicon" src="./assets/xIcon.svg">
                        <div class="kgw_oxText">아니에요</div>
                        <input type="radio" name="ox_answer" value="false" ">
                    </label>
                </div>
                <div class="kgw_quizBox">
			    <div class="kgw_qnum">Q2</div>
				    <div class="kgw_question">빈칸을 채우는 문제입니다. 빈칸을 클릭해서 빈칸을 채워보세요!</div>
				    <hr class="kgw_line">
				    <div class="kgw_blankBox">
				        <%= blankQuizContent %>
				    </div>
				    <!-- A 입력 -->
				    <div class="kgw_inputBox">
				        <p class="kgw_blankType">A |</p>
				        <input class="kgw_fillBlank" type="text" name="blankA" placeholder="A에 들어갈 단어를 작성하세요">
				    </div>
				    <!-- B 입력 -->
				    <div class="kgw_inputBox">
				        <p class="kgw_blankType">B |</p>
				        <input class="kgw_fillBlank" type="text" name="blankB" placeholder="B에 들어갈 단어를 작성하세요">
				    </div>
				</div>
                <input type="hidden" name="articleId" value="<%= articleId %>">
                <button class="kgw_submit" type="submit">제출하기</button>
            </div>
        </form>
    </main>
</body>
</html>

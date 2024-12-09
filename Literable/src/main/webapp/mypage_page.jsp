<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
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
            align-items: start;
            gap: 50px;
            width: 960px;
            margin-top: 50px;
            margin-bottom: 247px;
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
            display: flex;
            flex-direction: column;
            background-color: #fff;
            padding: 30px;
            justify-content: start;
        }

        .he2_profile-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            margin-bottom: 30px;
        }

        #profile_img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 15px;
        }

        .he2_profile-info {
            display: flex;
            flex-direction: column;
            font-size: 18px;
            color: #5C6C7E;
            margin-top: 15px;
            width: 100%;
            max-width: 500px;
        }

        .he2_profile-info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-bottom: 15px;
        }

        .he2_profile-info-row.single {
            flex-direction: column;
            align-items: flex-start;
        }

        .he2_profile-info-row.single p:first-child {
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .he2_profile-info-row p {
            margin: 0;
        }

        .he2_profile-info-row strong {
            font-weight: 700;
            color: #333;
        }

        .he2_profile-info-row.spaced {
            column-gap: 200px;
        }

        .he2_tags-section {
       		width: 449px;
       		height: 160px;
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px 11px;
            margin: 0;
            margin-top: 30px;
        }

        .he2_tag {
            width: 103.83px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 20px;
            background-color: #F4F4F9;
            font-size: 20px;
            color: #5C6C7E;
            border: 1px solid #E0E0E0;
            text-align: center;
            margin: 0;
        }

        .he2_tag.he2_highlight {
            background-color: #E9D9F2;
            color: #965CB6;
        }
    </style>
</head>
<body>
    <div id="he2_mypage-container">
        <!-- 사이드바 -->
        <div id="he2_sidebar">
            <h3>마이페이지</h3>
            <ul>
                <li>회원관리</li>
                <li><a href="logout_process.jsp" style="text-decoration: none; color: inherit;">- 로그아웃</a></li>
                <li><a href="index.jsp?page=withdraw_page">- 회원탈퇴</a></li>
            </ul>
        </div>

        <!-- 메인 콘텐츠 -->
        <div id="he2_main-content">
            <!-- 프로필 섹션 -->
            <div class="he2_profile-section">
                <img id="profile_img" src="./assets/jiji.jpg" alt="프로필 이미지">

                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    String nickname = "";
                    String interest_category1 = "";
                    String interest_category2 = "";
                    int totalPoint = 0;

                    Integer userId = (Integer) session.getAttribute("id");
                    if (userId == null) {
                        userId = 1; // 기본값
                    }

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String dbUrl = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
                        conn = DriverManager.getConnection(dbUrl, "root", "Abcd123@");

                        String sql = "SELECT nickname, interest_category1, interest_category2, total_point FROM User WHERE id = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, userId);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            nickname = rs.getString("nickname");
                            interest_category1 = rs.getString("interest_category1");
                            interest_category2 = rs.getString("interest_category2");
                            totalPoint = rs.getInt("total_point");
                        } else {
                            out.println("<p>사용자 정보를 찾을 수 없습니다.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>DB 오류: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>

                <h2><%= nickname %>님</h2>
                <div class="he2_profile-info">
                    <!-- 한 줄 소개 -->
                    <div class="he2_profile-info-row single">
                        <p>한 줄 소개</p>
                        <p>지식은 내가 접수한다!</p>
                    </div>
                    <!-- 레벨과 칭호 -->
                    <div class="he2_profile-info-row spaced">
                        <p><strong>레벨 | </strong> 1</p>
                        <p><strong>칭호 | </strong> #몸에서_지식사리_방출</p>
                    </div>
                    <!-- 지식 키운 지와 포인트 -->
                    <div class="he2_profile-info-row spaced">
                        <p><strong>지식 키운 지 | </strong> 30일째</p>
                        <p><strong>포인트 | </strong> <%= totalPoint %>P</p>
                    </div>
                </div>
            </div>

            <!-- 관심 태그 -->
            <h3>관심태그</h3>
            <div class="he2_tags-section">
                <div class="he2_tag <%= (interest_category1.equals("dev") || interest_category2.equals("dev")) ? "he2_highlight" : "" %>">자기개발</div>
                <div class="he2_tag <%= (interest_category1.equals("edu") || interest_category2.equals("edu")) ? "he2_highlight" : "" %>">교육</div>
                <div class="he2_tag <%= (interest_category1.equals("game") || interest_category2.equals("game")) ? "he2_highlight" : "" %>">게임</div>
                <div class="he2_tag <%= (interest_category1.equals("beauty") || interest_category2.equals("beauty")) ? "he2_highlight" : "" %>">뷰티</div>
                <div class="he2_tag <%= (interest_category1.equals("cook") || interest_category2.equals("cook")) ? "he2_highlight" : "" %>">요리</div>
                <div class="he2_tag <%= (interest_category1.equals("code") || interest_category2.equals("code")) ? "he2_highlight" : "" %>">코딩</div>
                <div class="he2_tag <%= (interest_category1.equals("culture") || interest_category2.equals("culture")) ? "he2_highlight" : "" %>">문화</div>
                <div class="he2_tag <%= (interest_category1.equals("health") || interest_category2.equals("health")) ? "he2_highlight" : "" %>">건강</div>
                <div class="he2_tag <%= (interest_category1.equals("show") || interest_category2.equals("show")) ? "he2_highlight" : "" %>">전시회</div>
                <div class="he2_tag <%= (interest_category1.equals("art") || interest_category2.equals("art")) ? "he2_highlight" : "" %>">그림</div>
                <div class="he2_tag <%= (interest_category1.equals("travle") || interest_category2.equals("travle")) ? "he2_highlight" : "" %>">여행</div>
                <div class="he2_tag <%= (interest_category1.equals("science") || interest_category2.equals("science")) ? "he2_highlight" : "" %>">과학</div>
            </div>
        </div>
    </div>
</body>
</html>

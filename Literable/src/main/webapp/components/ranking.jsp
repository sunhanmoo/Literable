<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<style>
    #ranking_article {
        display: flex;
        flex-direction: column;
        gap: 19px;
        height: auto;
    }
    #title_section {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        height: 47px;
        border-bottom: 0.7px solid #535353;
        margin: 0;
    }
    .title {
        color: rgba(0, 0, 0, 0.80);
        font-size: 26px;
        font-style: normal;
        font-weight: 700;
        letter-spacing: -1.82px;
        margin: 0;
    }
    .notice {
        color: #535353;
        font-size: 14px;
        font-style: normal;
        font-weight: 300;
        letter-spacing: -1.4px;
        margin: 0;    
    }
    #ranking_section {
        height: auto;
        display: flex;
        flex-direction: row;    
		gap: 223px;
        margin-left: 28px;
    }
    #ranking {
        display: flex;
        gap: 10px;
        flex-direction: column;
        margin: 0;
    }
    #rank {
        color: #630C92;
        font-size: 20px;
        font-style: normal;
        font-weight: 700;
        letter-spacing: -7%;
        margin: 0;
    }
    #name {
        color: #000;
        font-size: 20px;
        font-style: normal;
        font-weight: normal;
        line-height: normal;
        letter-spacing: -1.4px;
        margin-left: 23px;
    }
</style>

<div id="ranking_article">
    <div id="title_section">
        <p class="title">포인트 랭킹</p>
        <p class="notice">전체 카테고리 기준 누적 포인트 순위입니다</p>
    </div>
    <div id="ranking_section">
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC"; // 데이터베이스 이름 변경
            conn = DriverManager.getConnection(url, "root", "Abcd123@");
            stmt = conn.createStatement();
            
            // total_point 기준으로 정렬하여 User 테이블 조회
            String sql = "SELECT nickname, total_point FROM User ORDER BY total_point DESC LIMIT 10";
            rs = stmt.executeQuery(sql);
            
            // 모든 사용자 정보를 저장할 리스트
            List<String> rankings = new ArrayList<>();
            while (rs.next()) {
                rankings.add(rs.getString("nickname"));
            }

            // 1~5번 사용자 정보
            out.println("<div id='ranking'>");
            for (int i = 0; i < 5 && i < rankings.size(); i++) {
    %>
                <p id="rank"><%= i + 1 %>. <span id="name"><%= rankings.get(i) %></span></p>
    <%
            }
            out.println("</div>");

            // 6~10번 사용자 정보
            out.println("<div id='ranking'>");
            for (int i = 5; i < 10 && i < rankings.size(); i++) {
    %>
                <p id="rank"><%= i + 1 %>. <span id="name"><%= rankings.get(i) %></span></p>
    <%
            }
            out.println("</div>");
        } catch (Exception e) {
            out.println("DB 연동 오류입니다. : " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
    </div>
</div>

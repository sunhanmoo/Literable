<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 세션에서 userId 값을 가져옵니다. 없을 경우 기본값을 1로 설정합니다.
    Integer userId = (Integer) session.getAttribute("id");
    if (userId == null) {
        userId = 1; // 기본값을 1로 설정
        session.setAttribute("userId", userId); // userId를 세션에 설정
    }
%>

<%
    // DB 연결 정보
    String url = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "Abcd123@";

    String nickname = "";
    String category1 = "";
    String category2 = "";
    String selectedCategory = request.getParameter("category");
    if (selectedCategory == null || selectedCategory.trim().isEmpty()) {
        selectedCategory = "전체";
    }

    Connection connection = null;
    try {
        // JDBC 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, dbUser, dbPassword);

        // 사용자 정보 조회
        String userQuery = "SELECT nickname, interest_category1, interest_category2 FROM User WHERE id = ?";
        try (PreparedStatement userPs = connection.prepareStatement(userQuery)) {
            userPs.setInt(1, userId); // 현재 사용자 ID (예시로 1번)
            try (ResultSet userRs = userPs.executeQuery()) {
                if (userRs.next()) {
                    nickname = userRs.getString("nickname");
                    category1 = userRs.getString("interest_category1");
                    category2 = userRs.getString("interest_category2");
                }
            }
        }

        // 아티클 조회 쿼리 설정
        String articleQuery = "SELECT * FROM Article";
        if ("전체".equals(selectedCategory)) {
            articleQuery += " WHERE category = ? OR category = ?";
        } else {
            articleQuery += " WHERE category = ?";
        }

        try (PreparedStatement articlePs = connection.prepareStatement(articleQuery)) {
            if ("전체".equals(selectedCategory)) {
                articlePs.setString(1, category1);
                articlePs.setString(2, category2);
            } else {
                articlePs.setString(1, selectedCategory);
            }

            try (ResultSet articles = articlePs.executeQuery()) {
%>
<style>
#article_main {
    display: flex;
    flex-direction: column;
    align-items: start;
    margin-bottom: 18px;
    width: 1030px;
}
#title_section {
	width: 1030px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    height: 35px;
    border-bottom: 0.7px solid #535353;
    margin-bottom: 14.5px;
}
.title {
    color: rgba(0, 0, 0, 0.80);
    font-size: 20px;
    font-weight: 700;
    letter-spacing: -1.82px;
    margin: 0;
}
.category_button {
    color: #535353;
    font-size: 16px;
    font-weight: 300;
    background-color: white;
    border: none;
    cursor: pointer;
}
.category_button.selected {
    font-weight: bold;
}
#article_list {
    display: flex;
    flex-direction: column;
    gap: 16px;
}
</style>
<script>
function selectCategory(category) {
    location.href = "index.jsp?page=article_page&category=" + category; // 선택된 카테고리에 따라 페이지 새로고침
}
</script>

<div id="article_main">
    <div id="title_section">
        <p class="title"><%= nickname %>님의 아티클</p>
        <div class="category_section">
            <button class="category_button <% if ("전체".equals(selectedCategory)) out.print("selected"); %>" 
                    onclick="selectCategory('전체')">전체</button>
            <button class="category_button <% if (category1.equals(selectedCategory)) out.print("selected"); %>" 
                    onclick="selectCategory('<%= category1 %>')"><%= category1 %></button>
            <button class="category_button <% if (category2.equals(selectedCategory)) out.print("selected"); %>" 
                    onclick="selectCategory('<%= category2 %>')"><%= category2 %></button>
        </div>
    </div>
    <div id="article_list">
<%
                // 아티클 반복 렌더링
                while (articles.next()) {
                    String articleId = articles.getString("id");
                    String title = articles.getString("article_title");
                    String author = articles.getString("author");
                    String content = articles.getString("article_content");
                    String date = articles.getString("date");
                    String imageUrl = articles.getString("image_url");
                    String articleCategory = articles.getString("category");
%>
        <jsp:include page="/components/article_component.jsp">
            <jsp:param name="article_id" value="<%= articleId %>" />
            <jsp:param name="imageUrl" value="<%= imageUrl %>" />
            <jsp:param name="title" value="<%= title %>" />
            <jsp:param name="author" value="<%= author %>" />
            <jsp:param name="content" value="<%= content %>" />
            <jsp:param name="date" value="<%= date %>" />
            <jsp:param name="articleCategory" value="<%= articleCategory %>" />
        </jsp:include>
<%
                }
%>
    </div>
</div>
<%
            }
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("<p>오류: " + e.getMessage() + "</p>");
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException ignored) {}
        }
    }
%>

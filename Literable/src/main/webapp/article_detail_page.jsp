<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Integer articleId = Integer.parseInt(request.getParameter("id"));

    // DB 연결 정보
    String url = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "Abcd123@";
    
    String title = "", content = "", author = "", date = "", category = "";

    Connection connection = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, dbUser, dbPassword);

        String articleQuery = "SELECT article_title, author, date, category, article_content FROM Article WHERE id = ?";
        try (PreparedStatement articlePs = connection.prepareStatement(articleQuery)) {
            articlePs.setInt(1, articleId);
            try (ResultSet articleRs = articlePs.executeQuery()) {
                if (articleRs.next()) {
                    title = articleRs.getString("article_title");
                    author = articleRs.getString("author");
                    date = articleRs.getString("date");
                    category = articleRs.getString("category");
                    content = articleRs.getString("article_content");
                    
                    // 개행 문자를 <br>로 변환
                    content = content.replace("\n", "<br/>");    // Unix/Linux
                }
            }
        }
%>
<style>
.detail_section {
    width: 903px;
    margin-top: 60px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: start;
    gap: 30px;
    margin-bottom: 28px;
}
#title {
    color: #3B1E54;
    font-size: 54px;
    font-weight: 600;
    letter-spacing: -5.4px;
    text-overflow: ellipsis;  
    overflow: hidden;    
    word-break: break-word;    
    white-space: pre-wrap;    
    display: -webkit-box;  
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;    
    margin: 0;
}
#info {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    gap: 26px;
}
#provider {
    color: rgba(0, 0, 0, 0.80);
    font-size: 20px;
    font-weight: 600;
}
#date {
    color: rgba(0, 0, 0, 0.80);
    font-size: 16px;
}
article {
    color: #3C3D37;
    font-size: 20px;
    font-weight: 400;
    line-height: 33px;
    letter-spacing: -1px;
    white-space: pre-wrap;    
}
#quiz_button {
    width: 160px;
    height: 48px;
    padding: 12px 24.5px;
    text-align: center;
    border: none;
    border-radius: 30px;
    background: #9B7EBD;
    color: #FFF;
    font-size: 20px;
    font-weight: 600;
    cursor: pointer;
}
#button_div {
    width: 903px;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>

<div class="detail_section">
    <p id="title"><%= title %></p>
    <div id="info">
        <p id="provider"><%= author %></p>
        <p id="date"><%= date %></p>
        <jsp:include page="/components/category.jsp">
           <jsp:param name="category" value="<%=category %>"/>
        </jsp:include>
    </div>
    <article><%= content %></article>
    <div id="button_div">
    <form action="quiz_page.jsp" method="get">
        <input type="hidden" name="articleId" value="<%= articleId %>"/>
        <button type="submit" id="quiz_button">퀴즈 풀러가기</button>
    </form>
</div>
</div>

<%
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

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
    String category1 = "";
    String category2 = "";
    String nickname = "";
    int totalPoint = 0;
    int rank = 0;

    // 데이터베이스 연결 변수
    String url = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
    String user = "root";
    String password = "Abcd123@";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        // 사용자 ID 확인
        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            // 사용자 정보 가져오기
            String userQuery = "SELECT nickname, interest_category1, interest_category2, total_point FROM User WHERE id = ?";
            try (PreparedStatement ps = connection.prepareStatement(userQuery)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        nickname = rs.getString("nickname");
                        category1 = rs.getString("interest_category1");
                        category2 = rs.getString("interest_category2");
                        totalPoint = rs.getInt("total_point");
                    } else {
                        out.println("<p>사용자 정보를 찾을 수 없습니다.</p>");
                        return; // 더 이상 진행하지 않음
                    }
                }
            }

            // 순위 계산
            String rankQuery = "SELECT COUNT(*) AS user_rank FROM User WHERE total_point > ?";
            try (PreparedStatement rankPs = connection.prepareStatement(rankQuery)) {
                rankPs.setInt(1, totalPoint);

                try (ResultSet rankRs = rankPs.executeQuery()) {
                    if (rankRs.next()) {
                        rank = rankRs.getInt("user_rank") + 1;
                    }
                }
            }

            // 카테고리 선택 처리
            String selectedCategory = request.getParameter("category");
            if (selectedCategory == null || selectedCategory.trim().isEmpty()) {
                selectedCategory = "전체";
            }

            String articleQuery = "SELECT * FROM Article WHERE category = ?";
            if ("전체".equals(selectedCategory)) {
                articleQuery = "SELECT * FROM Article WHERE category = ? OR category = ? LIMIT 6";
            }

            try (PreparedStatement ps = connection.prepareStatement(articleQuery)) {
                if ("전체".equals(selectedCategory)) {
                    ps.setString(1, category1);
                    ps.setString(2, category2);
                } else {
                    ps.setString(1, selectedCategory);
                }

                try (ResultSet articles = ps.executeQuery()) {
%>
    <style>
        #article {
            height: 773px;
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
            font-weight: 700;
            margin: 0;
        }
        .category_button {
            color: #535353;
            font-size: 14px;
            margin: 0;
            background-color: white;
            border: none;
            cursor: pointer;
        }
        .category_button.selected {
            font-weight: bold;
        }
		#article_section {
		    display: grid;
		    grid-template-columns: repeat(3, 1fr);
		    grid-template-rows: repeat(2, auto);
		    gap: 15px;
		    padding-top: 23px;
		}
    </style>
    <div id="article">
        <div id="title_section">
            <p class="title"><%= nickname %>님의 아티클</p>
            <div class="category_section">
                <button type="button" class="category_button <% if ("전체".equals(selectedCategory)) out.print("selected"); %>" 
                        onclick="selectCategory('전체')">전체</button>
                <button type="button" class="category_button <% if (category1.equals(selectedCategory)) out.print("selected"); %>" 
                        onclick="selectCategory('<%= category1 %>')"><%= category1 %></button>
                <button type="button" class="category_button <% if (category2.equals(selectedCategory)) out.print("selected"); %>" 
                        onclick="selectCategory('<%= category2 %>')"><%= category2 %></button>
            </div>
        </div>
        <div id="article_section">
<%
                    while (articles.next()) {
                        String articleTitle = articles.getString("article_title");
                        String author = articles.getString("author");
                        String imageUrl = articles.getString("image_url");
                        String id = articles.getString("id");
%>
                        <jsp:include page="article_div.jsp">
                            <jsp:param name="id" value="<%= id %>" />
                            <jsp:param name="title" value="<%= articleTitle %>" />
                            <jsp:param name="author" value="<%= author %>" />
                            <jsp:param name="imageUrl" value="<%= imageUrl %>" />
                        </jsp:include>
<%
                    }
%>
        </div>
    </div>
    <script>
        function selectCategory(category) {
            location.href = "?category=" + category; // 카테고리 선택 후 페이지 새로고침
        }
    </script>
<%
                }
            }
        }
    } catch (SQLException e) {
        out.println("<p>SQL 오류: " + e.getErrorCode() + " - " + e.getMessage() + "</p>");
    } catch (ClassNotFoundException e) {
        out.println("<p>JDBC 드라이버 클래스를 찾을 수 없습니다: " + e.getMessage() + "</p>");
    } catch (NumberFormatException e) {
        out.println("<p>사용자 ID 형식이 잘못되었습니다: " + e.getMessage() + "</p>");
    } catch (Exception e) {
        out.println("<p>알 수 없는 오류 발생: " + e.getMessage() + "</p>");
    }
%>
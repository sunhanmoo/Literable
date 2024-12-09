<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<style>
.profile {
    font-family: Inter;
    width: 283px;
    height: 487px;
    background: #fff;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    border-radius: 25px;
    box-shadow: 0px 4px 30px 0px rgba(0, 0, 0, 0.10);
}
.profile_div {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 23px;
}
#profile_up {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 12px;
}
#profile_img {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    margin: 0px;
}
#nickname {
    color: #000;
    font-size: 24px;
    font-style: normal;
    font-weight: 600;
    letter-spacing: -0.48px;
    margin: 0;
}
#message {
    color: #535353;
    font-size: 18px;
    font-style: normal;
    font-weight: 600;
    margin: 0;
}
.profile_down {
    width: 188px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: start;
    gap: 13px;
    color: #000;
    font-size: 16px;
    font-style: normal;
    font-weight: 700;
    letter-spacing: -1.12px;
}
#title {
    margin: 0;
    text-align: start;
}
#text {
    color: #67696A;
    font-family: Inter;
    font-size: 16px;
    font-style: normal;
    font-weight: 500;
    line-height: normal;
    letter-spacing: -1.12px;
}
.jh_category_div {
    display: flex;
    gap: 7px;
}
</style>   

<%
    // 세션에서 userId 값을 가져옵니다. 없을 경우 기본값을 1로 설정합니다.
    Integer userId = (Integer) session.getAttribute("id");
    if (userId == null) {
        userId = 1; // 기본값을 1로 설정
        session.setAttribute("userId", userId); // userId를 세션에 설정
    }
%> 

<div class="profile">
        <div class="profile_div">
            <div id="profile_up">
                <img id="profile_img" alt="프로필 사진" src="./assets/jiji.jpg">
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    String category1 = "";
                    String category2 = "";
                    int totalPoint = 0;
                    int rank = 0;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/literable?serverTimezone=UTC";
                        conn = DriverManager.getConnection(url, "root", "Abcd123@");

                        // 사용자 정보 가져오기
                        String sql = "SELECT nickname, interest_category1, interest_category2, total_point FROM User WHERE id = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, userId);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String nickname = rs.getString("nickname");
                            category1 = rs.getString("interest_category1");
                            category2 = rs.getString("interest_category2");
                            totalPoint = rs.getInt("total_point");

                            // 순위 계산 생략 ...
            %>
                            <p id="nickname"><%= nickname %></p>
                            <p id="message">지식은 내가 접수한다!</p>
            <%
                        } else {
                            out.println("<p>사용자 정보를 찾을 수 없습니다.</p>");
                        }
                    } catch (SQLException e) {
                        out.println("DB 연동 오류입니다. : " + e.getMessage());
                    } catch (ClassNotFoundException e) {
                        out.println("DB 드라이버 오류입니다. : " + e.getMessage());
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                %>
            </div>
                    <div class="profile_down">
            <p id="title">관심 주제 카테고리</p>
            <div class="jh_category_div">
                <jsp:include page="category.jsp">
                    <jsp:param name="category" value="<%= category1 %>"/>
                </jsp:include>
                <jsp:include page="category.jsp">
                    <jsp:param name="category" value="<%= category2 %>"/>
                </jsp:include>
            </div>
            <p id="title">칭호 | <span id="text">지식 위의 무법자 </span></p>
            <p id="title">레벨 | <span id="text">1</span></p>
            <p id="title">포인트 | <span id="text"><%= totalPoint %>p</span></p>
            <p id="title">등수 | <span id="text"><%= rank %>등</span></p>
        </div>
        </div>
    </div>
</div>

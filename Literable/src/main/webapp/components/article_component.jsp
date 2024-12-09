<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<style>
#article_img {
	width: 140px;
	height: 140px;
	border-radius: 12px;
	border: 1px solid #D9D9D9;
	object-fit: cover;
	margin-right: 0;
}
.article_content{
	display: flex;
	gap : 32px;
}
#article_text{
	display: flex;
	flex-direction: column;
	gap : 14px;
	margin: 0;
}
p{
	margin: 0;
}
#article_title{
	color: rgba(0, 0, 0, 0.80);
	font-size: 20px;
	font-style: normal;
	font-weight: 600;
	line-height: normal;
	letter-spacing: -2px;
}
#article_info{
	color: #000;
	font-size: 16px;
	font-style: normal;
	font-weight: 500;
	line-height: normal;
	letter-spacing: -1.6px;
}
#article_date{
	color: #AFAFAF;
	font-size: 12px;
	font-style: normal;
	font-weight: 500;
	line-height: normal;
	letter-spacing: -1.2px;
	margin-left: 8px;
	
}

</style>
<%
    String articleId = request.getParameter("article_id");
	String category = request.getParameter("articleCategory");
%>

<div class="article_content">
    <img id="article_img" src="<%=request.getParameter("imageUrl") %>" alt="아티클사진"/>
    <div id="article_text">
        <jsp:include page="category.jsp">
           <jsp:param name="category" value="<%=category %>"/>
        </jsp:include>
        <a href="index.jsp?page=article_page&id=<%= articleId %>" style="text-decoration: none;">
            <p id="article_title"><%=request.getParameter("title") %></p>
        </a>
        <p id="article_info"><%=request.getParameter("author") %><span id="article_date"><%=request.getParameter("date") %></span></p>
    </div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.article_section {
    width: 240px;
    height: 315px;
    position: relative;
}
#thumbnail {
    width: 224px;
    height: 245px;
    border-radius: 15px;
    border: 0.5px solid #6B6B6B;
    object-fit: cover;
    position: absolute;
    top: 0px;
    left: 0px;
}
#subject {
    width: 219px;
    height: auto;
    background-color: #ECE7F5;
    margin: 0;
    border-radius: 15px;
    position: absolute;
    bottom: 0px;
    right: 0px;
    padding: 17px 24px;
    box-sizing: border-box;
}
#brief_title {
    margin: 0;
    text-overflow: ellipsis;
    overflow: hidden;
    word-break: break-word;

    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;

    color: rgba(0, 0, 0, 0.80);
    font-size: 18px;
    font-style: normal;
    font-weight: 600;
    line-height: normal;
    letter-spacing: -1.8px;
}
</style>

<div class="article_section">
	<a href="index.jsp?page=article_page&id=<%= request.getParameter("id")%>">
	    <img id="thumbnail" src="<%= request.getParameter("imageUrl") != null ? request.getParameter("imageUrl") : "default.jpg" %>"/>
    	<div id="subject">
        	<p id="brief_title"><%= request.getParameter("title") != null ? request.getParameter("title") : "제목 없음" %></p>
    	</div>
	</a>
</div>

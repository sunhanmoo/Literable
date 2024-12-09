<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String category = request.getParameter("category");
%>

<style>
#label {
	background: rgba(209, 181, 215, 0.60);
	display: flex;
	justify-content: center;
	align-items: center;
	width: 60px;
	height: 24px;
	border-radius: 30px;
	margin: 0;

}
#category {
	color: #630C92;
	text-align: center;
	font-size: 14px;
	font-weight: 500;
	letter-spacing: -1.4px;
	margin: 0;
}
</style>
<div id="label">
	<p id="category"><%= category %></p> 
</div>
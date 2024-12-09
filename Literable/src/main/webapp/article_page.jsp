<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.content {
	width: 1030px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}
#title {
	color: rgba(0, 0, 0, 0.80);
	font-family: Inter;
	font-size: 30px;
	font-style: normal;
	font-weight: 700;
	line-height: normal;
	letter-spacing: -2.1px;
	margin: 44px 0 56px 0;
}
</style>    
    
<main>
    <section class="content">
        <p id="title">아티클 읽기</p>
        <jsp:include page="/components/article_list.jsp"/>
    </section>
</main>
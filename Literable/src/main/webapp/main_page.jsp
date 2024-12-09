<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    Object userIdObj = session.getAttribute("id");
    Integer userId = null;

    if (userIdObj instanceof Integer) {
        userId = (Integer) userIdObj;
    }

    if (userId == null) {
        userId = 1;
        session.setAttribute("id", userId);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <style>
    	#main {
    		display: flex;
    		align-items: start;
    		justify-content: center;
    		gap: 119px;
    		margin-top: 30px;
    	}
        #body {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin: 0px;
            padding: 20px;
        }
        .content {
            display: flex;
            flex-direction: row;
            gap: 109px;
        }
        #rightContent {
            display: flex;
            flex-direction: column;
            width: 748px;
            gap: 92px;
        }
		::-webkit-scrollbar {
		    display: none;
		}
    </style>
</head>
<div id="main">
        <div id="body">
            <section class="content">
            	<div>
	            	<jsp:include page="/components/sideProfile.jsp">
	                    <jsp:param name="userId" value="<%= userId %>" />
	                </jsp:include>
            	</div>
                <div id="rightContent">
                    <jsp:include page="/components/ranking.jsp" />
                    <jsp:include page="/components/article.jsp">
                        <jsp:param name="userId" value="<%= userId %>" />
                    </jsp:include>
                </div>
            </section>
        </div>
</div>
</html>

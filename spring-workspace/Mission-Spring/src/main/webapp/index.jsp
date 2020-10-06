<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/board.css"/>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/layout.css"/>
</head>
<body>
	<header>
		<%-- <%@include file="/WEB-INF/jsp/include/topMenu.jsp" %> --%>
		<jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"/>
	</header>
	<section>
		<c:choose>
			<c:when test="${ empty userVO }">
			<a href="<%= request.getContextPath() %>/login">로그인</a>
			</c:when>
			<c:otherwise>
				<a href="<%= request.getContextPath() %>/logout">로그아웃</a>
			</c:otherwise>
		</c:choose>
		<a href="<%= request.getContextPath() %>/board">게시판</a>
		<a href="<%= request.getContextPath() %>/board/write">새글등록</a>
	</section>
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
</html>
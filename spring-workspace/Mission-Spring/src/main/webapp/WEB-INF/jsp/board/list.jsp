<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/board.css"/>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/layout.css"/>
<script>
function goWriteForm() {
	location.href = "${ pageContext.request.contextPath }/board/write"
}

function doAction(boardNo) {
	/* location.href = "${ pageContext.request.contextPath }/board/detail?no=" + boardNo */
	location.href = "${ pageContext.request.contextPath }/board/" + boardNo 
	
}
</script>
</head>
<body>
	<header>
		<%-- <%@include file="/WEB-INF/jsp/include/topMenu.jsp" %> --%>
		<jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"/>
	</header>
	<h2>전체게시글 목록</h2>
	<table class="table table-striped">
		  <tbody>
		  	<tr>
		  		<th>no</th>
		  		<th>제목</th>
		  		<th>작성자</th>
		  		<th>조회수</th>
		  		<th>작성일</th>
		    <tr>
		    <c:forEach items="${ boardList }" var="board" varStatus="loop">
		    
				<tr>
					<td>${ loop.count }</td>
					
					<td>
						<a href="#" onclick="doAction(${ board.no })" >
							<c:out value="${ board.title }" />
						</a>
						
					</td>
					<td>${ board.writer }</td>
					<td>${ board.viewCnt }</td>
					<td>${ board.regDate }</td>
				</tr>
			</c:forEach>
		  </tbody>
		</table>
		<a href="${ pageContext.request.contextPath }/board/write"><input type="button" value="등록"></a>
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
</html>
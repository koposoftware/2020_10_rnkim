<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.errorMsg {
	color: red;
}
</style>
</head>
<body>
<div id="title">
		<h1>후기 작성</h1>
			<p>Banker의 서비스를 이용하신 후기를 들려주세요.</p>
		</div>
	
		<form:form commandName="boardVO" method="post">
			<table class="table">
				<tr>
					<th width="23%">제목</th>
					<td>
						<form:input path="title"/><form:errors class="errorMsg" path="title"/>
					</td>
				</tr>
				<tr>
					<th>글쓴이</th>
					<td>
						<form:input path="writer" /><form:errors class="errorMsg" path="writer"/>
					</td>
				<tr>
				<tr>
					<th>내용</th>
					<td>
						<form:textarea path="content" rows="7" cols="50"/><form:errors class="errorMsg" path="content"/>
					</td>
				</tr>
			</table>
			<button type="submit">등록</button>
		</form:form>
	      
</body>
</html>
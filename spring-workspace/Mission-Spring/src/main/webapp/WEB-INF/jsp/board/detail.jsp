<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/board.css"/>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/layout.css"/>
<script src="http://code.jquery.com/jquery-3.5.1.min.js "></script> 
<script type="text/javascript">
	function getReplyList() {
		// 해당 게시물의 댓글리스트 조회 => <div id="replyList"></div> 조회데이터 업데이트 
		$.ajax({
			url : '${ pageContext.request.contextPath }/reply/${ board.no }',
			type: 'get',
			success : function(data) {
				
				$('#replyList').empty();
				
				let list = JSON.parse(data)
				
				$(list).each(function() {
					console.log(this)
					
					let str = '';
					str += '<hr>';
					str += '<strong>' + this.content + '</strong>' + '(' + this.writer + ')';
					str += '&nbsp;&nbsp;&nbsp;&nbsp;' + this.regDate
					str += '&nbsp;&nbsp;&nbsp;&nbsp;' + '<button class="delBtn" id=' + this.no + '>삭제</button>'
					str += '</div>'
					
					$('#replyList').append(str);
				})
			}, error : function() {
				alert('실패')
			}
		})
	}
   $(document).ready(function(){
      $('#replyAddBtn').click(function(){
         let content = document.rForm.content.value;
         let writer = document.rForm.writer.value;
         
         // reply/insert?BoardNo=12&content=aaa&writer=bbb
        $.ajax({
        	url : '${ pageContext.request.contextPath }/reply',
        	type : 'post',
        	data : {
        		boardNo : ${ board.no },
        		content : content,
        		writer : writer
        	}, success : function() {
        		document.rForm.content.value = '';
        		document.rForm.writer.value = '';
        		getReplyList(); // 댓글 작성 성공했을때도 호출 
        	}, eror : function() {
        		alert('실패')
        	}
        })
      })
      
   })
   /* 화면 시작시 댓글이 모두 보이도록 */
   $(document).ready(function() {
	   getReplyList();
   })
   /* 동적으로 만든 버튼이니 on 이벤트 추가  */
   $(document).ready(function() {
	   $(document).on('click', '.delBtn', function() {
		   
		   if(!confirm('댓글을 삭제하시겠습니까?')) return;
		   
		   let replyNo = $(this).attr('id');
		   
		   $.ajax({
			   url : '${ pageContext.request.contextPath }/reply/' + replyNo,
			   type : 'delete',
			   success : function() {
				   getReplyList();
			   }, error : function() {
				   alert('실패')
			   }
		   })
	   })
   }) 
</script>
</head>
<body>
	<header>
		<%-- <%@include file="/WEB-INF/jsp/include/topMenu.jsp" %> --%>
		<jsp:include page="/WEB-INF/jsp/include/topMenu.jsp"/>
	</header>
	<section>
	<table class="table" >
			<tr>
				<th width="25%">제목</th>
				<td><c:out value="${ board.title }" /></td>
			</tr>
			<tr>
				<th width="25%">글쓴이</th>
				<td><c:out value="${ board.writer }" /></td>
			</tr>
			<tr>
				<th width="25%">조회수</th>
				<td>${ board.viewCnt }</td>
			</tr>
			<tr>
				<th width="25%">등록일</th>
				<td>${ board.regDate }</td>
			</tr>
			<tr>
				<th width="25%">내용</th>
				<td>${ board.content }</td>
			</tr>
			
		</table>
		<div class="group">
			<input type="button" class="button" value="목록" onclick="doAction('L')">&nbsp;&nbsp;
			<c:choose>
				<c:when test="${ userVO.id eq board.writer }">
					<input type="button" class="button" value="수정" onclick="doAction('U')">&nbsp;&nbsp;
					<input type="button" class="button" value="삭제" onclick="doAction('D')">
				</c:when>			
			</c:choose>
		</div>
		
		<br>
		<hr>
		<form name="rForm">
			댓글 : <input type="text" name="content" size="50">
			이름 : <input type="text" name="writer" size="10">
			<input type="button" value="댓글추가" id="replyAddBtn">
		</form>
		<div id="replyList"></div>
	</section>
	<footer>
		<%@include file="/WEB-INF/jsp/include/footer.jsp" %>
	</footer>
</body>
</html>
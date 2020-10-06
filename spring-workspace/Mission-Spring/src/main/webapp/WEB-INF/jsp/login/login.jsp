<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

</script>
</head>
<body>
<section>
      <div align="center">
         <br>
         <hr>
         <h2>로그인</h2>
         <hr>
         <br>
         <form action="${ pageContext.request.contextPath }/login" method="post" name="lform">
            <table style="width: 40%">
               <tr>
                  <th>ID</th>
                  <td><input type="text" name="id"></td>
               </tr>
               <tr>
                  <th>PASSWORD</th>
                  <td><input type="password" name="password"></td>
               </tr>
            </table>
            <br>
            <button type="submit">로그인</button>
         </form>
      </div>
   </section>
</body>
</html>
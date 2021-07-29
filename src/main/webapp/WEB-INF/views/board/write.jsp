<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<nb:navbar/>

<div class="container">

	<h1>글 쓰기</h1>

	<div class="row">
		<div class="col-12">
			<form action="${appRoot }/board/write" method="post">
				<div class="form-group">
					<label for="mtitle">제목</label>
					<input id="mtitle" class="form-control" name="mtitle">
				</div>
				<div class="form-group">
					<label for="mdetail">내용</label>
					<textarea id="mdetail" class="form-control" name="mdetail"></textarea>
				</div>
				<div class="form-group">
					<label for="mwriter">작성자</label>
					<input id="mwriter" class="form-control" name="mwriter">
				</div>				
				<input class="btn btn-primary" type="submit" value="작성" />
			</form>
		</div>
	</div>
</div>
</body>
</html>
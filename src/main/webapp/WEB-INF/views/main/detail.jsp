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

<title>상세페이지</title>
</head>
<body>
<div class="container">
<nb:navbar/>

	<h1>나는야 상품 페이지</h1>
	
	<div class="row">
		<div class="col-12">
			<form>
				<div class="form-group">
					<label for="mtitle">상품명</label>
					<input readonly="readonly" id="mtitle" class="form-control" name="mtitle" value="${market.mtitle }">
					
				<div class="form-group">
					<label for="mprice">가격</label>
					<input readonly="readonly" id="mprice" class="form-control" name="mprice" value="${market.mprice }">
				</div>	
				
				</div>
				<div class="form-group">
					<label for="textarea1">내용</label>
					<textarea readonly="readonly" id="textarea1" class="form-control" name="mdetail"><c:out value="${market.mdetail }" /></textarea>
				</div>
				
				<div class="form-group">
					<label for="maddress">주소</label>
					<input readonly="readonly" id="maddress" class="form-control" name="maddress" value="${market.maddress }">
				</div>					
				
				<div class="form-group">
					<label for="mregdate">등록일</label>
					<input readonly="readonly" id="mregdate" class="form-control" name="mregdate" value="${market.mregdate }">
				</div>	
				
				
<%-- 				<c:if test="${not empty board.fileName }">
					<div>
						<img class="img-fluid" 
						src="${imgRoot}${board.bno }/${board.fileName}">
					</div>
				</c:if> --%>
				
				<div class="form-group">
					<label for="mwriter">작성자</label>
					<input readonly="readonly" id="mwriter" class="form-control" name="mwriter" value="${market.mwriter }">
				</div>				
				
<%-- 				<c:url value="/board/modify" var="modifyUrl">
					<c:param name="bno" value="${board.bno }" />
					<c:param name="pageNum" value="${cri.pageNum }" />
					<c:param name="amount" value="${cri.amount }" />
					<c:param name="type" value="${cri.type }"/>
					<c:param name="keyword" value="${cri.keyword }" />
				</c:url>
				
				<c:if test="${pinfo.member.userid eq board.writer }" >
					<a class="btn btn-secondary" href="${modifyUrl }">수정/삭제</a>
				</c:if> --%>
				
				
			</form>
		</div>
	</div>
</div>
	
</div>
</body>
</html>
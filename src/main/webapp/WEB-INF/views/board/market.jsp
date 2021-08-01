<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>


<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<!-- timeago -->
<script src="${appRoot }/resources/js/date.js"></script>
     
<script>
$(document).ready(function() {
	$("#list-pagenation1 a").click(function(e) {
		// 기본 액션 중지 (hyperlink 역할 안함)
		e.preventDefault();
		
		//console.log("a요소 클릭됨");
		
		var actionForm = $("#actionForm");
		
		// form의 pageNum input의 값을 a 요소의 href값으로 변경
		actionForm.find("[name=pageNum]").val($(this).attr("href"));
		
		// submit
		actionForm.submit();
	});
	/* for문 대신에 each 함수 사용해서 timeBefore js에 값 보내주는 스크립트 */
	$(".card-time-before").each(function(i, e) {
		timeBefore(e);
	})
	
});
</script>        


<title>중고마켓 </title>

</head>
<body>
<div class="container">	
<nb:navbar/>
<nb:scroll />			  
		  
<!-- 배너 : 슬라이드 -->
<!-- 배너 링크 고정이 아닌 이벤트 페이지 번호로 이동할 수 있게끔 수정할 것 -->		
<div id="carouselExampleInterval" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active" data-interval="3000">
      <a href="${appRoot }/main/home"><img src="${appRoot }/resources/img/ba01.jpg" class="d-block w-100"  id="carousel-size"></a>
    </div>
    <div class="carousel-item" data-interval="3000">
      <a href="${appRoot }/main/login"><img src="${appRoot }/resources/img/ba02.jpg" class="d-block w-100"  id="carousel-size"></a>
    </div>
    <div class="carousel-item" data-interval="3000">
      <a href="${appRoot }/main/signup"><img src="${appRoot }/resources/img/ba03.jpg" class="d-block w-100"  id="carousel-size"></a>
    </div>
  </div>
  <a class="carousel-control-prev" href="#carouselExampleInterval" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleInterval" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>		
		
<div> <p>임시</p>
	<c:url value="/board/write" var="writeUrl">	
			<c:param name="pageNum" value="${cri.pageNum }"></c:param>
			<c:param name="amount" value="${cri.amount }"></c:param>
	</c:url>
	<a href="${writeUrl }"><i class="fas fa-pen"></i> 글쓰기</a>
<br>

</div>		
		
<!-- 상품 목록 -->	
<h4>오늘의 상품 추천 </h4>

<div class="row row-cols-md-4">		  	
<!-- 상품 -->
<c:forEach items="${list }" var="market">
<c:url value="/board/getdetail" var="getUrl">
<c:param name="mno" value="${market.mno }" />
<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
<c:param name="amount" value="${pageMaker.cri.amount }" />
</c:url>	  
<a href="${getUrl}">	
  <div class="col mb-4">
    <div class="card">

	    	<img src="${appRoot }/resources/product/ma01.jpg" class="card-img-top" >
	   <%--  	<img src="${imgRoot }market/ 마켓번호르가져와서 그해당 게시물사진가져옴" class="card-img-top" > --%>
	     	<div class="card-body">	
	     		<span class="card-text">${market.mno }</span>
	 	     	<div class="card-title">${market.mtitle }</div>     
	       	</div>
	        
	       <div class="form-group">
		        <span class="card-text"><fmt:formatNumber pattern="#,###원" value="${market.mprice }"/></span>
				<!-- js파일에서 원하는 형태의 코드로 변경 후 elem 자체로 js로 보내기(로딩 스크립트 사용) -->
		        <span class="card-time-before">${market.mregdate.time }</span>
		        <span class="card-date">${timebefore }</span>
		        
	      		<hr>
	       		<div class="card-add">${market.maddress }</div>
	       </div>  
    </div>
  </div>
 </a> 
</c:forEach>	
</div>

<!--  pagenation -->
<div>
<nav aria-label="Page navigation example">
  <ul id="list-pagenation1" class="pagination justify-content-center">
    <c:if test="${pageMaker.prev }">
	    <li class="page-item">
	      <a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a>
	    </li>
  	</c:if>
	
	<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
	   <%-- href value 	
	   href="${appRoot }/board/list?pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}"	 
	   --%>
	    <li class="page-item"><a class="page-link"  href="${num }">${num }</a></li>
	</c:forEach>

	<c:if test="${pageMaker.next }">
	    <li class="page-item">
	      <a class="page-link" href="${pageMaker.endPage + 1 }">Next</a>
	    </li>
	</c:if>
  </ul>
</nav>

<div style="display: none;">
	<form id="actionForm" action="${appRoot }/board/market" method="get">
		<input name="pageNum" value="${pageMaker.cri.pageNum }" /> 
		<input name="amount" value="${pageMaker.cri.amount }" />
	</form>
</div>


</div>


</body>
</html>
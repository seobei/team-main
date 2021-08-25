<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>
<!DOCTYPE html>
<html>
<head>

<%@ include  file = "/WEB-INF/subModules/bootstrapHeader.jsp" %>

<script>
$(document).ready(function(){
	
		$('#orderSubmitBtn').click(function () {
			
			if($("#cartlist").val()==null){
				alert("구매할 상품이 없습니다");
				return false;
			}
			$('#form_order').submit();
		});	 		
	});	
	
</script>

<title>장바구니</title>
</head>
<body>
<div class= "container">
<nb:navbar/>
<nb:scroll />

<!-- jumbotron -->
<div class="jumbotron">
    <h1 class="display-4">장바구니</h1>
    <hr class="my-4">
    <p>장바구니 페이지</p>
</div>
<h2>장바구니</h2>
<hr>

 <form id="form_order" action="${appRoot }/store/order" method="post">
<table class="table">
   
    <thead class="thead-light">
    <tr>
      <th>번호</th>
      <th>상품명</th>
      <th>상세설명</th>
      <th>가격</th>
      <th>수량</th>
      <th>합계</th>
      <th>취소</th>
    </tr>
  </thead>
  
  <tbody>
    <c:forEach var="cart" items="${cart}" varStatus="status">

<script>
$(document).ready(function() {
	var deleteUrl = "${appRoot }/store/cartdelete";
	$("#cart-delete-btn${status.count}").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			$("form").attr("action", deleteUrl);
			$("form").submit();
		} else {
			
			return false;
		}
	});

});

</script>
    
<input name = "cno" type ="hidden" value = "${cart.cno }"/>
        <tr>     	
            <th id="cartlist">${status.count }</th>
            <th>${cart.title }</th>
            <td>${cart.detail }</td>
            <td><fmt:formatNumber pattern="#,###원" value="${cart.price}" /></td>

            <td>${cart.cartstock }</td>
            <td><fmt:formatNumber pattern="#,###원" value="${cart.money}" /></td>
            <td>
				<button type="submit" id="cart-delete-btn${status.count}" class="btn btn-outline-secondary"  >삭제</button>

            </td>
        </tr>  

    </c:forEach>
  </tbody>
  
   <tfoot>
    <tr>
        <td colspan="5"></td> 
		<td>주문금액 : </td>		
		<td><fmt:formatNumber pattern="#,###원" value="${sumMoney}" /></td>
    </tr>
  </tfoot>

</table>
<button type="submit" id="orderSubmitBtn" class="btn btn-lg btn-block btn-primary" >주문하기</button>
	</form>
	
<br>	
<br>	
	
	<footer>
		<nb:footer/>
	</footer>
	
</div>
</body>
</html>
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


<title>장바구니</title>
</head>
<body>
<div class= "container">

<!-- jumbotron -->
<div class="jumbotron">
    <h1 class="display-4">Index Carts</h1>
    <p class="lead">views/carts/index.jsp</p>
    <hr class="my-4">
    <p>장바구니 페이지</p>
</div>
<h2>장바구니</h2>
<hr>
<table class="table">
    <thead class="thead-light">
    <tr>
      <th class="allCheck">
      <input type="checkbox" name="allCheck" class="allCheck" id="allCheck" /><label for="allCheck">모두 선택</label>
      <script>
		$("#allCheck").click(function(){
		 var chk = $("#allCheck").prop("checked");
		 if(chk) {
		  $(".chBox").prop("checked", true);
		 } else {
		  $(".chBox").prop("checked", false);
		 }
		});
		</script>
      
      </th>
      <th>번호</th>
      <th>상품명</th>
      <th>상세설명</th>
      <th>가격</th>
      <th>수량</th>
      <th>합계</th>
      <th class="checkBox">
      	<button type="button"  class="selectDelete_btn">선택 삭제</button>
       <script>
		 $(".selectDelete_btn").click(function(){
		  var confirm_val = confirm("정말 삭제하시겠습니까?");
		  
		  if(confirm_val) {
		   var checkArr = new Array();
		   
		   $("input[class='chBox']:checked").each(function(){
		    checkArr.push($(this).attr("data-cartNum"));
		   });
		    
		   $.ajax({
		    url : "/store/deleteCart",
		    type : "post",
		    data : { chbox : checkArr },
		    success : function(){
		     location.href = "/store/cart";
		    }
		   });
		  } 
		 });
		</script>	
      	 
      </th>

    </tr>
  </thead>
  <tbody>
    <c:forEach var="cart" items="${cart}" varStatus="status">
        <tr>
        	<th><input type="checkbox" name="chBox" class="chBox" data-cartNum="${cart.pno }" />
        	<script>
			 $(".chBox").click(function(){
			  $("#allCheck").prop("checked", false);
			 });
			</script>
			</th>
            <th>${ status.count }</th>
            <th>${cart.title }</th>
            <td>${cart.detail }</td>
            <td><fmt:formatNumber pattern="#,###원" value="${cart.price}" /></td>
            <td>${cart.cartstock }</td>
            <td><fmt:formatNumber pattern="#,###원" value="${cart.money}" /></td>
            <td><i class="fas fa-times"></i><input type="button" class="delete_btn" data-cartNum="${cart.pno }" value="삭제"></input></td>
<%--         	<td> <form action="${appRoot }/store/cartdelete" method="post">
            	<input name = "cno" type = "hidden" value = "${cart.cno }"/>
				<button type = "submit" class="btn btn-outline-secondary" >삭제</button>	
			</form>
			</td> --%>
        
        </tr>
        
    </c:forEach>
  </tbody>
 <tfoot>
    <tr>
        <td colspan="5"></td> 
		<td>주문금액 : </td>		
		<td> ${sumMoney}</td>
    </tr>
  </tfoot> 
</table>

<form action="#" method="post">
<!--${appRoot}/store/order  -->
	<input name = "cno" type = "hidden" value = "${cart.cno }"/>
	<button type="submit" class="btn btn-lg btn-block btn-primary">주문하기</button>
</form>

</div>
</body>
</html> 
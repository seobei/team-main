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
$("#sendbtnTh").click(function() {
					
					if($("#orderRec").val()==""){
						alert("수령인을 입력해주세요.");
						$("#orderRec").focus();
						return false;
					}
					
					if($("#orderphone").val()==""){
						alert("연락처를 입력해주세요.");
						$("#orderphone").focus();
						return false;
					}
					
					if($("#userAddr1").val()==""){
						alert("우편번호를 입력해주세요.");
						$("#userAddr1").focus();
						return false;
					}
					if($("#userAddr2").val()==""){
						alert("주소를 입력해주세요.");
						$("#userAddr2").focus();
						return false;
					}
					if($("#userAddr3").val()==""){
						alert("상세주소를 입력해주세요.");
						$("#userAddr3").focus();
						return false;
					}
						
				});

</script>

<title>Insert title here</title>
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
      <th>제품명</th>
      <th>상세설명</th>
      <th>가격</th>
      <th>수량</th>
      <th>합계</th>
      <th>취소</th>
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
            <th>${status.count }</th>
            <th>${cart.title }</th>
            <td>${cart.detail }</td>
            <td><fmt:formatNumber pattern="#,###원" value="${cart.price}" /></td>
            <td>${cart.cartstock }</td>
            <td><fmt:formatNumber pattern="#,###원" value="${cart.money}" /></td>
            <td>
            <form action="${appRoot }/store/cartdelete" method="post">
            	<input name = "cno" type ="hidden" value = "${cart.cno }"/>
				<button type = "submit" class="btn btn-outline-secondary" >삭제</button>	
			</form>
            </td>
        </tr>  

    </c:forEach>
  </tbody>
  
   <tfoot>
    <tr>
        <td colspan="6"></td> 
		<td>주문금액 : </td>		
		<td><fmt:formatNumber pattern="#,###원" value="${sumMoney}" /></td>
    </tr>
  </tfoot>
</table>

<%-- 	<input name = "cno" type = "hidden" value = "${cart.cno }"/> --%>
	<button type="button" class="btn btn-lg btn-block btn-primary" data-toggle="modal" data-target="#callsec">주문하기</button>
	


<script>
$(document).ready(function() {
	$("#callsec").on("show.bs.modal", function() {
		$(".contentTh").val("");
		$("#sendbtnTh").prop("disabled", true);
		
		$(".contentTh").keyup(function(){
			$("#sendbtnTh").prop("disabled", false);	
		})
	})
});
</script>

			
	<!-- 주문정보입력 모달 -->
    <div class="modal fade" id="callsec" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">주문정보 입력</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="${appRoot }/store/order" method="post">
				<%-- 재경 	<input type="hidden" name="amount" value="${sum}" /> --%>
						  <div class="inputArea">
						   <label for="userid">받는 분</label>
						   <input type="text" readonly class="contentTh" name="userid" id="userid" required="required" />
						  </div>
	
						<div class="inputArea">
						   <label for="orderphone">연락처</label>
						   <input type="text" class="contentTh" name="orderphone" id="orderphone" required="required" />
						  </div>
						  
						  <div class="inputArea">
						   <label for="userAddr1">우편번호</label>
						   <input type="text"  class="contentTh" name="userAddr1" id="userAddr1" required="required" />
						  </div>
						  
						  <div class="inputArea">
						   <label for="userAddr2">주소</label>
						   <input type="text" class="contentTh" name="userAddr2" id="userAddr2" required="required" />
						  </div>
						  
						  <div class="inputArea">
						   <label for="userAddr3">상세주소</label>
						   <input type="text" class="contentTh" name="userAddr3" id="userAddr3" required="required" />
						  </div>
					 
						<div class="modal-footer">
							<button id="sendbtnTh" type="submit" class="btn btn-secondary" >주문</button>
							<button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
						</div>		
					</form>					
				</div>
			</div>
		</div>
	</div>								



</div>
</body>
</html>
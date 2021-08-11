<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="nb" tagdir="/WEB-INF/tags/nb" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file = "/WEB-INF/subModules/bootstrapHeader.jsp" %>

<script>
$(document).ready(function(){
	
	$("input[type=checkbox]").prop("checked", true);
	
	/* 맨위 모두클릭버튼기능 */
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});	
 	
	/*포인트모두사용버튼  */
	$('#useMaxPointBtn').click(function () {
 		var totalP = $('#requireTotalPrice').val();
 		$('#usePoint').val(totalP);
	});
	 /* 남은포인트 */
	 function reaminP() {
		var useP = $("#usePoint").val();
		var authP = $("#authPoint").val();
		Number(useP);
		Number(authP);
		$('#remainPoint').val(authP - useP);
		$('.remainPoint').html(authP - useP);
	 }
	 
	$("#usePoint").on('change',function(){
		reaminP();
	});
	$("#useMaxPointBtn").on('click',function(){
		reaminP();
	});
	/* 남은포인트가 */
	

	/* 체크된것들로 가격총합을 바꿔서 넣어주는 함수 */
	function updateTotalPrice() {
		var totalPrice = 0;
		$('input:checkbox[name="checkbox"]:checked').each(function(){
			var index = $(this).data("index");
			var popriceName = "orderVOList["+index+"].order_poprice";
			var poquantityName = "orderVOList["+index+"].order_quantity";
			var poprice = $('input[name="'+ popriceName + '"]').val();
			var poquantity = $('input[name="'+poquantityName+'"]').val();
			var sectorPrice = poprice * poquantity;
			totalPrice += sectorPrice;
		});
			var deliveryPrice = Number( $('#deliveryPrice').html() );
			if(totalPrice != 0 ){
				totalPrice += deliveryPrice;
			}
			
		$('#requireTotalPrice').val(totalPrice);
		$('.requireTotalPrice').each(function(){
			$(this).html(totalPrice);
		});
	};
	/* 일단 첫 로딩시 총가격 실행 */
	updateTotalPrice();
	/* 체크박스누를때마다 체크박스된것들로 총합 바꾸기 */
	$('input:checkbox[name="checkbox"]').click(function () {
		updateTotalPrice();
	});
	
	/*전송버튼 누를때 체크된것들만 보내기  */
 	$('#submit_btn').click(function (e) {
		e.preventDefault();
		
		/*check안된 input들을 disabled해서 못보내게함  */
		$('input:checkbox[name="checkbox"]:not(:checked)').each(function(){
			var className = $(this).val();
			$('.'+className).attr("disabled", true);
		});
		
		/* 못보내면 name에 리스트번호가 꼬이니 OrderVO안의 list의 인덱스번호를 다시구성 해줘야함*/
		var num = 0;
		$('input:checkbox[name="checkbox"]:checked').each(function(){
			var className = $(this).val();
			$('.'+className).each(function(){
				var inputName = $(this).attr("name");
				var first = inputName.indexOf("[");
				var last = inputName.indexOf("]");
				var beforeIndex = inputName.substring(first+1,last);
				var newInputName = inputName.replace(beforeIndex, num);
				$(this).attr("name", newInputName);
				
				console.log(newInputName);
			});
			num++;
		});
		
		/* 보내기전에 총금액과 사용금액이 다르면 안됨*/
		var authP = $('#requireTotalPrice').val();
		var useP = $('#usePoint').val();
		if(authP != useP){
			alert("구매 총 금액과 사용금액이 다릅니다");
			return
		}
		/*보내기전에 포인트보유가 마이너스면 안됨*/
		var remainP = $('#remainPoint').val();
		Number(remainP);
		if(remainP<0){
			alert("보유금액이부족합니다");
			return
		}
 		$('#form_order').submit();
	});
	
	
});
</script>


<title>주문/결제하기 페이지</title>
</head>
<body>
<div class= "container">
<nb:navbar/>
<nb:scroll />


<!-- jumbotron -->
<div class="jumbotron">
    <h1 class="display-4">Index Carts</h1>
    <p class="lead">views/carts/index.jsp</p>
    <hr class="my-4">
    <p>주문/결제하기 페이지</p>
</div>
<h2>주문/결제하기 페이지</h2>
<hr>
<table class="table">
    <thead class="thead-light">
    <tr>
      <th>#</th>
      <th>제품명</th>
      <th>상세설명</th>
      <th>가격</th>
      <th>수량</th>
    </tr>
  </thead>
  <tbody>
  <%--   <c:forEach var="cart" items="${cart}" varStatus="status">
        <tr>
            <th>${ status.count }</th>
            <th>${cart.title }</th>
            <td>${cart.detail }</td>
            <td>${cart.price}</td>
            <td>${cart.cartstock }</td>
        </tr>      
    </c:forEach> --%>
  </tbody>
  
   <tfoot>
    <tr>
        <td></td> 
		<td>주문금액 : </td>		
		<td> <%-- ${sumMoney} --%></td>
		<td>내 보유 포인트 : </td>
		<td></td>
    </tr>
  </tfoot>
</table>
<hr>
<form>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputid">수령인</label>
      <input type="text" class="form-control" id="inputid">
    </div>
  </div>
  <div class="form-group">
    <label for="inputphone">연락처</label>
    <input type="text" class="form-control" id="inputphone" placeholder="1234 Main St">
  </div>
  <div class="form-group">
    <label for="inputAddress">Address</label>
    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
  </div>
  <div class="form-group">
    <label for="inputAddress2">Address 2</label>
    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
  </div>
  <div class="form-group">
    <label for="inputAddress2">Address 3</label>
    <input type="text" class="form-control" id="inputAddress3" placeholder="Apartment, studio, or floor">
  </div>
  <div class="form-row">
    <div class="form-group col-md-6">
      <label for="inputCity">City</label>
      <input type="text" class="form-control" id="inputCity">
    </div>
    <div class="form-group col-md-4">
      <label for="inputState">State</label>
      <select id="inputState" class="form-control">
        <option selected>Choose...</option>
        <option>...</option>
      </select>
    </div>
    <div class="form-group col-md-2">
      <label for="inputZip">Zip</label>
      <input type="text" class="form-control" id="inputZip">
    </div>
  </div>
</form>

<div class="jumbotron">
					<h5>결제 정보</h5><br>
					<hr>
						<table class="table1">
							<tbody>

								<tr>
									<th><p>보유 포인트</p></th>
									<td>
										<p class="text-right">718,100 </p>
										<input id="authPoint" value="718100" hidden="hidden">
									</td>
									<td><p>포인트</p></td>
								</tr>
								<tr>
									<th><p>사용 포인트</th>
									<td>
										<input class="text-right" id="usePoint" min="0" max="${user.point}" name="usePoint" type="number"/>
									</td>
									<td><button id="useMaxPointBtn" class="btn_add" type="button">포인트 모두 사용</button></td>
								</tr>
								<tr>
									<th><p>결제 금액</p></th>
									<td><p class="text-right"><span class="requireTotalPrice"></span></p></td>
									<td><p>원</p></td>
								</tr>
							</tbody>
						</table>
						
							<button id="submit_btn" class="send_btn">구매하기</button>
							
							<div class="my-5">
							</div>

</div>
				
<button type="submit" class="btn btn-lg btn-block btn-primary">주문완료</button>
<button onclick="history.back()" class="btn btn-warning">Back</button>

	<footer>
			<nb:footer/>
		</footer>

</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<html>

<head>
<link href="/resources/assets/css/order.css" rel="stylesheet">
<script defer type="text/javascript" src="/resources/assets/js/daumPostcode.js"></script>

<script>

function back(){
	window.history.back();
}

function inputCheck(){
	var name = $('input[name=o_name]').val();
	var zipcode = $('input[name=o_zipcode]').val();
	var address1 = $('input[name=o_address1]').val();
	var address2 = $('input[name=o_address2]').val();
	var mobile = $('input[name=o_mobile]').val();

	if(name == ''){
		alert('이름을 입력해주세요.');
		$('input[name=o_name]').focus();
		return false;
	}
	
	if(zipcode == null || zipcode == ''){
		alert('우편번호를 입력해주세요.');
		$('input[name=o_zipcode]').focus();
		return false;
	}
	
	if(address1 == null || address1 == ''){
		alert('주소를 입력해주세요.');
		$('input[name=o_address1]').focus();
		return false;
	}
	
	if(address2 == null || address2 == ''){
		alert('상세주소를 입력해주세요.');
		$('input[name=o_address2]').focus();
		return false;
	}
	
	if(mobile == null || mobile == ''){
		alert('휴대폰번호를 입력해주세요.');
		$('input[name=o_mobile]').focus();
		return false;
	}
	
	return true;
	
	
}

function selectEmail(selectValue){
	$('#email2').val(selectValue);
	
	if(selectValue != ''){
		
		document.getElementById('email2').readOnly = true;
	}else{
		
		document.getElementById('email2').readOnly = false;
	}
	
	
}

function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function orderStart(){
	let orderPrice = 0;
	let orderForm = $('#order').find(".price");
	
	//주문 합계 더하기
	$.each(orderForm, function(index, item){
		let price = $(item).text().replace(',', '');
		orderPrice += parseInt(price);
		
	})
	
	//상품구매금액 넣어주기
	$('.orderPrice').text(priceToString(orderPrice));
	
	
	
	let dp = 0;
	let totalPrice = orderPrice;
	
	if(orderPrice < 30000){
		dp = 3000;
		totalPrice += dp;
	}else{
		dp = '무료배송';
	}
	$('.dp').text(priceToString(dp));
	
	$('.totalPrice').text(priceToString(totalPrice));
	$('.o_tprice').val(parseInt(totalPrice));
}



function goMain(){
	let count = $('#order').find('tr').length - 1;
		if(count == '0'){
		alert('주문할 상품이 없어 메인페이지로 이동됩니다');
			self.location ="/main.toy";
			return false;
	} 
		location.reload()
}


function deleteOrder(b_num){
	
	$.ajax({
		url : "/basket/deleteTemp.toy",
		type : "post",
		contentType : "application/json; charset=utf-8",
		data : JSON.stringify({b_num : b_num}),
		success : function(data){
			
		}
	}); //and ajax
	
	goMain();
	
	
}//end deleteOrder

	$(document).ready(function() {
		orderStart()

		$('#orderBtn').on('click', function() {
			if(!inputCheck()){
				return false;
				alert('나오면안됨');
			}
			getOrderNum();
			buy();
			window.location.replace("/order/orderSuccessForm.toy")
		})
		
		$('#resetInfo').change(function(){
			var form = $('#deliveryInfo');
			form.find('input').val(null)
		})
		
		
		$('.request').keyup(function(){
			let count = $('.request').val().length(); 
			$('#requestCheck').val(count);
		})
		
		
		
		
	})
	
function getOrderNum(){

	let orderNum = "";
	
	$.ajax({
		type : 'post',
		url : '/order/getOrderNum.toy',
		async : false,
		success : function(data){
			orderNum = data;
		},
		error : function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	})
	
	$('.o_invoice').val(orderNum);
	
	
}
	
	
function buy(){
	
	let email = $('#email1').val() + "@" + $('#email2').val();
	
	$('#orderEmail').val(email);
	
	var orderForm = $("form[id^='orderForm']").get();
	
	
	
	$.each(orderForm, function(index, item){
		var formOrder = $('#orderForm'+index+', #deliveryInfo');
		
		
		
		$.ajax({
			type : 'post',
			url : '/order/orderPro.toy',
			data : formOrder.serialize(),
			success : function(data){
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
			
		
		})
	
	})
}



	
</script>


</head>
<body>


	<section style="margin-top: 150px; padding-bottom: 30px;">
		<div class="container">

			<div class="order-header">
			<h3 style="font-weight: bold;">ORDER</h3>
			</div>

			<table class="order-form">
				<thead>
					<tr>
						<!-- <td><input name="item" value="selectAll" type="checkbox" onclick="selectAll(this)"></td> -->
						<td style="text-align: center;">상품이미지</td>
						<td style="text-align: center;">상품명</td>
						<td style="text-align: center;">판매가</td>
						<td style="text-align: center; padding:0 0 0 20px;">수량</td>
						<td style="padding:0 0 0 57px;">합계</td>
						<td style="padding:0 0 0 5px;">관리</td>
						
					</tr>
				</thead>

				<tbody id="order">


					<c:forEach items="${tempList }" var="list" varStatus="status">
					<fmt:parseNumber var="salePrice" integerOnly="true" value="${list.g_price * (100 - list.g_sale)/100 }"/>
						<tr>
							<%-- <td><input type="checkbox" name="item" value="${list.b_num }"></td> --%>
							<td style="text-align: center;"><img src="${pageContext.request.contextPath}/resources/assets/img/image/${list.f_svname }" class="radius_img" alt="" style='width: 100px; height: 100px'></td>
							<td style="text-align: center;"><c:out value="${list.g_name }" /> [<c:out value="${list.b_option }" />]</td>
							<%-- <td class='price'><c:out value="${list.b_price }" /></td> --%>
							<td style="text-align: center;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.b_price *  (100 - list.g_sale) / 100}" /></td>
							<td style="text-align: center; padding:0 0 0 20px;"><c:out value="${list.b_count }" /> 개</td>
							<td class='price' style="padding:0 0 0 57px;">
								<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.b_count * list.b_price *  (100 - list.g_sale) / 100}" />
<%-- 								<c:out value="${list.b_price * list.b_count}" /> --%>
							</td>
							<td >
								<button class="delbtn" type="button" id="delete" onclick="deleteOrder(${list.b_num})">삭제</button>								
							</td>
						</tr>
					</c:forEach>

				</tbody>

			</table>

			<div
				style="width: 700px; text-align: center; margin: auto; padding-top: 20px;">
				 
				
				
				<div style="float: right; line-height: 1.9;">  
				<p class="p_custom" style="display: block; font-size: 14.5px;">
								<span class="cell_tit">상품구매금액 </span> <span class="orderPrice">0</span>
								<span class="cell_tit">+ 배송비 </span> <span class="dp"></span>
								<span class="cell_tit">= 총 결제 금액 : </span><span class="totalPrice" style="font-weight: bold;"></span>원
								</p>
				
				
					<!-- <span style="display:block;"><span style="float:left;">상품구매금액 : </span><span style="text-align:right; float:right;" class="orderPrice">0</span></span>
					<span style="display:block;"><span style="float:left;">배송비 : </span><span style="text-align:right; float:right;" class="dp"></span></span>
					<span style="display:block;"><span style="float:left;">총 결제 금액 : </span><span style="text-align:right; float:right;" class="totalPrice"></span></span>
				 --></div>
				

			</div>
		</div>
	</section>

	<section style="padding-top: 10px; margin-bottom: 80px;">
		<div class="container">
			<div class="order-header2" style="font-weight: bold;">배 송 정 보</div>
		</div>

		<c:forEach items="${tempList }" var="model" varStatus="status">
				<form action="/order/orderPro.toy" class="orderForm" id="orderForm${status.index}" method="post">
					<input type="hidden" id="feeYn" name="o_dfeeYN" value="1">
					<input type="hidden" name="g_id" value="<c:out value='${model.g_id }'/>"> 
					<input type="hidden" name="o_option" value="<c:out value='${model.b_option }'/>"> 
					<input type="hidden" name="o_count" value="<c:out value='${model.b_count }'/>">
					<input type="hidden" name="g_name" value="<c:out value='${model.g_name }'/>">
					<input type="hidden" name="b_num" value="<c:out value='${model.b_num }'/>">
					<input type="hidden" name="m_num" value="${sessionScope.loginNum }"/>
					<input type="hidden" name="o_price" value="<c:out value='${model.b_price }'/>">
					<input type="hidden" class="o_invoice" name="o_invoice" value=""/>
					<input type="hidden" class="o_tprice" name="o_tprice" value=""/>
				</form>
		</c:forEach>			
			
		<form id="deliveryInfo">
			<input type="hidden" name="o_email" id="orderEmail" value="">
		<div class="container" style="width: 700px;">
			<table class="table" style="font-size: 14px;">
				<tr>
					<td>배송비 선택</td>
					<td colspan="2"><input type="radio" name="delInfo" checked>
						회원 정보와 동일 <input type="radio" name="delInfo" id="resetInfo" name="배송지"> 새로운 배송지</td>
				</tr>

				<tr>
					<td style="width: 120px;">받으시는 분 <img alt="required" class="rimg" src="/resources/assets/img/required_icon.gif"></td>
					<td colspan="2" style="width: 300px; height: 41px;">
						<input class="form-control-add form-control" style="font-size: 14px; height: 27px; border-radius: 0px;" name="o_name" value="<c:out value='${memberModel.m_name }'/>" maxlength="10"> 
						</td>
				</tr>

				<tr>
					<td rowspan="3">주소 <img alt="required" class="rimg" src="/resources/assets/img/required_icon.gif"></td>
					<td colspan="2" style="height: 41px;">
						<input id="sample6_postcode" name="o_zipcode" class="form-control" style="border-radius: 0px; width: 100px; font-size: 14px; height: 27px;" value="<c:out value='${memberModel.m_zipcode }'/>">
						<button type="button" class="findZipcode btn btn-purple" onclick="sample6_execDaumPostcode()" style="padding-top:4px;padding-bottom:3px; vertical-align:baseline; font-size: 13px;">우편번호</button>
					</td>
				</tr>

				<tr>
					<td style="height: 41px;">
						<input style="font-size: 14px; height: 27px; border-radius: 0px;" class="form-control-add form-control" id="sample6_address" name="o_address1" value="<c:out value='${memberModel.m_address1 }'/>">
						
					</td>
					<td style=" vertical-align: middle; padding-left: 0px; font-size: 12px;">기본주소</td>
				</tr>

				<tr>
					<td style="height: 41px;">
						<input style="font-size: 14px; height: 27px; border-radius: 0px;" class="form-control-add form-control" id="sample6_detailAddress" name="o_address2" value="<c:out value='${memberModel.m_address2 }'/>" maxlength="30">
						</td>
					<td style=" vertical-align: middle; padding-left: 0px; font-size: 12px;">나머지주소</td>
				</tr>

				<tr>
					<td style="height: 41px;">휴대전화 <img alt="required" class="rimg" src="/resources/assets/img/required_icon.gif"></td>
					<td colspan="2"><input style="font-size: 14px; height: 27px; border-radius: 0px;" class="form-control-add form-control" maxlength="12"
						type="text" name="o_mobile" value="<c:out value='${memberModel.m_mobile }'/>"></td>
				</tr>

				<tr>
					<td style="height: 41px;">전화번호 <img alt="required" class="rimg" src="/resources/assets/img/required_icon.gif"></td>
					<td colspan="2"><input style="font-size: 14px; height: 27px; border-radius: 0px;" class="form-control-add form-control" maxlength="11"
						type="text"  name="o_tel" value="<c:out value='${memberModel.m_phone }'/>"></td>
				</tr>

				<tr>
					<td style="height: 41px;">이메일 <img alt="required" class="rimg" src="/resources/assets/img/required_icon.gif"></td>
					<td colspan="3"><input  type="text" id="email1" class="form-control-add form-control" style="border-radius: 0px; width: 150px; font-size: 14px; height: 27px;"	value="${fn:substringBefore(memberModel.m_email, '@') }" maxlength="15">
									@ <input type="text" id="email2" style="border-radius: 0px; width: 150px; font-size: 14px; height: 27px;" class="form-control-add form-control" type="text"	value="${fn:substringAfter(memberModel.m_email, '@') }" maxlength="15">
									
									 
					<select class="selectEmail" style="width: 100px" name="m_email" onchange="selectEmail(this.value)">
							<option value="" selected>직접입력</option>
							<option value="gmail.com">gmail.com</option>
							<option value="naver.com">naver.com</option>
							<option value="me.com">me.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="empas.com">empas.com"</option>
					</select></td>


				</tr>

				<tr>
					<td><div>배송메시지</div></td>
					<td colspan="2" style="width:400px; height: 136px; vertical-align: middle;"><textarea class="form-control" name="o_request" class="request"
							style="width: 400px; height: 120px; font-size: 14px; border-radius: 0px;" placeholder="빠른 배송 부탁드립니다." maxlength="300"></textarea>
					</td>
					
					<td><div id="requestCheck"></div>
					</td>
				</tr>

				<tr>
					<td colspan="3" style="padding-top: 30px; font-weight: bold;">결제 예정 금액</td>
				</tr>

				<tr>
					<td colspan="3">
						<div style="text-align: center">
							<span style="float: left">총 주문금액</span> <span>총 할인 + 부가 결제
								금액(배송비)</span> <span style="float: right">총 결제 예정 금액</span>
						</div>

					</td>
				</tr>

				<tr>
					<td colspan="3">
						<div style="text-align: center">
							<span class="orderPrice" style="float: left; font-size: 18px; font-weight: bold;"></span> <span
								class="dp" style="font-size: 18px; font-weight: bold;"></span><span style="float: right;font-size: 18px; font-weight: bold; color:#9b55d4;"
								class="totalPrice"></span>
						</div>
					</td>
				</tr>

				<!-- <tr>
					<td colspan="3" style="text-align: center; height: 70px; vertical-align: middle;">
						 <button type="button" class="btn btn-outline-submit"
							style="height: 35px; width: 70px; padding-top: 4px;padding-botton: 4px;" onclick="back()">취소</button>
						<button type="button" id="orderBtn" class="btn btn-purple"
							style="height: 35px; width: 70px; padding-top: 4px;padding-botton: 4px;">주문</button>
					 </td>
				</tr> -->
 		</table>
			
			<div style="text-align: center; margin-top: 33px;">
				<button type="button" class="btn btn-outline-submit"
							style="height: 35px; width: 170px; padding-top: 4px;padding-botton: 4px;" onclick="back()">취소</button>
						<button type="button" id="orderBtn" class="btn btn-purple"
							style="height: 35px; width: 170px; padding-top: 4px;padding-botton: 4px;">주문하기</button>
			</div>
					
			</div>
		</form>



	</section>



</body>



</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>

<head>
<link href="/resources/assets/css/order.css" rel="stylesheet">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<script defer type="text/javascript"
	src="/resources/assets/js/daumPostcode.js"></script>
<!-- <script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script> -->
<!-- <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> -->
<%--  <script type="text/javascript"src="<c:url value="/resources/js/orderPost.js"/>" ></script> --%>

<script type="text/javascript">
	/*var memId="${MEM_ID}";
	 if(memId==""){
	 var memPWD="${OR_PWD}";
	 if(memPWD==""){
	 location.href="<c:url value='/item/pwdOrder'/>";
	 }
	
	 } */

	var totalPrice = 0;
	var totalPoint = 0;
	var memberPoint = 0;
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	$(document)
			.ready(
					function() {

						$
								.ajax({
									type : "POST",
									url : "<c:url value='/order/orderStart.toy'/>",
									success : function(data) {
										if (data.order != null) {
											//alert(data.order.M_NUM));
											$("input[name='m_num']").val(
													data.order.M_NUM);
											$("input[name='o_name']").val(
													data.order.M_NAME);
											$("input[name='o_mobile']").val(
													data.order.M_MOBILE);
											$("input[name='o_tel']").val(
													data.order.M_PHONE);
											$("input[name='o_zipcode']").val(
													data.order.M_ZIPCODE);
											$("input[name='o_address1']").val(
													data.order.M_ADDRESS1);
											$("input[name='o_address2']").val(
													data.order.M_ADDRESS2);
											$("input[name='o_address2']").val(
													data.order.M_ADDRESS2);

											/* $("#USER_POINT").text(data.member.MEM_POINT);
											memberPoint=data.member.MEM_POINT; */
										} else {
											$("input[name='OR_USEP']").attr(
													'readonly', true);
											$("input[name='OR_USEP']").val("0");
											$("#USER_POINT").text("0");
										}

										var str = "";
										$
												.each(
														data.list,
														function(index, items) {

															totalPrice += parseInt(items.G_PRICE
																	* items.B_COUNT);
															o_df = parseInt(totalPrice >= 30000 ? 1
																	: 2);
															if (o_df == 1) {
																totalPrice += 0;
															} else {
																totalPrice += 3000;
															}
															/* alert(o_df); */
															//alert(items.B_COUNT);
															//alert(items.G_PRICE);
															if (totalPrice >= 30000) {
																$("#o_dfee")
																		.val(
																				'N');
																$("#o_df").val(
																		'무료');
															} else {
																$("#o_dfee")
																		.val(
																				'Y');
																$("#o_df")
																		.val(
																				'3000원');
															}

															//totalPoint+=parseInt(items.CART_CNT*items.G_PRICE)*0.02;
															str += "<tr class='tr-line'>"
																	+ "<td class='text-center' style='vertical-align: middle;'>"
																	+ "<div class='item-img'>"
																	+ "<img src='/resources/assets/img/image/"
																	+ items.F_SVNAME
																	+ "' style='border-radius: 10%;' width='70' height='70' alt=''>"
																	+ "</div>"
																	+ "</td>"
																	+ "<td>"
																	+ "<form id='items"+index+"'>"
																	+ "<input type='hidden' name='b_num' value='"+items.B_NUM+"'>"
																	+ "<input type='hidden' name='g_id' value='"+items.G_ID+"'>"
																	+ "<input type='hidden' name='o_count' value='"+items.B_COUNT+"'>"
																	+ "<input type='hidden' name='o_option' value='"+items.B_OPTION+"'>"
																	+ "<input type='hidden' name='o_price' value='"+items.G_PRICE+"'>"
																	+ "<input type='hidden' name='o_tprice' value='"
																	+ parseInt(items.B_COUNT
																			* items.G_PRICE)
																	+ "'>"
																	+
																	/* "<input type='hidden' name='o_dfee_yn' value='"Y"'>"+  */
																	/* "<input type='hidden' name='OR_DCM' value='"+items.ITEM_FP+"'>"+ */
																	/* "<input type='hidden' name='PLUS_POINT' value='"+parseInt(items.CART_CNT*items.ITEM_OP_PRICE)*0.02+"'>"+ */
																	"</form>"
																	+ "<b>"
																	+ items.G_NAME
																	+ "</b>"
																	+ "<div class='well well-sm'>"
																	+ "<ul style='line-height: 20px; padding-left:0px;'>"
																	+ "<li style='list-style:none; margin-top:5px; color:#c2c2c2;'>"
																	+ items.B_OPTION
																	+ "</li>"
																	+ "</ul>"
																	+ "</div></td>"
																	+ "<td class='text-center' style='vertical-align: middle;'>"
																	+ items.B_COUNT
																	+ "</td>"
																	+ "<td class='text-center' style='vertical-align: middle;'>"
																	+ numberWithCommas(items.G_PRICE)
																	+ "원</td>"
																	+ "<td class='text-center' style='vertical-align: middle;'></td>"
																	+ "<td class='text-center' style='vertical-align: middle; font-size:18px; color:#9b55d4;'><b>"
																	+ numberWithCommas(parseInt(items.B_COUNT
																			* items.G_PRICE))
																	+ "원</b></td>"
																	+
																	/* "<td class='text-right'>"+numberWithCommas(parseInt(items.B_COUNT*items.G_PRICE)*0.02)+"</td>"+ */

																	"</tr>";

														})

										$("#sod_list tbody").append(str);
										$("#ct_tot_price").text(
												numberWithCommas(totalPrice)
														+ " 원");
										$("#ct_tot_price2").text(
												numberWithCommas(totalPrice));
										/* $("#to_point").text(numberWithCommas(totalPoint)+" 점") */

									}

								});

						$("input[name='OR_USEP']").keyup(function() {
							var num = $(this).val();
							if (totalPrice < num) {
								$(this).val(totalPrice);
								$("#ct_tot_price2").text("0");
								return true;
							}
							if (jQuery.isNumeric(num) == true) {
								if (memberPoint < num || memberPoint < 0) {
									$(this).val("0");
									$("#ct_tot_price2").text(totalPrice - 0);
									return true;
								}
								$("#ct_tot_price2").text(totalPrice - num);
							} else {
								$(this).val("0");
								$("#ct_tot_price2").text(totalPrice - 0);

							}

						});

					});

	function card() {
		var IMP = window.IMP; // 생략가능
		IMP.init('imp52095000'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

		IMP.request_pay({
			pg : 'inicis', // version 1.1.0부터 지원.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '주문명:결제테스트',
			amount : 100,
			buyer_email : 'iamport@siot.do',
			buyer_name : '구매자이름',
			buyer_tel : '010-1234-5678',
			buyer_addr : '서울특별시 강남구 삼성동',
			buyer_postcode : '123-456',
			m_redirect_url : 'https://www.yourdomain.com/payments/complete'
		}, function(rsp) {
			if (rsp.success) {
				/*  var msg = '결제가 완료되었습니다.';
				 msg += '고유ID : ' + rsp.imp_uid;
				 msg += '상점 거래ID : ' + rsp.merchant_uid;
				 msg += '결제 금액 : ' + rsp.paid_amount;
				 msg += '카드 승인번호 : ' + rsp.apply_num; */

				var sdd = (rsp.imp_uid).split('_');
				$("input[name='OR_NUM']").val(sdd[1]);
				orderSucess();
				alert("결제성공!");
				goPost(sdd[1]);
			} else {

				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}

		});

	}

	function orderf() {

		if ($("input[name='o_name']").val().length == 0) {
			alert("이름입력");
			$("input[name='o_name']").focus();
			return;
		}
		if ($("input[name='o_mobile']").val().length == 0) {
			alert("전화번호입력");
			$("input[name='o_mobile']").focus();
			return;
		}
		if ($("input[name='o_zipcode']").val().length == 0) {
			alert("주소입력");
			$("input[name='o_zipcode']").focus();
			return;
		}
		if ($("input[name='o_address1']").val().length == 0) {
			alert("주소입력");
			$("input[name='o_address1']").focus();
			return;
		}
		if ($("input:radio[name='OR_HOW']").is(":checked") == false) {
			alert("결제수단 체크");
			$("input:radio[name='OR_HOW']").focus();
			return;
		}

		//card();
		orderSucess();

	}

	function orderSucess() {
		var items = $("form[id^='items']").get();
		$.each(items, function(index, item) {
			var formOrder = $("#items" + index + ",#orderForm, #o_dfee")
					.serialize();
			$.ajax({
				type : "POST",
				url : "<c:url value='/order/buy.toy'/>",
				data : formOrder,
				async : false,
				success : function(data) {

				}
			});
		})
		alert("주문 완료!");
		location.href = "<c:url value='/main.toy'/>";

		/* var formOrder=$("#orderForm").serialize();
		$.ajax({
			type : "POST",
			url : "<c:url value='/item/delPoint'/>",
			data : formOrder,
			async: false,
			success : function(data){
				
				
			}
		}); */

	}

	function orderc() {
		location.href = "<c:url value='/main.toy'/>";
	}

	///////////////////////////

	/* function odfee(){
	
	 if($(".dfee_price").val() >= 30000){
	 $("#o_dfee").attr('value','Y');
	 }else{
	 $("#o_dfee").attr('value','N');
	 }
	 return;
	 } */

	///////////////////////////
	function goPost(sdd) {
		var obj1 = sdd;

		var form = document.createElement("form");

		form.setAttribute("charset", "UTF-8");

		form.setAttribute("method", "Post"); // Get 또는 Post 입력

		form.setAttribute("action", "<c:url value='/order/orderSuccess'/>");

		var hiddenField = document.createElement("input");

		hiddenField.setAttribute("type", "hidden");

		hiddenField.setAttribute("name", "o_num");

		hiddenField.setAttribute("value", obj1);

		form.appendChild(hiddenField);

		/* var url ="target.jsp"

		 var title = "testpop"

		 var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=1240, height=1200, top=0,left=20"

		 window.open("", title,status); //팝업 창으로 띄우기. 원치 않으면 주석.
		 */

		document.body.appendChild(form);

		form.submit();

	}
</script>
</head>
<body>
	<div class="container" style="margin-top: 250px; margin-bottom: 80px;">

		<div class="order-header">
			<h3 style="font-weight: bold;">ORDER</h3>
		</div>

		<div class="table-responsive order-item">
			<table id="sod_list" class="div-table table bg-white bsk-tbl">
				<tbody>
					<tr class="tr-head border-black">
						<th scope="col" style="text-align: center;"><span>이미지</span></th>
						<th scope="col" style="text-align: left;"><span>상품명</span></th>
						<th scope="col" style="text-align: center;"><span>수량</span></th>
						<th scope="col" style="text-align: center;"><span>가격</span></th>
						<th scope="col"><span> </span></th>
						<th scope="col" style="text-align: center;"><span>합계</span></th>
						<!-- <th scope="col"><span>포인트</span></th> -->

					</tr>
				</tbody>
			</table>
		</div>


		<!-- 주문상품 합계 시작 { -->
		<div class="card card-body bg-light">
			<div class="row ">

				<div class="col-sm-6" style="text-align: center;">배송비</div>
				<div class="col-sm-6 " style="text-align: center;">
					<strong> <input type="text" id="o_df" value=""
						style="border: none; padding-left: 168px; background-color: #f8f9fa;"
						readonly>
					</strong> <input type="hidden" class="dfee_price" id="o_dfee"
						name="o_dfee_yn" value="Y">
				</div>
			</div>

			<div class="row">
				<div class="col-sm-6 red"
					style="text-align: center; margin-top: 5px;">
					<b style="font-size: 18px;">주문금액</b>
				</div>
				<div class="col-sm-6 text-right red"
					style="text-align: center; margin-top: 5px;">
					<strong style="color: red; font-size: 18px;" id="ct_tot_price"></strong>
				</div>
			</div>

			<!-- <div class="row">
				<div class="col-sm-6">포인트</div>
				<div class="col-sm-6 text-right">
					<strong id="to_point"></strong>
				</div>
			</div> -->
		</div>


		<!-- 받으시는 분 입력 시작 { -->
		<form id="orderForm">
			<input type="hidden" name="m_num"> <input type="hidden"
				name="OR_NUM">
			<%-- <input type="hidden" name="OR_PWD" value="${OR_PWD}"> --%>
			<section id="sod_frm_taker">
				<div class="card panel-default">
					<div class="card-header">
						<strong><i class="fa fa-truck fa-lg"></i> 받으시는 분</strong>
					</div>
					<div class="card-body">

						<!-- <div class="form-group">
						<label class="col-sm-2 control-label"><b>배송지선택</b></label>
						<div class="col-sm-10 radio-line">
							
						</div>
					</div> -->

						<div class=" has-feedback" style="margin-bottom: 10px;">
							<label class="col-sm-2 control-label" for="od_b_name"
								style="margin-bottom: 5px;"><b>이름</b></label>
							<div class="input-group col-sm-3 ">
								<input type="text" name="o_name" id="od_b_name" required
									class="form-control" maxlength="20" style="height: 28px; font-size: 14px;">
								<div class="input-group-append">
									<span class="fa fa-check fa-lg mt-2 ml-1 form-control-feedback"></span>
								</div>
							</div>
						</div>
						<div class="form-group has-feedback" style="margin-bottom: 10px;">
							<label class="col-sm-2 control-label" for="od_b_tel"
								style="margin-bottom: 5px;"><b>핸드폰</b></label>
							<div class="input-group col-sm-3">
								<input type="text" name="o_mobile" id="od_b_tel" required
									class="form-control input-control-sm" style="height: 28px;"
									maxlength="20">
								<div class="input-group-append">
									<span class="fa fa-phone fa-lg mt-2 ml-1 form-control-feedback"></span>
								</div>
							</div>
						</div>

						<div class="form-group has-feedback" style="margin-bottom: 10px;">
							<label class="col-sm-2 control-label" for="od_b_tel"
								style="margin-bottom: 5px;"><b>전화번호</b></label>
							<div class="input-group col-sm-3">
								<input type="text" name="o_tel" id="od_b_tel" required
									class="form-control input-control-sm" maxlength="20">
								<div class="input-group-append">
									<span class="fa fa-phone fa-lg mt-2 ml-1 form-control-feedback"></span>
								</div>
							</div>

							<div class="form-group has-feedback" style="margin-bottom: 10px;">
								<label class="col-sm-3 control-label"
									style="margin-bottom: 5px;"><b>주소</b></label>
								<div class="col-sm-8">
									<label for="od_b_zip" class="sound_only"
										style="margin-bottom: 5px;">우편번호</label> <label> <input
										type="text" name="o_zipcode" id="sample6_postcode" required
										class="form-control input-sm" size="6" maxlength="6" readonly>
									</label> <label>
										<button type="button" class="btn btn-dark btn-sm"
											style="margin-top: 0px;" onclick="sample6_execDaumPostcode()">주소
											검색</button>
									</label>

									<div class="addr-line">
										<label class="sound_only" for="od_b_addr2"
											style="margin-bottom: 5px;">상세주소</label> <input type="text"
											name="o_address1" id="sample6_address"
											class="form-control input-control-sm" size="50"
											placeholder="상세주소">
									</div>
									<div class="addr-line">
										<label class="sound_only" for="od_b_addr3"
											style="margin-bottom: 5px;">상세주소</label> <input type="text"
											name="o_address2" id="sample6_address"
											class="form-control input-control-sm" size="50"
											placeholder="상세주소">
									</div>
								</div>
							</div>

							<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-2 control-label" for="od_memo"
									style="margin-bottom: 5px;"><b>배송요청사항</b></label>
								<div class="col-sm-8">
									<textarea name="o_request" rows=3 id="od_memo"
										class="form-control input-sm"></textarea>
								</div>
							</div>

						</div>
					</div>
			</section>

			<!-- } 받으시는 분 입력 끝 -->

			<div class="card-header " id="sod_frm_pt_alert">
				<i class="fa fa-bell fa-lg"></i> <strong>무통장입금</strong> 이외의 결제 수단으로
				결제하시는 경우 포인트를 적립해드리지 않습니다.

			</div>

			<section id="sod_frm_pay" class="order-payment">
				<div class="card card-default">
					<div class="card-header">
						<strong><i class="fa fa-check fa-lg"></i> 결제정보</strong>
					</div>
					<div class="card-body">
						<div class="form-group">
							<label class="col-sm-2 control-label"><b>총주문금액</b></label> <label
								class="col-sm-2 control-label"> <b><span
									style="color: red;" id="ct_tot_price2"></span></b>원
							</label>
						</div>
						<!-- <div class="form-group input-group ">
				<label class="col-sm-2 control-label"><b>포인트사용</b></label>
				
				<div class="input-group  col-sm-2">
					<input class=" form-control input-sm p-0" type="text" name="OR_USEP" > 원 
				</div>
				
			</div> -->
						<!-- <div class="form-group">
				<label class="col-sm-2 control-label"><b>사용가능포인트</b></label>
				<label class="col-sm-2 control-label">
					<span id="USER_POINT"></span>원
				</label>
			</div> -->
						<div class="form-group">
							<label class="col-sm-2 control-label"><b>추가배송비</b></label> <label
								class="col-sm-2 control-label"> <span id="od_send_cost2">0</span>원
							</label>
							<div class="col-sm-7">
								<label class="control-label text-muted font-12">지역에 따라
									추가되는 도선료 등의 배송비입니다.</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label"><b>결제방법</b></label>
							<div class="col-sm-10 radio-line">
								<label><input type="radio" id="OR_HOW" name="OR_HOW"
									value="신용카드"> 신용카드</label>

							</div>
						</div>


					</div>
				</div>
			</section>
		</form>
		<div id="display_pay_button" class="text-center btn_confirm">
			<input type="button" value="주문하기" onclick="orderf();"
				class=" btn btn-dark"> <input type="button" value="취소"
				onclick="orderc();" class=" btn btn-primary">

		</div>

	</div>
</body>



</html>

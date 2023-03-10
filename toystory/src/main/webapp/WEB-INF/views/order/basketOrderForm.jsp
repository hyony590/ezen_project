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
																		'??????');
															} else {
																$("#o_dfee")
																		.val(
																				'Y');
																$("#o_df")
																		.val(
																				'3000???');
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
																	+ "???</td>"
																	+ "<td class='text-center' style='vertical-align: middle;'></td>"
																	+ "<td class='text-center' style='vertical-align: middle; font-size:18px; color:#9b55d4;'><b>"
																	+ numberWithCommas(parseInt(items.B_COUNT
																			* items.G_PRICE))
																	+ "???</b></td>"
																	+
																	/* "<td class='text-right'>"+numberWithCommas(parseInt(items.B_COUNT*items.G_PRICE)*0.02)+"</td>"+ */

																	"</tr>";

														})

										$("#sod_list tbody").append(str);
										$("#ct_tot_price").text(
												numberWithCommas(totalPrice)
														+ " ???");
										$("#ct_tot_price2").text(
												numberWithCommas(totalPrice));
										/* $("#to_point").text(numberWithCommas(totalPoint)+" ???") */

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
		var IMP = window.IMP; // ????????????
		IMP.init('imp52095000'); // 'iamport' ?????? ???????????? "????????? ????????????"??? ??????

		IMP.request_pay({
			pg : 'inicis', // version 1.1.0?????? ??????.
			pay_method : 'card',
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '?????????:???????????????',
			amount : 100,
			buyer_email : 'iamport@siot.do',
			buyer_name : '???????????????',
			buyer_tel : '010-1234-5678',
			buyer_addr : '??????????????? ????????? ?????????',
			buyer_postcode : '123-456',
			m_redirect_url : 'https://www.yourdomain.com/payments/complete'
		}, function(rsp) {
			if (rsp.success) {
				/*  var msg = '????????? ?????????????????????.';
				 msg += '??????ID : ' + rsp.imp_uid;
				 msg += '?????? ??????ID : ' + rsp.merchant_uid;
				 msg += '?????? ?????? : ' + rsp.paid_amount;
				 msg += '?????? ???????????? : ' + rsp.apply_num; */

				var sdd = (rsp.imp_uid).split('_');
				$("input[name='OR_NUM']").val(sdd[1]);
				orderSucess();
				alert("????????????!");
				goPost(sdd[1]);
			} else {

				var msg = '????????? ?????????????????????.';
				msg += '???????????? : ' + rsp.error_msg;
			}

		});

	}

	function orderf() {

		if ($("input[name='o_name']").val().length == 0) {
			alert("????????????");
			$("input[name='o_name']").focus();
			return;
		}
		if ($("input[name='o_mobile']").val().length == 0) {
			alert("??????????????????");
			$("input[name='o_mobile']").focus();
			return;
		}
		if ($("input[name='o_zipcode']").val().length == 0) {
			alert("????????????");
			$("input[name='o_zipcode']").focus();
			return;
		}
		if ($("input[name='o_address1']").val().length == 0) {
			alert("????????????");
			$("input[name='o_address1']").focus();
			return;
		}
		if ($("input:radio[name='OR_HOW']").is(":checked") == false) {
			alert("???????????? ??????");
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
		alert("?????? ??????!");
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

		form.setAttribute("method", "Post"); // Get ?????? Post ??????

		form.setAttribute("action", "<c:url value='/order/orderSuccess'/>");

		var hiddenField = document.createElement("input");

		hiddenField.setAttribute("type", "hidden");

		hiddenField.setAttribute("name", "o_num");

		hiddenField.setAttribute("value", obj1);

		form.appendChild(hiddenField);

		/* var url ="target.jsp"

		 var title = "testpop"

		 var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=1240, height=1200, top=0,left=20"

		 window.open("", title,status); //?????? ????????? ?????????. ?????? ????????? ??????.
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
						<th scope="col" style="text-align: center;"><span>?????????</span></th>
						<th scope="col" style="text-align: left;"><span>?????????</span></th>
						<th scope="col" style="text-align: center;"><span>??????</span></th>
						<th scope="col" style="text-align: center;"><span>??????</span></th>
						<th scope="col"><span> </span></th>
						<th scope="col" style="text-align: center;"><span>??????</span></th>
						<!-- <th scope="col"><span>?????????</span></th> -->

					</tr>
				</tbody>
			</table>
		</div>


		<!-- ???????????? ?????? ?????? { -->
		<div class="card card-body bg-light">
			<div class="row ">

				<div class="col-sm-6" style="text-align: center;">?????????</div>
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
					<b style="font-size: 18px;">????????????</b>
				</div>
				<div class="col-sm-6 text-right red"
					style="text-align: center; margin-top: 5px;">
					<strong style="color: red; font-size: 18px;" id="ct_tot_price"></strong>
				</div>
			</div>

			<!-- <div class="row">
				<div class="col-sm-6">?????????</div>
				<div class="col-sm-6 text-right">
					<strong id="to_point"></strong>
				</div>
			</div> -->
		</div>


		<!-- ???????????? ??? ?????? ?????? { -->
		<form id="orderForm">
			<input type="hidden" name="m_num"> <input type="hidden"
				name="OR_NUM">
			<%-- <input type="hidden" name="OR_PWD" value="${OR_PWD}"> --%>
			<section id="sod_frm_taker">
				<div class="card panel-default">
					<div class="card-header">
						<strong><i class="fa fa-truck fa-lg"></i> ???????????? ???</strong>
					</div>
					<div class="card-body">

						<!-- <div class="form-group">
						<label class="col-sm-2 control-label"><b>???????????????</b></label>
						<div class="col-sm-10 radio-line">
							
						</div>
					</div> -->

						<div class=" has-feedback" style="margin-bottom: 10px;">
							<label class="col-sm-2 control-label" for="od_b_name"
								style="margin-bottom: 5px;"><b>??????</b></label>
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
								style="margin-bottom: 5px;"><b>?????????</b></label>
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
								style="margin-bottom: 5px;"><b>????????????</b></label>
							<div class="input-group col-sm-3">
								<input type="text" name="o_tel" id="od_b_tel" required
									class="form-control input-control-sm" maxlength="20">
								<div class="input-group-append">
									<span class="fa fa-phone fa-lg mt-2 ml-1 form-control-feedback"></span>
								</div>
							</div>

							<div class="form-group has-feedback" style="margin-bottom: 10px;">
								<label class="col-sm-3 control-label"
									style="margin-bottom: 5px;"><b>??????</b></label>
								<div class="col-sm-8">
									<label for="od_b_zip" class="sound_only"
										style="margin-bottom: 5px;">????????????</label> <label> <input
										type="text" name="o_zipcode" id="sample6_postcode" required
										class="form-control input-sm" size="6" maxlength="6" readonly>
									</label> <label>
										<button type="button" class="btn btn-dark btn-sm"
											style="margin-top: 0px;" onclick="sample6_execDaumPostcode()">??????
											??????</button>
									</label>

									<div class="addr-line">
										<label class="sound_only" for="od_b_addr2"
											style="margin-bottom: 5px;">????????????</label> <input type="text"
											name="o_address1" id="sample6_address"
											class="form-control input-control-sm" size="50"
											placeholder="????????????">
									</div>
									<div class="addr-line">
										<label class="sound_only" for="od_b_addr3"
											style="margin-bottom: 5px;">????????????</label> <input type="text"
											name="o_address2" id="sample6_address"
											class="form-control input-control-sm" size="50"
											placeholder="????????????">
									</div>
								</div>
							</div>

							<div class="form-group" style="margin-bottom: 10px;">
								<label class="col-sm-2 control-label" for="od_memo"
									style="margin-bottom: 5px;"><b>??????????????????</b></label>
								<div class="col-sm-8">
									<textarea name="o_request" rows=3 id="od_memo"
										class="form-control input-sm"></textarea>
								</div>
							</div>

						</div>
					</div>
			</section>

			<!-- } ???????????? ??? ?????? ??? -->

			<div class="card-header " id="sod_frm_pt_alert">
				<i class="fa fa-bell fa-lg"></i> <strong>???????????????</strong> ????????? ?????? ????????????
				??????????????? ?????? ???????????? ?????????????????? ????????????.

			</div>

			<section id="sod_frm_pay" class="order-payment">
				<div class="card card-default">
					<div class="card-header">
						<strong><i class="fa fa-check fa-lg"></i> ????????????</strong>
					</div>
					<div class="card-body">
						<div class="form-group">
							<label class="col-sm-2 control-label"><b>???????????????</b></label> <label
								class="col-sm-2 control-label"> <b><span
									style="color: red;" id="ct_tot_price2"></span></b>???
							</label>
						</div>
						<!-- <div class="form-group input-group ">
				<label class="col-sm-2 control-label"><b>???????????????</b></label>
				
				<div class="input-group  col-sm-2">
					<input class=" form-control input-sm p-0" type="text" name="OR_USEP" > ??? 
				</div>
				
			</div> -->
						<!-- <div class="form-group">
				<label class="col-sm-2 control-label"><b>?????????????????????</b></label>
				<label class="col-sm-2 control-label">
					<span id="USER_POINT"></span>???
				</label>
			</div> -->
						<div class="form-group">
							<label class="col-sm-2 control-label"><b>???????????????</b></label> <label
								class="col-sm-2 control-label"> <span id="od_send_cost2">0</span>???
							</label>
							<div class="col-sm-7">
								<label class="control-label text-muted font-12">????????? ??????
									???????????? ????????? ?????? ??????????????????.</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label"><b>????????????</b></label>
							<div class="col-sm-10 radio-line">
								<label><input type="radio" id="OR_HOW" name="OR_HOW"
									value="????????????"> ????????????</label>

							</div>
						</div>


					</div>
				</div>
			</section>
		</form>
		<div id="display_pay_button" class="text-center btn_confirm">
			<input type="button" value="????????????" onclick="orderf();"
				class=" btn btn-dark"> <input type="button" value="??????"
				onclick="orderc();" class=" btn btn-primary">

		</div>

	</div>
</body>



</html>

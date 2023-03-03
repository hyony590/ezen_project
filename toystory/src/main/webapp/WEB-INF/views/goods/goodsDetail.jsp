<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<link href="/resources/assets/css/goods.css" rel="stylesheet">
<meta charset="UTF-8">
<style>
#orders dl, dt, dd {
	display: inline-block;
	height: 15px;
	padding-left: 3px;
	padding-right: 12px;
	text-align: right;
}

.plusbtn, .minusbtn {
	border: none;
	background-color: #c2c2c2;
	width: 24px;
	height: 27px;
	border-radius: 10px; 
	color: #fff;
}

#deleteData {
	border: none;
  font-size: 10px;
  background-color: #808080;
  color: #fff;
}

.order-btn-form {
	text-align: right;
	margin: auto;
	width: 700px;
	margin-top: 30px;
	display: none;
}

.goods_data {
	width: 700px;
	margin: auto;
	text-align: right;
}

.goods_data dl, dt, dd {
	display: inline-block;
	height: 15px;
}

.my_img {
	filter: brightness(1);
}

.my_img:hover {
	filter: brightness(0.7);
}
</style>

<script>

const salePrice = parseInt('${detail.g_price * (100 - detail.g_sale) / 100 }');


function priceToString(price) {
    return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function calTotalPrice(goodsLists){
	
	let totalPrice = 0;
	let dp = 0;
	
	
	//총합계 구하기
	$.each(goodsLists, function(index, item){
		
		var count = $(item).find('.count').text();
		var price = parseInt(salePrice);
		totalPrice += parseInt(count) * parseInt(price);
		
	})
	
	//배송비 계산
	if(totalPrice >= 30000){
		$('#dp').text('무료배송')
	}else{
		$('#dp').text('3,000원')
	}
		
	
	$('#oPrice').text(priceToString(totalPrice));
};


function deleteOrder(index){
	
	let goods_order = document.getElementById('goods_data' + index);
	goods_order.remove();
	
	var goodsLists = $('#orders').find('div');
	
	if(goodsLists.length == 0){
		$('.order-btn-form').css('display', 'none');
		$('#totalPrice').css('display', 'none');
	}
	
	calTotalPrice(goodsLists);
	
};

function counter(type, index){
	
	
	const goods_price = '${detail.g_price}';
	
	const totalPriceElement = document.getElementById('oPrice'); //선택된 제품들의 총 합계임
	/* const dp = document.getElementById('dp'); //배송비임 */
	const resultElement = document.getElementById('count'+ index);
	const priceElement = document.getElementById('price'+ index);   
	
	// 현재 화면에 표시된 값
	let count = resultElement.innerText; //현재 수
	var price = priceElement.innerText; //물건 가
	let totalPrice = totalPriceElement.innerText; //현재 총 가격
	  
	let hhh = 0;
	
	  
	if(type === "plus"){
		count = parseInt(count) + 1;
		
		
	}else if(type === 'minus'){
		count = parseInt(count) - 1;
		
	}
	
	
	if(parseInt(count) < 1){
		count = 1;
		price = parseInt(salePrice);
	}
		price = parseInt(count) * parseInt(salePrice);
		hhh = price;
	
	 // 결과 출력
	  resultElement.innerText = count;
	  priceElement.innerText = priceToString(price);
	  
	  var goodsLists = $('#orders').find('dl');
	  calTotalPrice(goodsLists);
}


function duplication(selectOption, g_option){
	
	let check = 1;
	$.each(selectOption, function(index, item){
		if($(item).text() == g_option){
			alert('이미 선택된 옵션입니다');
			check = 0;	
			return false;
		}
	})
	
	return check;
}




$(document).ready(function(){
	
	if('${detail.g_sale}' > 0){
		$('#bornPrice').css("text-decoration", "line-through");
	}
	
	//옵션 선택시 선택된 옵션 div 추가
	
		let num = 0;
	
	$('#g_option').on('change',  function(){
		
		let inner ="";
		let g_id=$('#g_id').val();
		let g_name='${detail.g_name}';

		let g_option= $('#g_option option:selected').text();
		let selectOption = $('.g_option');
		
		if(duplication(selectOption, g_option) != 0){
			
			/* let g_count = $('#result').text(); */
			let g_price = '${detail.g_price}';
			
			inner += "<div class='goods_data' id='goods_data"+num+"'><dl class='data"+num+"'>"
				inner += "<dt class='g_name'>"+g_name+"</dt>"+"<dd class='g_option' id='"+g_option+"'>"+g_option+"</dd><dd><button type='button' class='plus plusbtn' id='plus"+num+ "' onclick='counter(\"plus\", "+num+")'>+</button>";
				inner += "<dd class='count' id='count"+num+"'> 1 </dd><button type='button' class='minus minusbtn' id='minus"+num+ "' onclick='counter(\"minus\", "+num+")'>-</button></dd>&nbsp;&nbsp;";
				inner += "<dd class='price' id='price"+num+ "'>"+priceToString(salePrice)+"</dd>  <dd><button type='button' id='deleteData' onclick='deleteOrder("+num+")'>X</button></dd> </dl></div>";
			num++;
			
			
			let form = $('#orders');
			form.append(inner);
			
		}
			//옵션선택 후 셀렉트박스 선택값 초기화
			$('#g_option option:eq(0)').prop("selected", true);
			let goodsLists = $('#orders').find('dl');
			calTotalPrice(goodsLists);
			
			$('.order-btn-form').css('display', 'block');
			$('#totalPrice').css('display', 'block');
	})
	
	
	//주문처리, 장바구니 담기 모두 이 이벤트로 동작함
	$('.basket').on('click', function(){

		//로그인 안하면 return false;
		
			
 		//if(!loginCheck()){
		//	return false;
			
		//로그인 되어있을 경우 기능 동작
		//}else{
		let loginId = '${sessionScope.loginNum}';
		if(loginId == null || loginId ==''){
			alert('로그인이 필요한 서비스입니다');
		}
			
			var check = $(this).val();
			
			basket(check);
			
			if(check == 'buy'){
				
				self.location='/order/orderStart.toy';			
			}else if(check == 'basket'){
				var after = confirm("장바구니에 상품이 담겼습니다. 이동하시겠습니까?");
				if(after == true){
					self.location='/basket/list.toy';
				}else{
					location.reload()
				}
			}
		//}		
	})//end click event
	
	//로그인 체크 기능
	function loginCheck(){
		let loginId = '${sessionScope.loginNum}';
		
		if(loginId == ''){
			let result = confirm('로그인이 필요한 서비스입니다. 로그인 하시겠습니까?');
			if(result == true){
				self.location = "/login/login.toy";
			}
			return false;
		}
		return true;
	}
	
	
	
	//구매하기, 장바구니 중 하나 클릭하면 아래 함수 동작
	//구매하기는 b_temp='Y', 장바구니는 b_temp='N'
	function basket(check){
		var goodsLists = $('#orders').find('div');
		
		$.each(goodsLists, function(index, item){
			
			var g_id = '${detail.g_id}';
			var b_option = $(this).find('.g_option').text();
			var m_num = '${sessionScope.loginNum}';
			var b_temp = '';
			
			if(check == 'buy'){
				b_temp = 'Y';
			}else if(check == 'basket'){
				b_temp = 'N';
			}
			
			//이하 변수 대입값 수정해줘야함
			var b_count = parseInt($(this).find('.count').text());
			
			
			var b_price = '${detail.g_price}'; 
			 $.ajax({
				url : "/basket/addBasket.toy",
/* 				dataType : "json",
 */				type : "post",
				contentType : "application/json; charset=utf-8",
				dateType : 'json',
				async : false,
				data : JSON.stringify({
						m_num : m_num,
						g_id : g_id,
						b_option : b_option,
						b_count : b_count,
						b_price : b_price,
						b_temp : b_temp
						/* m_num : '${sessionScope.loginNum}' */
				}),
				
				success : function(data){
					/* alert('성공 id : ' + m_num +'g_id : ' + g_id +' option : '+ b_option +' count : '+ b_count +' price : '+ b_price +' temp : '+ b_temp); */
				},
				
				error : function(request, status, error){
/* 					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					alert('에러'); */
				}
				
			}) //end ajax 
		}) //end each
		
	}//end order function
})
	function login() {
      alert('로그인이 필요합니다.');
      location.href = '/login/login.toy'; //로그인 페이지로 이동
   }
	
</script>

</head>
<body>
<fmt:parseNumber var="salePrice" integerOnly="true" value="${detail.g_price * (100 - detail.g_sale) / 100 }"/>
	<!---------------------------------------------------------------
   # 상품 상세보기 : 썸네일 & 상품정보 (div goodsA)
---------------------------------------------------------------->

	<!-- 상품 상세보기 : 썸네일 & 상품정보 -->
	<div class="container" style="margin-top: 250px;">
		<div class="goodsA">
			<div class="detailArea">
				<div class="imgArea">
					<c:forEach items="${imageList }" var="image">
				<c:if test="${image.f_main_yn eq 'Y' }">
				<img src="${pageContext.request.contextPath}/resources/assets/img/image/${image.f_svname }" width="580" height="580">
			</c:if>
		</c:forEach>
				</div>
				<div class="infoArea">
					<div class="infohead">
						<h5 id="g_name" style="font-weight: bold;">[${detail.g_brand}]&nbsp;${detail.g_name}</h5>
					</div>
					<div class="infobody">
							<!-- 세일 안 할 때  -->
							<c:if test="${detail.g_sale == 0}">
						<p class="p_custom" style="display: block;">
								<span class="cell_tit">판매가</span> <span class="cell_tit2" id="bornPrice"><fmt:formatNumber
									value="${detail.g_price}" type="currency" currencySymbol="₩" /></span>
								</p>
							</c:if>
							
							<!-- 세일 할 때  -->
									<c:if test="${detail.g_sale > 0}">
									<p class="p_custom" style="display: block;">
									<span class="cell_tit">판매가</span>
									<span class="cell_tit2" id="bornPrice"><fmt:formatNumber value="${detail.g_price}" type="currency" currencySymbol="₩" /></span>
									</p>
									 
									<p class="p_custom" style="display: block;">
									<span class="cell_tit" style="color: red;">할인가</span>
									<span class="cell_tit2" style="color: red;"><fmt:formatNumber value="${salePrice }" type="currency" currencySymbol="₩" />&nbsp;(${detail.g_sale }&nbsp;%)</span>
									</p>
									</c:if>
									<%-- <c:if test="${detail.g_sale == 0}">
										<div class="bornPrice"><fmt:formatNumber value="${detail.g_price}" type="currency" currencySymbol="₩" /></div>
									</c:if> --%>
									
									
						<p class="p_custom" style="display: block;">
							<span class="cell_tit">브랜드</span> <span class="cell_tit2">${detail.g_brand}</span>
						</p>
						<p class="p_custom" style="display: block;">
							<span class="cell_tit">배송비</span> <span class="cell_tit2" id="dp">3,000원</span>
							<span style="font-size: 12px;">(3만원 이상 구매 시 무료)</span>
						</p>
						<div class="opt">
							<p class="p_custom" style="display: block;">
								<span class="cell_tit" style="padding: 18px 0 0;">옵&nbsp;&nbsp;&nbsp;션</span>
								<span class="cell_tit2">
									<select id="g_option" class="option-select"
									name="goodsOption" aria-label="Default select example">
										<option id="default_option" selected>[필수] 옵션을 선택 해주세요.</option>
										<c:set var="optionArr"
											value="${fn:split(detail.g_option,',')}"></c:set>
										<c:forEach begin='0' end='${fn:length(optionArr) }'
											items="${optionArr}" varStatus='status'>
											<option id='option${status.index }'>${optionArr[status.index]}</option>
										</c:forEach>
								</select>
								</span>
							</p>
						</div>
						<div id='totalPrice' style="border-top: 1px solid #e9e9e9; margin-top: 30px; display: none;">
						<p class="p_custom" style="display: block;">
							<span class="cell_tit" style="font-size: 18px; padding-top: 20px;">TOTAL</span>
							<span class="cell_tit2" id="oPrice" style="font-size: 18px; padding-top: 20px;">0</span>
						</p>
						</div>
					</div>
				</div>
			</div>
			
			<form id="startBy">
				<div id="orders" style="margin: auto; margin-top: 30px; float: right;"></div>

				<div class='order-btn-form'
					style="margin: auto; width: 700px; margin-top: 40px; float: right;">
					<span class="addbtn" style="width: 700;">
						<button type="button" id="buyBtn" class="basket"
							value="buy">구매하기</button>
						<button type="button" id="basket" class="basket"
							value="basket">장바구니</button>
					</span>
				</div>
			</form>
		</div>


		<div id='goDetail' style="margin-bottom: 130px;">
			<!-- 네비게이션 버튼 : 버튼 클릭 시 해당 섹션으로 스크롤 이동 -->
			<div class="detail_tabWrap" style="margin-top: 330px;">
				<ul class="tabs">
					<li class="current" style="border-left-color: #c2c2c2;"><a href="#goDetail" class="current" >상품상세정보</a></li>
					<li class=""><a href="#goReview" class="noc">상품후기 <span
							class="count"><c:out value="${total}" /></span></a></li>
					<li class=""><a href="#goQna" class="noc">상품문의 <span
							class="count"><c:out value="${Qtotal}" /></span></a></li>
				</ul>
			</div>


			<!-- 상품 상세보기 구역 -->
			<div>
				<div class="container" style="text-align: center;">

					<c:forEach items="${imageList }" var="image">
						<c:if test="${image.f_main_yn eq 'N' }">
							<article>
								<img
									src="${pageContext.request.contextPath}/resources/assets/img/image/${image.f_svname }"
									style="width: 800px;">
							</article>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>

<!---------------------------------------------------------------
   # 상품후기 섹션 #goodsR
---------------------------------------------------------------->
<%
     pageContext.setAttribute("crcn", "\r\n");
     pageContext.setAttribute("br", "<br>"); 
%> 
		<div id="goReview">
			<!-- 네비게이션 버튼 : 버튼 클릭 시 해당 섹션으로 스크롤 이동 -->
			<div class="detail_tabWrap" style="margin-bottom: 70px;">
				<ul class="tabs">
					<li class="" style="border-left-color: #c2c2c2;"><a
						href="#goDetail" class="noc">상품상세정보</a></li>
					<li class="current"><a href="#goReview" class="current">상품후기
							<span class="count"><c:out value="${total}" /></span>
					</a></li>
					<li class=""><a href="#goQna" class="noc">상품문의 <span
							class="count"><c:out value="${Qtotal}" /></span></a></li>
				</ul>
			</div>


			<!-- 타이틀 -->
			<div class="container"
				style="text-align: center; margin-bottom: 50px;" id='goReview'>
				<h1>Review</h1>
			</div>

			<div class="container">
				<c:if test="${fn:length(Rlist) != 0}">
					<c:forEach items="${Rlist}" var="Rlist">
						<table class="table" style="margin-bottom: 80px;">
							<thead></thead>
							<tbody>
								<tr>
									<td style="text-align: left; font-size: 17px;">
										<!-- 제목 --> <a style="font-weight: bold; color: #9b55d4">
											<c:out value="${Rlist.r_title}" />
									</a>&nbsp;&nbsp; <!-- 별점 --> <span style="color: #ffc81e"> <c:if
												test="${Rlist.r_star eq 1}">
												<c:out value="★☆☆☆☆" />
											</c:if> <c:if test="${Rlist.r_star eq 2}">
												<c:out value="★★☆☆☆" />
											</c:if> <c:if test="${Rlist.r_star eq 3}">
												<c:out value="★★★☆☆" />
											</c:if> <c:if test="${Rlist.r_star eq 4}">
												<c:out value="★★★★☆" />
											</c:if> <c:if test="${Rlist.r_star eq 5}">
												<c:out value="★★★★★" />
											</c:if>
									</span>
									</td>

									<!-- 작성자 -->
									<td style="text-align: right;"><c:out
											value="${Rlist.m_name}" />&nbsp;&nbsp;&nbsp; <!-- 작성일 --> <fmt:formatDate
											pattern="yyyy-MM-dd" value="${Rlist.r_regdate}" /></td>
								</tr>

								<!-- 내용 보임 -->
								<tr>
									<td>
										<div style="text-align: left; margin-right: 50px; word-break:break-all;">
											<p style="font-size: small; color: #808080">
												<!-- 상품명, [옵션], [수량] -->
												<c:out value="${Rlist.g_name}" />
												옵션 [
												<c:out value="${Rlist.o_option}" />
												] / 수량 [
												<c:out value="${Rlist.o_count}" />
												]
											</p>
											<div style ="word-break: break-all;">
												${fn:replace(Rlist.r_content,crcn,br)}
											</div>
										</div>
										<p></p> <!-- 공백 --> <!-- 작성자가 첨부한 사진 -->
										<div style="text-align: left;">
											<p>
												<c:set var="optionArr"
													value="${fn:split(Rlist.f_svname,',')}"></c:set>
												<c:forEach begin='0' end='${fn:length(optionArr) }'
													items="${optionArr}" varStatus='status'>
													<c:if test="${Rlist.f_svname != null}">
														<a
															href="${pageContext.request.contextPath}/resources/assets/img/image/${optionArr[status.index]}"
															class="glightbox"> <img class="my_img"
															src="${pageContext.request.contextPath}/resources/assets/img/image/${optionArr[status.index]}"
															style="width: 250px; height: 250px;" />&nbsp;&nbsp;
														</a>
													</c:if>
													<c:if test="${Rlist.f_svname == null}">
													</c:if>
												</c:forEach>
											</p>
										</div>
									</td>
									<td></td>
								</tr>
								<!-- 관리자 답변 내용-->
								<tr style="border: 1px;">
									<td><c:if test="${Rlist.r_comment != null }">
											<div style="text-align: left;">
												<p style="font-weight: bold; font-size: 14.5px;">토이스토리</p>
												<p style="font-size: 14.5px;">
													<c:out value="${Rlist.r_comment}" />
												</p>
											</div>
										</c:if> <c:if test="${Rlist.r_comment == null }">
											<div style="text-align: left;">
												<p style="font-size: 14.5px; color: #c2c2c2">등록된 관리자의 답변이
													없습니다.</p>
											</div>
										</c:if></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</c:forEach>
					<nav style="margin-top: 50px;" aria-label="pagination">
						<ul class="pagination justify-content-center">

							<c:if test="${RpageMaker.prev}">
								<li class="paginate_button previous"><a
									href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${RpageMaker.startPage - 1 }&QpageNum=${QpageNum}#goReview">Previous&nbsp;&nbsp;&nbsp;</a></li>
							</c:if>

							<c:forEach var="num" begin="${RpageMaker.startPage}"
								end="${RpageMaker.endPage}">
								<li class="paginate_button  ${pageNum == num ? "active":""}">
									<a
									href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${num}&QpageNum=${QpageNum}#goReview"
									style="text-align: center;">${num}&nbsp;&nbsp;&nbsp;
									</a>
								</li>
							</c:forEach>

							<c:if test="${RpageMaker.next}">
								<li class="paginate_button next"><a
									href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${RpageMaker.endPage + 1}&QpageNum=${QpageNum}#goReview">&nbsp;&nbsp;&nbsp;Next</a></li>
							</c:if>
						</ul>
					</nav>

				</c:if>
				<c:if test="${fn:length(Rlist) == 0}">
					<div class="container" style="margin-bottom: 180px;">
						<table class="table" style="border-bottom-color: #ffffff">
							<tr>
							<td>등록된 게시글이 없습니다.</td>
							</tr>
						</table>
					</div>
				</c:if>
			</div>
			<!-- </section> -->
		</div>




		<!---------------------------------------------------------------
   # 상품문의 섹션 #goodsQ
---------------------------------------------------------------->
		<!-- <section id="goodsQ"> -->
		<div id="goQna" class="goodsQ">
			<div class="detail_tabWrap" style="margin-bottom: 70px;">
				<ul class="tabs">
					<li class="" style="border-left-color: #c2c2c2;"><a
						href="#goDetail" class="noc">상품상세정보</a></li>
					<li class=""><a href="#goReview" class="noc">상품후기 <span
							class="count"><c:out value="${total}" /></span></a></li>
					<li class="current"><a href="#goQna" class="current">상품문의
							<span class="count"><c:out value="${Qtotal}" /></span>
					</a></li>
				</ul>
			</div>

			<!-- 타이틀 -->
			<div class="container" style="text-align: center;" id='goQna'>
				<h1>QNA</h1>
				<div class="container"
					style="text-align: right; margin-bottom: 30px;">
					<%
					if (session.getAttribute("loginNum") != null) {
					%>
					<button class="btn"
						onclick="location.href='/goods/qregister.toy?g_id=<c:out value="${detail.g_id}"/>'">
						문의 작성하기</button>
					<%
					} else {
					%>
					<button class="btn" onclick="return login()">문의 작성하기</button>
					<%
					}
					%>
				</div>
			</div>

			<div class="container">
				<c:if test="${fn:length(Qlist) != 0}">
					<c:forEach items="${Qlist}" var="Qlist">
						<div class="container">
							<table class="table" style="width: 100%; text-align: center;">
								<thead></thead>
								<tbody>
									<tr>
										<!-- 문의 제목 -->
										<td class="text-left" width="50%" style="padding-left: 10px;">
											<div class="panel-faq-container">
												<p class="panel-faq-title"
													style="text-align: left; color: #9b55d4">
													<c:out value="${Qlist.q_title}" />
													<c:if test="${Qlist.q_comment != null }">[1]</c:if>
												</p>
												<div class="panel-faq-answer" style="margin-bottom: 10px; margin-right: 50px; word-break:break-all;">
													<div>
														<p style="text-align: left; word-break: break-all;">
															<c:out value="${Qlist.q_content}" />
														</p>
														<br />
													</div>
													<!-- 관리자 답변 부분 -->
													<div style="margin-top: 10px; margin-bottom: 15px;">
														<c:if test="${Qlist.q_comment != null }">
															<p
																style="text-align: left; font-size: 14.5px; font-weight: bold;">토이스토리</p>
															<p
																style="text-align: left; font-size: 14.5px; margin-bottom: 15px;">
																<c:out value="${Qlist.q_comment}" />
															</p>
														</c:if>
														<c:if test="${Qlist.q_comment == null }">
															<p
																style="text-align: left; font-size: 14.5px; color: #c2c2c2">등록된
																관리자의 답변이 없습니다.</p>
														</c:if>
													</div>
												</div>
											</div>
										</td>
										<td style="text-align: right;" width="25%"><c:out
												value="${Qlist.m_name}" /></td>
										<!-- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
										<td style="text-align: right;" width="15%"><fmt:formatDate
												pattern="yyyy-MM-dd" value="${Qlist.q_regdate}" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:forEach>

					<nav style="margin-top: 50px; text-align: center;"
						aria-label="pagination">
						<ul class="pagination justify-content-center">
							<c:if test="${QpageMaker.prev}">
								<li class="paginate_button previous"><a
									href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${pageNum}&QpageNum=${QpageMaker.startPage - 1 }#goQna">Previous&nbsp;&nbsp;&nbsp;</a></li>
							</c:if>

							<c:forEach var="num" begin="${QpageMaker.startPage}"
								end="${QpageMaker.endPage}">
								<li class="paginate_button  ${QpageNum == num ? "active" : ""}">
									<a
									href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${pageNum}&QpageNum=${num}#goQna"
									style="text-align: center;">${num}&nbsp;&nbsp;&nbsp;</a>
								</li>
							</c:forEach>

							<c:if test="${QpageMaker.next}">
								<li class="paginate_button next"><a
									href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${pageNum}&QpageNum=${QpageMaker.endPage + 1}#goQna">&nbsp;&nbsp;&nbsp;Next</a></li>
							</c:if>

						</ul>
					</nav>
				</c:if>
				<c:if test="${fn:length(Qlist) == 0}">
					<div class="container" style="margin-bottom: 200px;">
						<table class="table" style="border-bottom-color: #ffffff">
							<tr>
							<td>등록된 게시글이 없습니다.</td>
							</tr>
						</table>
					</div>
				</c:if>
			</div>
			<!-- </section> -->
		</div>
	</div>
	<!-- 스크립트 태그 이 위치에 있어야 하는거 맞아요 -->
	<script type="text/javascript">
/* 상품 문의 제목 누르면 내용 접었다 펴기 */
window.onload = () => {
     // panel-faq-container
     const panelFaqContainer = document.querySelectorAll(".panel-faq-container"); // NodeList 객체
     
     // panel-faq-answer
     let panelFaqAnswer = document.querySelectorAll(".panel-faq-answer");

     // 반복문 순회하면서 해당 FAQ제목 클릭시 콜백 처리
     for( let i=0; i < panelFaqContainer.length; i++ ) {
       panelFaqContainer[i].addEventListener('click', function() { // 클릭시 처리할 일
         // FAQ 제목 클릭시 -> 본문이 보이게끔 -> active 클래스 추가
         panelFaqAnswer[i].classList.toggle('active');
       });
     };
   }
</script>

	<!-- 최상단으로 가기 버튼 -->
	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>
</body>

</html>
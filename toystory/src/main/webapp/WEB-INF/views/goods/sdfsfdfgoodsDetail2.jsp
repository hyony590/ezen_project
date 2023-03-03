<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<meta charset="UTF-8">
<link href="/resources/assets/css/goods.css" rel="stylesheet">
<style>


/* 
.minus:hover{
    background-color: #717fe0 !important;
}
.plus:hover{
    background-color: #717fe0 !important;
} */

.plusbtn, .minusbtn, #deleteData {
	border: none;
}

#deleteData {
  font-size: 10px;
  background-color: #808080;
  color: #fff;
}

#orders dl, dt, dd {
    display: inline-block;
    height: 15px;
    padding-left: 3px;
    padding-right: 3px;
    text-align:right;
}

.order-btn-form{
	text-align:right; 
	margin:auto; 
	width:700px; 
	margin-top:30px;
	display: none;
}
.my-hr3 {
	border: 0;
	height: 3px;
	background: black;
}
	
.goods_data{
     width:700px;
     margin:auto;
     text-align:right;
 }
	
.goods_data dl, dt, dd{
	display:inline-block;
	height:15px;

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
		$('.bornPrice').css("text-decoration", "line-through");
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
				inner += "<dt class='g_name'>"+g_name+"</dt>"+"<dd class='g_option' id='"+g_option+"'>"+g_option+"</dd><dd><button type='button' class='plus plusbtn bg-dark' id='plus"+num+ "' onclick='counter(\"plus\", "+num+")'>+</button>";
				inner += "<dd class='count' id='count"+num+"'> 1 </dd><button type='button' class='minus minusbtn bg-dark' id='minus"+num+ "' onclick='counter(\"minus\", "+num+")'>-</button></dd>";
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
   # 상품 상세보기 : 썸네일 & 상품정보 (섹션 goodsA)
---------------------------------------------------------------->

<%-- <c:set var="salePrice" value="${detail.g_price * (100 - detail.g_sale) / 100 }"/> --%>



<!-- 할인된 가격 변수 설정 -->


<!-- 상품 상세보기 : 썸네일 & 상품정보 -->
<table border="1"


style="margin-bottom: 30px; margin-left: auto; margin-right: auto; width: 200px;">
	<tr>
		<!-- 상품 썸네일 이미지 크게 보이기 -->
		<c:forEach items="${imageList }" var="image">
			<c:if test="${image.f_main_yn eq 'Y' }">
				<img src="${pageContext.request.contextPath}/resources/assets/img/image/${image.f_svname }" width="580" height="580">
			</c:if>
		</c:forEach>
		<td>
			<table border="1" style="height: 300px; width: 400px;">
				<tr align="center">
				
					<th colspan="2" id="g_name">${detail.g_name}</th>
				</tr>
				<tr align="center">
					<td>상품 가격</td>
					<td>
						<c:if test="${detail.g_sale > 0}">
							<div class="bornPrice"><fmt:formatNumber value="${detail.g_price}" type="currency" currencySymbol="₩" /></div>
							<div >할인 가격 : <fmt:formatNumber value="${salePrice }" type="currency" currencySymbol="₩" />(${detail.g_sale }&nbsp;%)</div>
						</c:if>
						
						<c:if test="${detail.g_sale == 0}">
							<div class="bornPrice"><fmt:formatNumber value="${detail.g_price}" type="currency" currencySymbol="₩" /></div>
						</c:if>
						
						
					</td>
				</tr>
				<tr align="center">
					<td>브랜드명</td>
					<td id="g_barnd">${detail.g_brand}</td>
				</tr>
				<tr align="center">
					<td>상품 옵션</td>
					<td>
					<select id="g_option" class="option-select" name="goodsOption" aria-label="Default select example">
                     <option id="default_option" selected>옵션 선택</option>
                     <c:set var="optionArr" value="${fn:split(detail.g_option,',')}"></c:set>
                     	<c:forEach begin='0' end='${fn:length(optionArr) }' items="${optionArr}" varStatus='status'>
                        <option id='option${status.index }'>${optionArr[status.index]}</option>
                     	</c:forEach>
<%--                      	<c:forEach var="option" items="${optionArr}" varStatus="status">
                        <option value='${option }${status.index }'>${option}</option>
                     	</c:forEach> --%>
               </select> 
					</td>
				</tr>
				
				<tr align="center">
					<td>배송비</td>
					<td>3만원 <b>미만</b> 구매시 배송비 <b>3,000</b>원 추가
					</td>
				</tr>
				<tr align="center">
					<td><h5><br />총 상품 금액</h5>
					</td>
					<td><h5><br />
						<div id='totalPrice' style="text-align: center; width: 100px;">
							<%-- <fmt:formatNumber value="${detail.g_price}" type="currency" currencySymbol="₩"/> --%>
							<!-- <input type="text" id="oPrice" value=""/> -->
							<span id="oPrice">0</span><span>원</span>
							
						</div>
					</h5>
					</td>
				</tr>
				<tr align="center">
					<td><h5><br/>배송비</h5>
					</td>
					<td><h5><br />
						<div style="text-align: center; width: 100px;">
							<%-- <fmt:formatNumber value="${detail.g_price}" type="currency" currencySymbol="₩"/> --%>
							<!-- <input type="text" id="oPrice" value=""/> -->
							<div id="dp">3,000원</div>
							
						</div>
					</h5>
					</td>
				</tr>
				<tr align="center">
					<td rowspan="3" colspan="2">
						<!-- <button type="button" id="add" class="btn btn-primary">추가하기</button> -->
						
					</td>
				</tr>
			</table>
			
			
		</td>
	</tr>
</table>


	<form id="startBy">
		<div id="orders" style="margin:auto; ">
		
		</div>
		
		
		
		
		<div class='order-btn-form' style="text-align:right; margin:auto; width:700px; margin-top:30px;">
			<span class="addbtn" style= "width:700;">
				<button type="button" id="buyBtn" class="btn btn-primary basket" value="buy">구매하기</button>
				<button type="button" id="basket" class="btn btn-primary basket" value="basket">장바구니</button>
			</span>
		</div>
		
	</form>



	<!-- 상품 상세보기 / 상품 후기 / 상품문의 버튼 클릭 시 해당 섹션으로 스크롤 이동 -->
<div class="container" style="text-align:center;">
      <hr class="my-hr3">
      <a href="#goDetail"><button type="button" class="btn btn-primary">상품상세정보</button></a>
      <a href="#goReview"><button type="button" class="btn btn-primary">상품후기</button></a>
      <a href="#goQna"><button type="button" class="btn btn-primary">상품문의</button></a>
</div>


<!-- 상품 상세보기 섹션 -->
<section>
	<div id='goDetail'>
		<div class="container" style="text-align:center;">
            <c:forEach items="${imageList }" var="image">
				<c:if test="${image.f_main_yn eq 'N' }">
				 	<article><img src="${pageContext.request.contextPath}/resources/assets/img/image/${image.f_svname }" style="width:800px;" ></article>
				</c:if>
			</c:forEach>
      </div>
   </div>
</section>





	<!-- 상품후기 섹션 -->
	<section id="goodsR">

		<!-- 상품 상세보기 / 상품 후기 / 상품문의 버튼 클릭 시 해당 섹션으로 스크롤 이동 -->
		<div style="text-align: center;">
			<a href="#goDetail"><button type="button" class="btn">상품상세정보</button></a>
			<a href="#goReview"><button type="button" class="btn">상품후기</button></a>
			<a href="#goQna"><button type="button" class="btn">상품문의</button></a>
		</div>

		<!-- 타이틀 -->
		<div class="container"
			style="text-align: center; margin-bottom: 50px;" id='goReview'>
			<hr class="my-hr3">
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
									<!-- 제목 --> <a style="font-weight: bold; color: #9b55d4"> <c:out
											value="${Rlist.r_title}" />
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
									<div style="text-align: left;">
										<p style="font-size: small; color: #808080">
											<!-- 상품명, [옵션], [수량] -->
											<c:out value="${Rlist.g_name}" />
											옵션 [
											<c:out value="${Rlist.o_option}" />
											] / 수량 [
											<c:out value="${Rlist.o_count}" />
											]
										</p>
										<p>
											<c:out value="${Rlist.r_content}" />
										</p>
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
														class="glightbox"> <img
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
											<p style="font-size: 14.5px; color: #c2c2c2">등록된 답변이
												없습니다.</p>
										</div>
									</c:if></td>
								<td></td>
							</tr>
							</div>
						</tbody>
					</table>
				</c:forEach>
				 <nav style="margin-top: 50px; " aria-label="pagination">
					<ul class="pagination justify-content-center">

						<c:if test="${RpageMaker.prev}">
							<li class="paginate_button previous"><a
								href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${RpageMaker.startPage - 1 }&QpageNum=${QpageNum}#goReview">Previous&nbsp;&nbsp;&nbsp;</a></li>
						</c:if>

						<c:forEach var="num" begin="${RpageMaker.startPage}"
							end="${RpageMaker.endPage}">
							<li class="paginate_button  ${pageNum == num ? "active":""}">
								<a href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${num}&QpageNum=${QpageNum}#goReview" style = "text-align:center;">${num}&nbsp;&nbsp;&nbsp;</a>
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
				<div class="container">
					<table class="table" style="border-bottom-color: #ffffff">
						<td>등록된 게시글이 없습니다.</td>
					</table>
				</div>
			</c:if>
		</div>
		</div>
	</section>



	<!---------------------------------------------------------------
   # 상품문의 섹션 #goodsQ
---------------------------------------------------------------->
	<section id="goodsQ">

		<!-- 상품 상세보기 / 상품 후기 / 상품문의 버튼 클릭 시 해당 섹션으로 스크롤 이동 -->
		<div style="text-align: center;">
			<a href="#goDetail"><button type="button" class="btn">상품상세정보</button></a>
			<a href="#goReview"><button type="button" class="btn">상품후기</button></a>
			<a href="#goQna"><button type="button" class="btn">상품문의</button></a>
		</div>

		<!-- 타이틀 -->
		<div class="container" style="text-align: center;" id='goQna'>
			<hr class="my-hr3">
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
											</p>
											<div class="panel-faq-answer">
												<p style="text-align: left;">
													<c:out value="${Qlist.q_content}" />
												</p>
												<p style="text-align: left;">
													<c:out value="${Qlist.q_comment}" />
												</p>
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
				
				<nav style="margin-top: 50px; text-align :center;" aria-label="pagination">
					<ul class="pagination justify-content-center">
						<c:if test="${QpageMaker.prev}">
							<li class="paginate_button previous"><a
								href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${pageNum}&QpageNum=${QpageMaker.startPage - 1 }#goQna" >Previous&nbsp;&nbsp;&nbsp;</a></li>
						</c:if>

						<c:forEach var="num" begin="${QpageMaker.startPage}"
							end="${QpageMaker.endPage}">
							<li class="paginate_button  ${QpageNum == num ? "active" : ""}">
								<a href="/goods/detail.toy?g_id=${detail.g_id}&pageNum=${pageNum}&QpageNum=${num}#goQna" style = "text-align:center;">${num}&nbsp;&nbsp;&nbsp;</a>
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
				<div class="container">
					<table class="table" style="border-bottom-color: #ffffff">
						<td>등록된 게시글이 없습니다.</td>
					</table>
				</div>
			</c:if>
		</div>
	</section>

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
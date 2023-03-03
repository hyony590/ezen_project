<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<html>

<link href="/resources/assets/css/order.css" rel="stylesheet">

<script>


	

//수량조절
$(document).ready(function(){
	

let quantity = $(".quantity_input").val();
 
 var btn = $('#btn_plus');
 var input = $('.quantity_input').val();
 	$(btn, input).each(function(index, item){
 		$(item.btn).on('click', function(){
 				item.input.val(++quantity);
 		})
 		
 	})
 
	  
	
})

</script>
<body>


<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>


<h3 align="center">ORDER</h3>

		<br/>
	    <br/>
	    <br/>
	    
	   
						
	<div class="container" align="center">
	
		<table> 
		
				<colgroup align="center">
					
					<col width="6%">
					<col width="6%">
					<col width="8%">
					<col width="8%">
					<col width="8%">
					<col width="8%">
					<col width="8%">
				    <col width="8%">
				    <col width="8%">
				</colgroup>
				
					<tr align="center">
						<th scope="col"><input id="input1" type="checkbox" name="item" value="selectall" onclick="selectAll(this)"/></th>
						<th scope="col">상품이미지</th>
						<th scope="col">상품명</th>
						<th scope="col">가격</th>
						<th scope="col">옵션</th>
						<th scope="col">수량</th>
						<th scope="col">배송비</th>
						<th scope="col">합계</th>
						<th scope="col">선택</th>
					</tr>
				    
				 
								
				<c:if test="${fn:length(basketList) == 0 }">
				 없음
				</c:if>
								
				<c:if test="${fn:length(basketList) != 0 }"	>
			
				<c:forEach items="${basketList}" var="basket">				
					<tr align="center">
					 
						<td align="center"><input id="input2" type="checkbox" name="item" value="선택"><td/><img src="/resources/assets/img/menu/spiderman.png" width="90" height="90"></td>
						
						<td align="center">${basket.g_name}</td>
						<td align="center">${basket.b_price}</td>
						
						<td>${basket.b_option}<br/><select onchange="window.open(value,'_blank');">
			              <option value="">옵션변경</option>
			              <option value="">S</option>
			              <option value="">M</option>
			              <option value="">L</option>
			              <option value="">XL</option>
			           
			        </select>
			        
			        
			        <!-- 수량변경 해보기 -->
			      <td>
			      <div class="button">
			      	<div class="button_quantity"></div>
			      		<input type="text" class="quantity_input" value="${basket.b_count }">
			      		<span>
			      			<button id="btn-plus" class="plus_btn">+</button>
			      			<button id="btn-minus" class="minus_btn">-</button>
			      		</span>
			      </div>
			      </td>
			      
			      <%--   <div>
			        <td>
					<table class="quantity_table">
						<tr>
							<td><input type="button" class="minus_btn" value="-"  style="width:30px;"></td>
							<td><div id='result' style="text-align: center; width: 30px">${basket.b_count }</div></td>
							<td><input type="button" class="plus_btn" value="+"  style="width:30px;"></td>
						    <!-- <tr><td align="center" rowspan="3" colspan="5">
						<button type="button" class="btn-outline-inbtn">변경저장</button> -->
					  </tr>
					</table>
					</td>
					</div>  --%>
					    
						<td align="center">3000원</td>
						<td align="center"><strong id="id2">${basket.totalPrice}</strong></td>						
<%-- 						<c:set var= "sum" value="${sum + (basketList.basket_goods_price * basketList.basket_goods_amount)}"/>
 --%>					
                      <td colspan="100" align="center" height="150">
                      
							
							<a class="quantity_modify_btn btn btn-outline-secondary btn-sm" data-b_num="${basket.b_num}">변경</a>
							<!-- 수량 조정 form -->
							<form action="/basket/modify" method="post" class="quantity_update_form">
								<input type="hidden" name="b_num" class="update_b_num">
								<input type="hidden" name="b_count" class="update_b_count">
								<input type="hidden" name="m_num" value="${m_num}">
							</form>
							
							<br><button type="button" class="btn btn-outline-secondary btn-sm" id="select_order">바로주문</button>
							<br><button type="button" class="btn btn-outline-secondary btn-sm" id="select_delete">상품삭제</button>
						</td>
 
                    </tr>
				</c:forEach>
				</c:if>
					
				    
					<tr>
						<td align="center"  colspan="10" height="40" style="background:#f6f6f6;border-top: 1px solid #e5e5e5; text-align:right;color:black;">
							
				        <%-- 상품구매금액 <strong><fmt:formatNumber value="${basket.g_price * basket.o_count}" type="number"/> </strong> + 배송비 <strong>0</strong> = <strong style="color: #f8941d;font-size: 14px;">
							합계 : <fmt:formatNumber value="${basket.gprice * basket.o_count}" type="number"/>원 </strong>&nbsp;&nbsp;&nbsp; --%>
					    총 주문금액(총 상품금액 + 총 배송비) = 300,000원 
						</td>
					</tr>
					<tr>
					<td colspan="100" align="right" height="50">
							<button type="button" class="btn btn-outline-secondary btn-sm" id="modify_order">장바구니 비우기</button>
							</td>
					<tr>
						<td colspan="100" align="center" height="100">
							<button type="button" class="btn btn-outline-submit" id="all_order">전체상품주문</button>
							<button type="button" class="btn btn-outline-submit" id="select_order">선택상품주문</button>
							
						</td>
					</tr>
				
				
			</table>
				
			
		
		</div>
 


</body>
</html>
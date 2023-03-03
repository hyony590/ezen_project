<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<script>

	function reviewWrite(data, o_num){
		
		var check = confirm("구매확정 되었습니다. 리뷰를 작성하시겠습니까?");
		if(check == true){
			self.location = "/order/rregister.toy?o_num="+o_num;
		}else{
			location.reload()
		}
	}

	function orderConfirm(o_num){
		
		$.ajax({
			type : 'post',
			url : "/order/orderConfirm.toy",
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			data : JSON.stringify({o_num : o_num}),
			success : function(data){
				/* alert('리턴값 : ' + data); */
				if(data == '1'){
					reviewWrite(data, o_num);
				}
			},
			error : function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
		
	}
	
$(document).ready(function(){
		
		var actionForm = $("#actionForm");

		$(".paginate_button a").on("click", function(e){
			
			
			e.preventDefault();
			
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
			
		});
		
		$('#orderSearch').on('click', function(e){
			e.preventDefault();
			
			let type = $('#type option:selected').val();
			let keyword = $('#keyword').val();
			
			$('input[name="type"]').val(type);
			$('input[name="keyword"]').val(keyword);
			$('input[name="pageNum"]').val(1);
			

			actionForm.submit();
		})
		
		$('#resetSearch').on('click', function(){
			$('input[name="type"]').val(null);
			$('input[name="keyword"]').val(null);
			$('input[name="pageNum"]').val(1);
			actionForm.submit();
		})
		
	
})

</script>

<meta charset="UTF-8">
<title>주문리스트</title>

<link href="/resources/assets/css/order.css" rel="stylesheet">


</head>
<body>

	<section style="margin:auto; padding-top:230px; margin-bottom: 80px;">


		<div class="container" style="margin-top: 20px;">
			<div style="width: 1200px; margin: auto; padding: 5px;" class="admin-search-form">
				<form method="post" action="/myPage/orderList.toy" id='actionForm'>
				
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<input type="hidden" name="type" value="${pageMaker.cri.type }">
					<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
				<div>
		<h3 align="center" style="font-weight: bold; margin-bottom: 58px;">MY ORDER</h3>
	</div>
						<span style="float:right;">
							<span><select class="form-header" id="type" style="height: 30px; border-radius:0.375rem; font-size: 14px;">
										<option value="g_name" selected>상품명</option>
										<option value="o_num">주문번호</option>
								</select>
							</span> 
							<span><input type="text" class="form-control" name="#" id="keyword" style="width: 200px; height: 30px; display: inline-block;"></span> 
							<span>
								<button id="orderSearch" type="submit" class="jbb" style="height: 32px; width: 80px;">검색</button>
								<button type="button" id = resetSearch class="jbb" style="height: 32px; width: 80px;">초기화</button>
								</span>
						</span>
				</form>
			</div>
		</div>

<br>
		<div style="margin-top: 20px;">
			<table class="orderList">
				<thead>
					<tr style="border-bottom: 1px solid #000; ">
						<th width="10%">주문번호</th>
						<th width="*" colspan="2" style="text-align: center; padding-bottom: 5px;">상품정보</th>
						<th width="15%" style="text-align: center; padding-bottom: 5px;">주문일</th>
						<th width="15%" style="text-align: center; padding-bottom: 5px;">송장번호</th>
						<th width="10%" style="text-align: center; padding-bottom: 5px;">구매금액</th>
						<th width="15%" style="text-align: center; padding-bottom: 5px;">주문처리상태</th>
					</tr>

				</thead>



				<tbody>
				
					<c:if test="${empty orderList }">
					
						<tr style="text-align: center;">
							<td colspan='7' height="100" style="vertical-align: bottom;"><div>주문내역이 없습니다.</div></td>
						</tr>
						
					</c:if>
				
					
				
					<c:if test="${!empty orderList }">	
					<c:forEach items="${orderList}" var="order">
						<tr style="border-bottom: 1px solid #c2c2c2; ">
							<td style="padding: 20px;"><c:out value="${order.o_num }"/></td>
							<td colspan="2" style="padding: 20px;"><span class="orderImg"> <img
							src="${pageContext.request.contextPath}/resources/assets/img/image/${order.f_svname }" class="radius_img"
							style='width: 100px; height: 100px'>
							</span>
							<span class="orderInfo" style="padding-bottom: 30px; padding-left: 10px;">
									<div style="font-weight: bold;"><c:out value="${order.g_name }"/></div> 
									옵션  [ <c:out value="${order.o_option }"/> ]
									수량 [ <c:out value="${order.o_count }"/> 개 ]
							</span></td>
							

							<td style="text-align: center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${order.o_date}" /></td>
							<td style="text-align: center;"><c:out value="${order.o_invoice }"/></td>
							<td style="text-align: center;"><c:out value="${order.o_tprice }"/>원</td>
							<td style="text-align: center;">
							
								<c:choose>
									<c:when test="${order.o_delivery == 1 }">
										<div>준비중</div>
									</c:when>
									
									<c:when test="${order.o_delivery == 2 }">
										<div>배송중</div>
									</c:when>
									
									<c:when test="${order.o_delivery == 3 }">
										<div>배송완료</div>
										<button class="rrbt" type="button" onclick="orderConfirm(${order.o_num})">구매확정</button>
									</c:when>
									
									<c:when test="${order.o_delivery == 4 }">
										<div style="margin-bottom: 5px;">구매확정</div>
										<button class="rrbt" type="button" id="review" onclick="location.href='/order/rregister.toy?o_num=${order.o_num}'">리뷰작성</button> 
									</c:when>
									
									<c:when test="${order.o_delivery == 5 }">
										<div>리뷰작성완료</div>
									</c:when>
									
									<c:otherwise>
										<div></div>
									</c:otherwise>
								</c:choose>
							
							</td>
						</tr>

					</c:forEach>
					</c:if>

				</tbody>


			</table>
		</div>

<%-- <form id='actionForm' action="/myPage/orderList.toy" method="post">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form> --%>

<!-- 페이징 작업할 부분 -->
<div style="margin:auto; text-align:center; width:700px">
	<div class="inner">
			<ul class="pagination" style="text-align: center; justify-content: center;">
			
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a class="page-link" href="${pageMaker.startPage - 1 }"
						tabindex="-1" aria-disabled="true">Previous</a></li>
				</c:if>		
						
					<c:forEach var="num" begin="${pageMaker.startPage }" end ="${pageMaker.endPage }">
						<li class="page-item paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }">
							<a class="page-link" href="${num }">${num }</a>
						</li>
					</c:forEach>
					
				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a class="page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>	
			</ul>
	</div>
</div>

	</section>




</body>
</html>
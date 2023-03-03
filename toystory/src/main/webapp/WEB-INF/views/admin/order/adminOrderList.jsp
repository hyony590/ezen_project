<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>

<link href="/resources/assets/css/order.css" rel="stylesheet">
<style>
	
	tbody tr:hover{
		background-color:#dddddd;
	}

</style>
<script>

$(document).ready(function(){
	
	var actionForm = $("#actionForm");


	$(".paginate_button a").on("click", function(e){
		
		
		e.preventDefault();
		
		console.log('click');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
		
	});
	
	$('#resetSearch').on('click', function(){
		self.location="/admin/orderlist.toy";
	})

})

function getOrderDetail(o_num){
		self.location="/admin/orderdetail.toy?o_num="+o_num;
	}

</script>
</head>

<body>



	<section>

		<div class="container admin-order-search" style="margin-top: 150px;">
			<div style="width: 1000px; margin: auto;">
				<h4 style="text-align: center; font-weight: bold;">주문관리</h4>
			</div>
		</div>


		<div class="container" style="margin-top: 20px;">
			<div style="width: 1200px; margin: auto; padding: 5px;" class="admin-search-form">
				<form method="get" action="/admin/orderlist.toy">
						<span style="float:left;">주문상세보기</span>

						<span style="float:right;">
							<span><select class="form-header"
									name="type" style="height: 35px;">
										<option value="m_email">email</option>
										<option value="m_name">이름</option>
										<option value="o_num">주문번호</option>
										<option value="m_mobile">휴대폰번호</option>
								</select></span> 
							<span><input type="text" class="form-control" name="keyword" style="width: 200px; display: inline-block;"></span> 
							<span>
								<button type="submit" class="btn btn-purple" style="width: 100px; vertical-align:baseline;">검색</button>
								<button type="button" id = resetSearch class="btn btn-purple" style="width: 100px; vertical-align:baseline;">전체보기</button>
							</span>
						</span>
						
				</form>
			</div>
		</div>

		<table class="admin-order-list">
			<thead>

				<tr>
					<th width="7%">주문번호</th>
					<th width="8%">주문일자</th>
					<th width="12%">이메일</th>
					<th width="25%">주소</th>
					<th width="*">상품명</th>
					<th width="8%">상품가격</th>
					<th width="7%">주문수량</th>
					<th width="10%">주문금액</th>
					<th width="8%">배송상태</th>
				</tr>
			</thead>
			

			<tbody>
				<c:if test="${empty orderList }">
					<tr>
						<td colspan="9"><div style="text-align: center; margin: 10px">조회된
								주문이력이 없습니다.</div></td>
					<tr>
				</c:if>

				

				<c:if test="${!empty orderList }">
					<c:forEach items="${orderList }" var="order" varStatus="status">

						<tr id="orderList${status.index }" class="list" onclick="getOrderDetail('${order.o_num}')">
						
							<td id="oderNum${status.index }" class="o_num"><c:out value="${order.o_num }" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd" value="${order.o_date}" /></td>
							<td><c:out value="${order.m_email }" /></td>
							<td><c:out value="${order.fullAddress }" /></td>
							<td><c:out value="${order.g_name }" /></td>
							<td><c:out value="${order.o_price }" /></td>
							<td><c:out value="${order.o_count }" /></td>
							<td><c:out value="${order.o_tprice }" /></td>
							<td><c:choose>
									<c:when test="${order.o_delivery == 1 }">
										<div>준비중</div>
									</c:when>

									<c:when test="${order.o_delivery == 2 }">
										<div>배송중</div>
									</c:when>

									<c:when test="${order.o_delivery == 3 }">
										<div>배송완료</div>
									</c:when>

									<c:when test="${order.o_delivery == 4 }">
										<div>구매확정</div>
									</c:when>

									<c:otherwise>
										<div></div>
									</c:otherwise>
								</c:choose></td>
						</tr>
						
					</c:forEach>
				</c:if>
			</tbody>


		</table>
	</section>
	
<form id='actionForm' action="/admin/orderlist.toy" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>
	
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


</body>
</html>
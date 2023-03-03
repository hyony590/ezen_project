<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<link href="/resources/assets/css/order.css" rel="stylesheet">



<meta charset="UTF-8">
<title>주문 상세보기</title>
</head>
<body>

	<section style="margin-top:100px;">
		<div class="container">
			<div style="width: 1000px; margin: auto;">
				<h3 style="text-align:center; margin:50px; font-weight: bold;">주문 관리 상세보기</h3>
			</div>
		</div>

		<div class="container">	
			<form action="/admin/ordermodify.toy" method="post">
				<TABLE class="admin-order-Detail">
					<tr>
						<td style="width: 15%;">송장번호</td>
						<td style="width: 50%;"><input type="text" class="form-control" name="o_invoice"	value="<c:out value="${orderModel.o_invoice }"/>" readonly></td>
						<td style="width: 15%">주문번호</td>
						<td style="width: auto"><input type="text" class="form-control" name="o_num" value="<c:out value="${orderModel.o_num }"/>" readonly></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" class="form-control" value="<c:out value="${orderModel.o_name }"/>" name="o_name" readonly></td>
						<td>주문상품</td>
						<td rowspan="3"><img src="${pageContext.request.contextPath}/resources/assets/img/image/${orderModel.f_svname }" style="width: 100px; height: 100px;"></td>
					</tr>
		
					<tr>
						<td>휴대전화</td>
						<td><input type="text" class="form-control"	name="o_mobile" value="<c:out value="${orderModel.o_mobile }"/>"></td>
						<td></td>
					</tr>
		
					<tr>
						<td>전화번호</td>
						<td><input type="text" class="form-control" name="o_tel" value="<c:out value="${orderModel.o_tel }"/>"></td>
						<td></td>
					</tr>
		
					<tr>
						<td>우편번호</td>
						<td><input type="text" class="form-control-width-zipcode" name="o_zipcode" value="<c:out value="${orderModel.o_zipcode }"/>" style="width:100px;">
						<button type="button" class="btn btn-login" style="padding:2px; margin-top:0px;">우편번호</button>
							</td>
						<td></td>
						<td rowspan="2">	
							<c:out value="${orderModel.g_name }"/><br>
							[<c:out value="${orderModel.o_option }"/>]
							[<c:out value="${orderModel.o_count }"/> 개]
						</td>
					</tr>
		
					<tr>
						<td rowspan="2">주소</td>
						<td><input type="text" class="form-control" name="o_address1" value="<c:out value="${orderModel.o_address1 }"/>">
						</td>
						<td></td>
					</tr>
		
					<tr>
						<td><input type="text" class="form-control" name="o_address2"  value="<c:out value="${orderModel.o_address2 }"/>">
						</td>
						<td colspan="2"
							style="font-size: 20px; font-style: italic; padding-left: 10px;">주문금액
							<c:out value="${orderModel.o_tprice }"/></td>
					</tr>
					
					
					<tr>
						<td>
							<div>비고</div>
						</td>
						<td colspan="3">
							<textarea name="o_request" rows="4" style="width:90%;"><c:out value="${orderModel.o_request }"/></textarea>
						</td>
					
					</tr>
				</TABLE>
			
		
			<div style="width: 700px; margin:auto; display: block;">
				<span style="float:right;">
					<span>배송상태변경</span> 
	
					<span> 
						<select name="o_delivery" >
							<option value="1" <c:if test="${orderModel.o_delivery == 1 }">
												selected
											  </c:if>>준비중
							</option>
							<option value="2" <c:if test="${orderModel.o_delivery == 2 }">
												selected
											  </c:if>>배송중
							</option>
							<option value="3" <c:if test="${orderModel.o_delivery == 3 }">
												selected
											  </c:if>>배송완료
							</option>
							<option value="4" <c:if test="${orderModel.o_delivery == 4 }">
												selected
											  </c:if>>구매확정
							</option>
						</select>
					</span>
				</span>
			</div>
	
	
			<div style="margin: auto; text-align: center; width:700px; margin-top:50px;">
				<button type="button" style="margin-right: 30px; width: 100px;"	class="btn btn-outline-submit">출력</button>
				<button type="submit" style="width: 100px;" class="btn btn-purple" id="mdofyOrder">저장</button>
			</div>
			
			</form>
		</div>

	</section>
</body>
</html>
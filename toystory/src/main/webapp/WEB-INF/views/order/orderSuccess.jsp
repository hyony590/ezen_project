<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/assets/js/member.js"></script>

<style type="text/css">
.btnM {
	border: none;
	color: #fff;
	background-color: #9b55d4;
	border-radius: 0.375rem;
	width: 181px;
	height: 37px;
}

</style>

</head>
<body>

<div class="contianer" style="margin-top: 340px; margin-bottom: 180px; text-align: center;">
<form id="myPage-form" method="post" action="#">
	<input type="hidden" name="m_num" value="<c:out value='${sessionScope.loginNum}'/>">
</form>

<h3 style="font-weight: bold; color:#9b55d4;">주문이 완료 되었습니다.</h3>
<p>빠르게 배송 해드릴게요!</p>

<div style="margin-top: 30px;">
	<button type="button" id="goMain" class="btnM">메인으로</button>
	<button type="button" id="myOrderList" class="btnM">주문내역보기</button>
</div>



</div>
</body>
</html>
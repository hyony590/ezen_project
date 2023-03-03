<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY PAGE</title>

<script src="/resources/assets/js/member.js"></script>
<link href="/resources/assets/css/member.css" rel="stylesheet">
</head>


<body>

<form id="myPage-form" method="post" action="#">
	<input type="hidden" name="m_num" value="<c:out value="${sessionScope.loginNum}"/>">
	<input type="hidden" name="pageNum" value="1">
	<input type="hidden" name="amount" value="10">
</form>

<div style="margin-top: 250px; margin-bottom: 120px;">
    <table class="input-form">
      <tr>
        <td style="height: 50px; font-size: 15pt"><h3 style="font-weight: bold; text-align: center;">MY PAGE</h3></td>
      </tr>

      <tr>
      	
        <td style="height: 50px; font-size: 25pt; color:#9b55d4"><div style="text-align: center;">"<c:out value="${sessionScope.loginName}"/>"님 안녕하세요!</div></td>
      </tr>

    </table>
  
	<div style="margin-top: 40px;">
	    <table class="input-form">
	      <tr>
	        <td style="height: 50px;"><button type="button" class="btn btn-login" id="modifyForm" style="width: 180px;">회원정보 수정</button></td>
	      </tr>
	      <tr>
	        <td style="height: 50px;"><button type="button" class="btn btn-login" id="#" style="width: 180px" onclick="location.href='/myPage/reviewlist.toy?m_num=<c:out value="${sessionScope.loginNum}"/>'">내가 쓴 리뷰/문의 확인</button></td>
	      </tr>
	      <tr>
	        <td style="height: 50px;"><button type="button" class="btn btn-login" id="myOrderList" style="width: 180px;">주문 내역 확인</button></td>
	      </tr>
	    </table>
    </div>

</div>


</body>
</html>
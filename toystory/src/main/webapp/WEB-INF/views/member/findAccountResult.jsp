<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정찾기</title>

<script type="text/javascript" src="/resources/assets/js/member.js"></script>
<link href="/resources/assets/css/member.css" rel="stylesheet">

</head>
<body>


<section id="sec1" class="align-center join-form">




	<c:if test="${result eq 0 }">
		해당하신 계정 정보가 없습니다.
	</c:if>


	<c:if test="${check eq 'id' }">
		<h3>아이디는 <c:out value='${ findAccount.m_email}'/> 입니다.</h3><br>
	</c:if>
	
	
	<c:if test="${check eq 'pw' }">
		<h3>아이디는 <c:out value='${ findAccount.m_email}'/> 입니다. <br><br>
		비밀번호는 <c:out value='${ findAccount.m_password}'/> 입니다.</h3>
	</c:if>
		
	
</section>
<section  class="align-center">


	<div>
	
		<button type="button" id="goMain" class="btn btn-login">메인으로</button>
		<button type="button" id="goLogin" class="btn btn-login">로그인</button>
	
	</div>
	
</section>

	
	
</body>
</html>
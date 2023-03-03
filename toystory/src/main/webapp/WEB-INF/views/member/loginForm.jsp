<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<script type="text/javascript" src="/resources/assets/js/member.js"></script>
<link href="/resources/assets/css/member.css" rel="stylesheet">

</head>
<body onload="loginCheck('${code}')">


<section class="join-form" style="margin-top: 100px; margin-bottom: 100px;">
	
	<div class="lTitleA" style="margin-top: 50px; margin-bottom:30px; text-align: center;">
		<h3 style="font-weight: bold;">LOGIN</h3>
	</div>
	
	<div class="mlogin">
	<fieldset class="field">
		<form action="/login/loginPro.toy" method="post">
	
			<table class="join-table input-form" align="center">
				<thead>
					<!-- <tr>
						<th colspan="2" class="formHeader">LOGIN</th>
					</tr> -->
				</thead>
	
				<tbody>
					<tr>
						<th><label for="m_email" class="form-header" style="font-size: 14.5px;">아이디</label></th>
						<td>
							<input type="text" class="form-control" style="font-size: 13px;" id="m_email" name="m_email" placeholder="이메일 형식으로 입력해주세요.">
						</td>
					</tr>
					<tr>
						<th><label for="m_password" class="form-header" style="font-size: 14.5px;">비밀번호</label></th>
						<td><input type="password" class="form-control" id="m_password" name="m_password" placeholder="····"> </td>
					</tr>

					<tr>
						<td colspan="2" align="center" height="25"></td>
					</tr>

					<tr>
						<td colspan="2" align="center">
							<button type="button" class="btn btn-login" id="login-btn">로그인</button>
						</td>
					</tr>

					<tr>
						<td colspan="2" align="center" height="10"></td>
					</tr>

					<tr>
						<td colspan="2" align="center">
							<button type="button" id="joinForm" class="Lbt" style="padding-right: 20px;padding-left: 20px;">회원가입</button>
							<button type="button" id="findId" class="Lbt" style="padding-right: 20px; padding-left: 20px;">아이디찾기</button>
							<button type="button" id="findPw" class="Lbt" style="border-right: 1px solid #fff; padding-left: 20px;">비밀번호 찾기</button>
						</td>
					</tr>
					
				</tbody>
			</table>
			</fieldset>
			</form>
	</div>
	
	</section>
	
	
</body>
</html>
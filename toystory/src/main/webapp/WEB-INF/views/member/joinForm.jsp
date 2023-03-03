<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<link href="/resources/assets/css/member.css" rel="stylesheet">
<script defer type="text/javascript"
	src="/resources/assets/js/member.js"></script>

</head>
<body>

	<section id="sec1" class="join-form">

		<h3 style="text-align: center; margin-bottom: 30px;">JOIN</h3>

		<fieldset class="Jfield">
			<form action="/join/join.toy" method="post" id="join-form">
				<input type="hidden" id="idCheck" value='0'> <input
					type="hidden" id="mobileCheck" value='0'> <input
					type="hidden" id="passwordSameCheck" value='0'>

				<table style="margin-left: auto; margin-right: auto;">

					<tbody>
							<p class="jp"><img alt="required" class="rimg" src="/resources/assets/img/required_icon.gif">필수입력사항</p>
						<tr>
							<th><label for="m_email" class="form-header" style="margin-right: 17pt;">아이디<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control" id="email_check" placeholder="이메일 형식으로 입력해주세요." style="font-size: 13px;"
								name="m_email"></td>
						</tr>

						<tr>
							<td height="30"></td>
							<td height="30"><div class="id_check" id="id_check_result"
									style="text-align: left;"></div></td>
						</tr>

						<tr>
							<th><label for="m_password1" class="form-header" style="margin-right: 17pt;">비밀번호<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="password" class="form-control" style="font-size: 13px;"
								id="m_password" name="m_password"></td>
						</tr>
						<tr>
							<th><label for="m_password2" class="form-header" style="margin-right: 17pt;">비밀번호
									확인<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="password" class="form-control" style="font-size: 13px;"
								id="m_password2" name="m_password2"></td>
						</tr>
						<tr>
							<td height="30"></td>
							<td height="30"><div class="passwordCheck"
									id="passwordCheck" style="text-align: left; font-size: 12px;"></div></td>
						</tr>
						<tr>
							<th><label for="m_name" class="form-header" style="margin-right: 17pt;">이름<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control" id="m_name" style="font-size: 13px;"
								name="m_name"></td>
						</tr>
						<tr>
							<th><label for="m_birth" class="form-header" style="margin-right: 17pt;">생일<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="date" class="form-control" id="m_birth" style="font-size: 13px;"
								name="m_birth" value="2000-01-01"></td>
						</tr>
						<tr>
							<th><label for="m_mobile" class=form-header style="margin-right: 17pt;">휴대전화<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control" id="m_mobile" style="font-size: 13px;"
								name="m_mobile"></td>

						</tr>

						<tr>
							<td height="30"></td>
							<td height="30"><div class="mobildCheck"
									id="mobile_check_result" style="text-align: left;"></div></td>
						</tr>

						<tr>
							<th><label for="m_phone" class="form-header" style="margin-right: 17pt;">전화번호</label></th>
							<td><input type="text" class="form-control" id="m_phone" style="font-size: 13px;"
								name="m_phone"></td>
						</tr>
						<tr>
							<td colspan="2" height="20"></td>
						</tr>
						<tr>
							<th><label for="m_zipcode" class="form-header" style="margin-right: 17pt; margin-bottom: 14px;">우편번호<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control-width-zipcode"
								id="sample6_postcode" name="m_zipcode" readonly
								style="width: 30%; height:27px ; margin-left: 0; font-size: 13px;">
								<button type="button" class="btn btn-outline-inbtn"
									id="findZipcode" onclick="sample6_execDaumPostcode()" style="margin-bottom: 2px; font-size: 13px;">검 색</button></td>
						</tr>
						<tr>
							<th><label for="m_address1" class="form-header" style="margin-right: 17pt;">주소<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control" style="font-size: 13px;"
								id="sample6_address" name="m_address1" readonly></td>
						</tr>
						<tr>
							<th><label for="m_address2" class="form-header" style="margin-right: 17pt;">상세주소<img alt="required" class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control " style="font-size: 13px;"
								id="sample6_detailAddress" name="m_address2"></td>
						</tr>
						<tr>
							<td colspan="2" align="center" height="90" style="vertical-align:bottom;">
								<button type="reset" class="jbb2"
									id="resetJoin">다시작성</button>
								<button type="button" class="jbb" id="join">회원가입</button>
							</td>
						</tr>
					</tbody>
				</table>

			</form>
			<br/>
		</fieldset>
	</section>


</body>

<script>
	
</script>
</html>
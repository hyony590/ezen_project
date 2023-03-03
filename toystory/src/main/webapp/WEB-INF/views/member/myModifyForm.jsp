<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<script language="JavaScript"
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="/resources/assets/js/member.js"></script>
<script>
	$(document).ready(
			function() {
				$('#modify_confirm').on(
						'click',
						function() {
							var check = $('#passwordSameCheck').val();
							if (check == 0) {
								alert("비밀번호가 동일하지 않습니다");
								return false();
							}
							$('#oper-form').attr("action",
									"/myPage/modifyPro.toy").submit();
						})

				$('#leave_confirm').on(
						'click',
						function() {oper-form

							$('#oper-form').attr("action", "/myPage/leave.toy")
									.submit();
						})

				$('#mo_m_mobile').focusout(
						function() {

							let mobile = $('#mo_m_mobile').val();
							let pattern = /^[0-9]{10,12}$/i;
							let inputMobile = '${member.m_mobile }';

							if (inputMobile == mobile) {
								$("#mobile_check_result").html(null);
								$('#mobileCheck').val(1);

								return false;
							}

							if (!pattern.test(mobile)) {
								$("#mobile_check_result").html(
										'10~12 자리수로 입력해주세요');
								$("#mobile_check_result").css('color', 'red');
								$('#mobileCheck').val(0);
								return false;

							}

							if (mobile != null && mobile != '') {

								$.ajax({
									url : "/join/mobileCheck.toy",
									type : "post",
									contentType : "application/json",
									data : JSON.stringify({
										mobile : mobile
									}),
									dataType : 'json',
									success : function(result, status, xhr) {
										if (result != 0) {
											$("#mobile_check_result").html(
													'중복된 휴대폰번호 입니다.');
											$("#mobile_check_result").css(
													'color', 'red');
											$('#mobileCheck').val(0);
										} else {
											$("#mobile_check_result").html(
													'사용 가능한 휴대폰번호 입니다.');
											$("#mobile_check_result").css(
													'color', 'green');
											$('#mobileCheck').val(1);
										}
									},
									error : function() {
										alert("서버요청실패");
									}
								})
							} else {
								$("#mobile_check_result")
										.html("휴대폰 번호를 입력해주세요");
								$("#mobile_check_result").css('color', 'red');
								$('#mobileCheck').val(-1);
							}
						});

			})
</script>


<link href="/resources/assets/css/member.css" rel="stylesheet">


</head>
<body>


	<section style="margin-top: 138px;">

		<h4
			style="text-align: center; margin-bottom: 50px; font-weight: bold;">내
			정보 수정</h4>

		<fieldset class="Jfield">
			<!-- <form action="/myPage/modifyPro.toy" id="oper-form" method="post"> -->
			<form id="oper-form" method="post">
				<input type="hidden" id="idCheck" value='1'> <input
					type="hidden" id="mobileCheck" value='0'> <input
					type="hidden" id="passwordSameCheck" value='0'>


				<table style="margin: auto;">
					<thead>
					</thead>

					<tbody>
						<tr>
							<th><label for="mEmail" class="form-header"
								style="margin-right: 17pt;">아이디<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control" id="m_email"
								placeholder="이메일 형식으로 입력해주세요." style="font-size: 13px;"
								name="m_email" value="<c:out value='${member.m_email }'/>"
								readonly></td>
						</tr>
						
						<tr>
							<th><label for="mPassword" class="form-header"
								style="margin-right: 17pt;">비밀번호<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="password" class="form-control"
								style="font-size: 13px;" id="m_password" name="m_password"
								value="<c:out value='${member.m_password }'/>"></td>
						</tr>

						<tr>
							<th><label for="mPassword2" class="form-header"
								style="margin-right: 17pt;">비밀번호 확인<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="password" class="form-control"
								style="font-size: 13px;" id="m_password2" name="m_password2"
								></td>
						</tr>

						<tr>
							<td height="30"></td>
							<td height="30"><div class="passwordCheck"
									id="passwordCheck" style="text-align: left; font-size: 12px;"></div></td>
						</tr>

						<tr>
							<th><label for="mName" class="form-header"
								style="margin-right: 17pt;">이름<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control" id="mName"
								style="font-size: 13px;" name="m_name"
								value="<c:out value='${member.m_name }'/>"></td>
						</tr>

						<tr>
							<th><label for="mBirth" class="form-header"
								style="margin-right: 17pt;">생일<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="date" class="form-control" id="mBirth"
								style="font-size: 13px;" name="m_birth"
								value="<c:out value='${member.m_birth }'/>"></td>
						</tr>

						<tr>
							<th><label for="mMobile" class=form-header
								style="margin-right: 17pt;">휴대전화<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control" id="mo_m_mobile"
								style="font-size: 13px;"
								value="<c:out value='${member.m_mobile }'/>" name="m_mobile"></td>

						</tr>

						<tr>
							<td height="30"></td>
							<td height="30"><div class="mobildCheck"
									id="mobile_check_result" style="text-align: left;"></div></td>
						</tr>

						<tr>
							<th><label for="mPhone" class="form-header"
								style="margin-right: 17pt;">전화번호</label></th>
							<td><input type="text" class="form-control" id="m_phone"
								style="font-size: 13px;"
								value="<c:out value='${member.m_phone }'/>" name="m_phone"></td>
						</tr>

						<tr>
							<td colspan="2" height="20"></td>
						</tr>

						<tr>
							<th><label for="mZipcode" class="form-header"
								style="margin-right: 17pt; margin-bottom: 14px;">우편번호<img
									alt="required" class="rimg2"
									src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control-width-zipcode"
								value="<c:out value='${member.m_zipcode }'/>" readonly
								id="sample6_postcode" name="m_zipcode"
								style="width: 30%; height: 27px; padding-left: 12px; font-size: 13px;">
								<button type="button" class="btn btn-outline-inbtn"
									id="findZipcode" onclick="sample6_execDaumPostcode()"
									style="margin-bottom: 3px; font-size: 13px;">검 색</button></td>
						</tr>

						<tr>
							<th><label for="mAddress1" class="form-header"
								style="margin-right: 17pt;">주소<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control"
								style="font-size: 13px;"
								value="<c:out value='${member.m_address1 }'/>"
								id="sample6_address" name="m_address1"></td>
						</tr>

						<tr>
							<th><label for="mAddress2" class="form-header"
								style="margin-right: 17pt;">상세주소<img alt="required"
									class="rimg2" src="/resources/assets/img/required_icon.gif"></label></th>
							<td><input type="text" class="form-control "
								style="font-size: 13px;"
								value="<c:out value='${member.m_address2 }'/>"
								id="sample6_detailAddress" name="m_address2"></td>
						</tr>

						<tr>
							<td colspan="2" align="center" height="100">
								<button type="button" class="jbb" id="modify_confirm">수정</button>
								<button type="button" class="jbb2" id="leave_confirm">탈퇴</button>
							</td>
						</tr>
					</tbody>
				</table>

			</form>
		</fieldset>

	</section>

</body>
</html>
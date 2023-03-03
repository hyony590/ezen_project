<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>성인인증</title>

<link href="/resources/assets/css/member.css" rel="stylesheet">
<script type="text/javascript" src="/resources/assets/js/member.js"></script>

</head>
<body>

	<section style="margin-top: 100px; margin-left: 200px; padding-bottom: 5px;">
		<div class="container adult">
			<div class="imgA">
				<img src="/resources/assets/img/unicorn.png" width="200" />
			</div>
			<div class="textA">
				<h4 style="font-weight: bold;">19세 미만이 구매할 수 없는 제품이 포함되어있는 페이지 입니다.</h4>
				<p>이 정보내용은 청소년 유해 매체물로서 정보통신망 이용촉진법 및
				정보보호 등에 관한 법률 및 청소년 보호법의 규정에 의하여</p>
				<h4 style="font-weight: bold; color: #9b55d4;">19세 미만의 청소년은 이용할 수 없습니다.</h4>
			<button type="button" class="btn btn-outline-submit" id="goMain">19세 미만 나가기</button>
			</div>
			<div class="btnA">
			</div>


			<!-- <table class="input-form" style="width: 35%;" >
    <tr>
      <td rowspan="5" width="20%"><img src="/resources/assets/img/gallery/unicorn.png" width="200"/></td>
      
    </tr>


    <tr>
      <td>
        19세 미만이 구매할 수 없는 제품이 포함되어있는 페이지 입니다.
        이 정보내용은 청소년 유해 매체물로서 정보통신망 이용촉진법 및 정보보호 등에 관한
        법률 및 청소년 보호법의 규정에 의하여
      </td>
    </tr>
    
    <tr>
      <td><div style="font-size: 19px; color:red">19세 미만의 청소년은 이용할 수 없습니다.</div></td>
    </tr>
    <tr>
      <td><div style="font-size: 19px;"><button type="button" class="btn btn-outline-submit" id="goMain">19세 미만 나가기</button></div></td>
    </tr>


  </table> -->
		</div>
	</section>

	<section style="padding: 10px; margin-top:0px; margin-bottom: 100px;">
		<div>
			<form action="/login/adultCheck.toy" method="post" >

				<h4 class="title">성인인증</h4>


				<table class="input-form">

					<tbody>
						<tr>
							<th><label for="m_birth" class="form-header">생년월일</label></th>
							<td><input type="date" class="form-control" id="m_birth"
								name="m_birth" value="2000-01-01"></td>
						</tr>
						<tr>
							<td height="30"></td>
						</tr>

						<tr>
							<td colspan="2" align="center">
								<button type="button" class="btn btn-login w-75 h-50"
									id="adultCheck">인증하기</button>
							</td>
						</tr>



					</tbody>
				</table>

			</form>
		</div>
	</section>
	<br/><br/><br/>
</body>
</html>
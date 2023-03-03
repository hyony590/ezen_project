<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport"
	content="width=device-width, initial-scale=1">
<link href="/resources/assets/css/notice.css" rel="stylesheet">

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
	<section id="noticeF">
		<div class="container">
			<h3>문의 작성하기</h3>
		</div>

		<div class="container" style="text-align: left; width: 700px;">
			<form action="qnapro.toy" method="post" name="qna">
				<div class="form-group" style="margin-bottom: 30px;">
					<p style="font-weight: bold;">제목</p>
					<input type="text" class="form-control" name="q_title"
						placeholder="제목 입력(4-100)" maxlength="100" required="required">
					<input type="hidden" name="g_id" value="${g_id}">
				</div>
				<div class="form-group" style="margin-bottom: 30px;">
					<p style="font-weight: bold;">내용</p>
					<textarea rows="17" class="form-control" name="q_content"
						placeholder="내용 작성" class="form-control" id="textArea_byteLimit"
						name="textArea_byteLimit" onkeyup="fn_checkByte(this)" wrap="hard" cols = ""></textarea>
						<sup>(<span id="nowByte">0</span>/1400bytes)</sup>
				</div>

				<div style="margin-top: 20px; text-align: center;">
					<button class="btn-book-a-table" onclick="return check()">등록</button>
					<button type="button"
						onclick="location.href='/goods/detail.toy?g_id=${g_id}'"
						class="btn-book-a-table">취소</button>

				</div>

			</form>
		</div>

	</section>
</body>

<script>
	function check() {

		if (document.qna.q_title.value.trim() == "") {
			alert("제목를 입력해 주세요.");
			document.qna.q_title.focus();
			return false;
		} else if (document.qna.q_content.value.trim() == "") {
			alert("내용를 입력해 주세요.");
			document.qna.q_content.focus();
			return false;
		} else {
			alert("게시글이 등록되었습니다.")
			document.qna.submit();
		}
	}
	function fn_checkByte(obj) {
		const maxByte = 1400; //최대 100바이트
		const text_val = obj.value; //입력한 문자
		const text_len = text_val.length; //입력한 문자수

		let totalByte = 0;
		for (let i = 0; i < text_len; i++) {
			const each_char = text_val.charAt(i);
			const uni_char = escape(each_char); //유니코드 형식으로 변환
			if (uni_char.length > 4) {
				// 한글 : 2Byte
				totalByte += 3;
			} else {
				// 영문,숫자,특수문자 : 1Byte
				totalByte += 1;
			}
		}

		if (totalByte > maxByte) {
			alert('최대 1400Byte까지만 입력가능합니다.');
			document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "red";
		} else {
			document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "green";
		}
	}
</script>

</html>

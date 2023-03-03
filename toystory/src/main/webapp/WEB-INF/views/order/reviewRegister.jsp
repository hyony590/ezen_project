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

<script src="/resources/assets/js/member.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js">
	
</script>

</head>
<body>
	<section id="noticeF">
		<div class="container">
			<h3 style="margin-bottom: 20px;">리뷰 작성하기</h3>
		</div>

		<form id="myPage-form" method="post" action="#">
			<input class="in" type="hidden" name="m_num"
				value="<c:out value="${sessionScope.loginNum}"/>">
		</form>


		<div class="container" style="width: 700px;">
			<form action="reviewpro.toy" method="post" name="review"
				enctype="multipart/form-data">
				<!-- 별점 선택 -->
				<div id="myform">
					<fieldset>
						<p id="p">?상품은 만족하셨나요</p>
						<input type="radio" name="r_star" value="5" id="rate1"> <label
							for="rate1">★</label> <input type="radio" name="r_star" value="4"
							id="rate2"> <label for="rate2">★</label> <input
							type="radio" name="r_star" value="3" id="rate3"> <label
							for="rate3">★</label> <input type="radio" name="r_star" value="2"
							id="rate4"> <label for="rate4">★</label> <input
							type="radio" name="r_star" value="1" id="rate5"> <label
							for="rate5">★</label>
					</fieldset>
				</div>
				<div class="form-group">
					<p id="p">제목을 입력해주세요.
					<p>
						<input type="text" class="form-control" name="r_title"
							placeholder="제목 입력(4-70)" required="required"> <input
							type="hidden" name="o_num" value="${o_num}">
				</div>
				<div class="form-group">
					<p id="p">어떤 점이 좋았나요?
					<p>
						<textarea rows="17" class="form-control" name="r_content"
							placeholder="내용 작성" id="textArea_byteLimit"
							name="textArea_byteLimit" onkeyup="fn_checkByte(this)"
							wrap="hard" cols=""></textarea>
						<sup style = "float: left; margin-top: 17px;">(<span id="nowByte">0</span>/1400bytes)
						</sup>
				</div>

				<div id="fileDiv" style="text-align: left; margin-top: 20px;">
					<span><input type="file" id="file" name="file_0"> <a
						href="#this" class="btn" id="delete" name="delete">삭제</a> <a
						href="#this" class="btn" id="addFile">파일 추가</a></span>
				</div>

				<div style="margin-top: 30px;">
					<button class="btn-book-a-table" onclick="return check()">등록</button>
					<button type="button" class="btn-book-a-table" id="myOrderList">취소</button>
				</div>

			</form>
		</div>

	</section>
</body>

<script>
	function check() {

		if (document.review.r_title.value.trim() == "") {
			alert("제목를 입력해 주세요.");
			document.review.r_title.focus();
			return false;
		} else if (document.review.r_content.value.trim() == "") {
			alert("내용를 입력해 주세요.");
			document.review.r_content.focus();
			return false;
		} else if (document.review.r_star.value.trim() == "") {
			alert("별점을 남겨 주세요.");
			document.review.r_star.focus();
			return false;
		} else {
			alert("게시글이 등록되었습니다.")
			document.review.submit();
		}
	}
</script>
<script type="text/javascript">
	var gfv_count = 1;

	$(document).ready(function() {
		$("#addFile").on("click", function(e) { //파일 추가 버튼
			e.preventDefault();
			fn_addFile();
		});

		$("a[name='delete']").on("click", function(e) { //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
	});

	function fn_addFile() {
		var str = "<p><input type='file' name='file_" + (gfv_count++)
				+ "'><a href='#this' class='btn' name='delete'>삭제</a></p>";
		$("#fileDiv").append(str);
		$("a[name='delete']").on("click", function(e) { //삭제 버튼
			e.preventDefault();
			fn_deleteFile($(this));
		});
	}

	function fn_deleteFile(obj) {
		obj.parent().remove();
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

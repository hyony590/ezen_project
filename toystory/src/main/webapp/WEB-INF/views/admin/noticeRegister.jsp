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
			<h3>공지/이벤트 등록</h3>
		</div>

		<div class="container" style="text-align: left; width: 700px">
			<form action="registerpro.toy" method="post"
				encType="multipart/form-data" name="notice">
				<div class="form-group" style="margin-bottom: 30px;">
					<p style="font-weight: bold;">제목</p>
					<input type="text" class="form-control" name="n_title"
						placeholder="제목 입력(4-70)" maxlength="100" required="required">
				</div>
				<div class="form-group" style="margin-bottom: 30px;">
					<div class="textLengthWrap"></div>
					<p style="font-weight: bold;">내용</p>
						<textarea rows="17" class="form-control" name="n_content"
						placeholder="내용 작성" class="form-control" id="textArea_byteLimit"
						name="textArea_byteLimit" onkeyup="fn_checkByte(this)" wrap="hard" cols = "">
						</textarea>
						<sup>(<span id="nowByte">0</span>/1400bytes)</sup>
				</div>

				<div id="fileDiv" style="text-align: left;">
					<span><input type="file" id="file" name="file_0"> <a
						href="#this" class="btn" id="delete" name="delete">삭제</a> <a
						href="#this" class="btn" id="addFile">파일 추가</a></span>
				</div>

				<div style="margin-top: 30px; text-align: center;">
					<button type="submit" class="btn-book-a-table"
						onclick="return check()">등록</button>
					<button type="button" data-oper='list' id="list"
						class="btn-book-a-table">취소</button>
				</div>


			</form>
		</div>

	</section>

</body>

<script>
	$(document).ready(function() {
		$('#list').on('click', function() {
			self.location = "/admin/notice/list.toy"
		});
	});
</script>

<script>
	function check() {

		if (document.notice.n_title.value.trim() == "") {
			alert("제목를 입력해 주세요.");
			document.notice.n_title.focus();
			return false;
		} else if (document.notice.n_content.value.trim() == "") {
			alert("내용를 입력해 주세요.");
			document.notice.n_content.focus();
			return false;
		} else {
			alert("게시글이 등록되었습니다.")
			document.notice.submit();
		}
	}
</script>
<script type="text/javascript">
	var gfv_count = 1;

	$(document)
			.ready(
					function() {
						$("#addFile").on("click", function(e) { //파일 추가 버튼
							e.preventDefault();
							fn_addFile();

						});

						$("a[name='delete']").on("click", function(e) { //삭제 버튼
							e.preventDefault();
							fn_deleteFile($(this));
						});

						function fn_addFile() {
							var str = "<p><input type='file' id='file' name='file_"
									+ (gfv_count++)
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

						/* 업로드 이미지 미리보기 */
						/*  $(function() {
						    $("#file").on('change', function(){
						    readURL(this);
						    });
						});

						 function readURL(input) {
						    if (input.files && input.files[0]) {
						        var reader = new FileReader();
						        reader.onload = function (e) {
						        $('#View').attr('src', e.target.result);
						        }
						        reader.readAsDataURL(input.files[0]);
						    }
						} */

					});
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
			alert('최대 1500Byte까지만 입력가능합니다.');
			document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "red";
		} else {
			document.getElementById("nowByte").innerText = totalByte;
			document.getElementById("nowByte").style.color = "green";
		}
	}
</script>
</html>
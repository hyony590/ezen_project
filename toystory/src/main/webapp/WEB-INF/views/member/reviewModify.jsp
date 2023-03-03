<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<%
      pageContext.setAttribute("crcn", "\r\n");
      pageContext.setAttribute("br", "<br>"); 
%> 
	<section id="noticeF">
		<div class="container">
			<h3 style="margin-bottom: 20px;">리뷰 수정하기</h3>
		</div>

		<form action="/myPage/reviewModifypro.toy" method="post"
			enctype="multipart/form-data" role="form">
			<input type="hidden" name="r_num" value="${modify.r_num}" /> <input
				type="hidden" name="m_num" value="${sessionScope.loginNum}" />

			<div class="container" style="width: 700px;">
				<!-- 별점 선택 -->
				<div id="myform">
					<fieldset>
						<p id="p">?상품은 만족하셨나요</p>


						<input type="radio" name="r_star" value="5" id="rate1"
							<c:if test="${modify.r_star eq 5}">checked</c:if> /> <label
							for="rate1">★</label> <input type="radio" name="r_star" value="4"
							id="rate2" <c:if test="${modify.r_star eq 4}">checked</c:if> />
						<label for="rate2">★</label> <input type="radio" name="r_star"
							value="3" id="rate3"
							<c:if test="${modify.r_star eq 3}">checked</c:if> /> <label
							for="rate3">★</label> <input type="radio" name="r_star" value="2"
							id="rate4" <c:if test="${modify.r_star eq 2}">checked</c:if> />
						<label for="rate4">★</label> <input type="radio" name="r_star"
							value="1" id="rate5"
							<c:if test="${modify.r_star eq 1}">checked</c:if> /> <label
							for="rate5">★</label>
					</fieldset>
				</div>
				<div class="form-group">
					<p id="p">제목을 입력해주세요.
					<p>
						<input type="text" class="form-control" name="r_title"
							required="required" value='<c:out value = "${modify.r_title}"/>'>
				</div>
				<div class="form-group">
					<p id="p">어떤 점이 좋았나요?
					<p>
						<textarea rows="17" class="form-control" name="r_content"
							placeholder="" id="textArea_byteLimit" name="textArea_byteLimit"
							onkeyup="fn_checkByte(this)" wrap="hard" cols=""><c:out
								value="${fn:replace(modify.r_content,br,crcn)}" /></textarea>
						<sup style = "float:left; margin-top:17px">(<span id="nowByte">0</span>/1400bytes)</sup>
				</div>

				<div style="margin-bottom: 20px; margin-top:17px">
					<p>

						<c:set var="optionArr" value="${fn:split(modify.f_svname,',')}"></c:set>
						<c:if test="${modify.f_svname != null}">
							<p style="font-weight: bold;">기존 이미지(삭제할 이미지를 체크해주세요)</p>
							<c:forEach begin='0' end='${fn:length(optionArr)}'
								items="${optionArr}" varStatus='status'>
								<div style="text-align: center;">
									<img
										src="${pageContext.request.contextPath}/resources/assets/img/image/${optionArr[status.index]}"
										style="width: 90%; height: auto;" />&nbsp;&nbsp;&nbsp; <input
										id="input2" class="check" type="checkbox" name="item"
										value="${optionArr[status.index]}"><br /> <br />
								</div>
							</c:forEach>

							<div id="fileDiv"
								style="text-align: left; margin-top: 20px; margin-left: 20px;">
								<span><input type="file" id="file" name="file_0">
									<a href="#this" class="btn" id="delete" name="delete"
									style="font-size: 13px;">삭제</a> <a href="#this" class="btn"
									id="addFile" style="font-size: 13px;">파일 추가</a></span>
							</div>
						</c:if>
					</p>
				</div>

				<c:if test="${modify.f_svname == null}">
					<div class="form-group">
						<div id="fileDiv" style="text-align: left;">
							<span><input type="file" id="file" name="file_0">
								<a href="#this" class="btn" id="delete" name="delete">삭제</a> <a
								href="#this" class="btn" id="addFile">파일 추가</a></span>
						</div>
					</div>
				</c:if>

				<div style="margin-top: 40px; text-align: center;">
					<button type="submit" class="btn-book-a-table"
						style="border: 0; margin-right: 10px;" id="deleteButton">수정</button>
					<button type="button" data-oper='list' id="list"
						class="btn-book-a-table" style="border: 0"
						onclick="location.href='/myPage/reviewlist.toy?m_num=${sessionScope.loginNum}'">취소</button>
				</div>
			</div>
		</form>
	</section>
</body>
<script>
	$('#deleteButton').on('click', function() {
		var fnameList = [];

		$("input[name=item]:checked").each(function(i) {
			fnameList.push($(this).val());
		});

		$.ajax({
			url : "/myPage/reviewModifypro.toy", //12-8 url 수정
			type : "get",
			data : {
				chbox : fnameList
			}, //변수이름 chbox ,변수값: fnameList 
			dataType : 'json',
			success : function(result) {
			}
		});
		alert('게시글이 수정되었습니다.');
	});

	var gfv_count = 1;

	$("#addFile").on("click", function(e) { //파일 추가 버튼
		e.preventDefault();
		fn_addFile();
	});

	$("a[name='delete']").on("click", function(e) { //삭제 버튼
		e.preventDefault();
		fn_deleteFile($(this));
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
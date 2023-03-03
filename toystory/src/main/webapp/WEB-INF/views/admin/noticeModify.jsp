<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/notice.css" rel="stylesheet" />
<meta charset="UTF-8" />
</head>
<body>
<%
      pageContext.setAttribute("crcn", "\r\n");
      pageContext.setAttribute("br", "<br>"); 
%> 
	<section id="noticeF">
		<div class="container">
			<h3>게시글 수정하기</h3>
		</div>

		<div class="container" style="text-align: left; width: 700px">
			<form role="form" action="/admin/notice/modifypro.toy" method="post"
				encType="multipart/form-data">

				<input type="hidden" value="${modify.n_num}" name="n_num">

				<div class="form-group" style="margin-bottom: 30px;">
					<p style="font-weight: bold;">제목</p>
					<input class="form-control" name="n_title"
						value='<c:out value="${modify.n_title}"/>'>
				</div>

				<div class="form-group" style="margin-bottom: 20px;">
					<p style="font-weight: bold;">내용</p>
					<textarea rows="13" class="form-control" rows="3"
						id="textArea_byteLimit" name="n_content"
						onkeyup="fn_checkByte(this)"><c:out
							value="${fn:replace(modify.n_content,br,crcn)}" /></textarea>
					<sup>(<span id="nowByte">0</span>/1400bytes)
					</sup>
				</div>
				<div style="margin-bottom: 20px;">
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
						class="btn-book-a-table" style="border: 0">취소</button>
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

	$('#deleteButton').on('click', function() {
		var fnameList = [];

		$("input[name=item]:checked").each(function(i) {
			fnameList.push($(this).val());
		});

		if(fnameList.length > 0){
		
			$.ajax({
				url : "/admin/notice/modifypro.toy", //12-8 url 수정
				type : "get",
				data : {
					chbox : fnameList
				}, //변수이름 chbox ,변수값: fnameList 
				dataType : 'json',
				success : function(result) {
				}
			});
		}
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
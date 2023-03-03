<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/notice.css" rel="stylesheet">
<meta charset="UTF-8">
<style type="text/css">
.my_img {
	filter: brightness(1);
}

.my_img:hover {
	filter: brightness(0.7);
}
</style>
</head>
<body>
	<%
	pageContext.setAttribute("crcn", "\r\n");
	pageContext.setAttribute("br", "<br>");
	%>
	<br>
	<section id="noticeD">
		<div class="container">
			<h3>리뷰 게시글</h3>
			<p>게시글입니다</p>
			<br>
		</div>

		<div class="container">
			<form id="register" role="form"
				action="/admin/review/commentRegister.toy" method="post">
				<input type='hidden' id='r_num' name='r_num'
					value="${Rdetail.r_num}" /> <input type="hidden"
					value="${Qdetail.g_id}" />
				<div style="border-bottom: 1px solid #444444;">
					<br> <br>
				</div>
				<table class="table" style="margin-bottom: 30px;">
					<thead></thead>
					<tbody>

						<tr>
							<td
								style="text-align: left; font-size: 17px; padding-left: 10px;">
								<!-- 제목 --> <a style="font-weight: bold;"> <c:out
										value="${Rdetail.r_title}" /></a>&nbsp;&nbsp; <!-- 별점 --> <span
								style="color: #ffc81e;"> <c:if
										test="${Rdetail.r_star eq 1}">
										<c:out value="★☆☆☆☆" />
									</c:if> <c:if test="${Rdetail.r_star eq 2}">
										<c:out value="★★☆☆☆" />
									</c:if> <c:if test="${Rdetail.r_star eq 3}">
										<c:out value="★★★☆☆" />
									</c:if> <c:if test="${Rdetail.r_star eq 4}">
										<c:out value="★★★★☆" />
									</c:if> <c:if test="${Rdetail.r_star eq 5}">
										<c:out value="★★★★★" />
									</c:if>
							</span>
							</td>
							<td style="text-align: right;">작성일&nbsp;&nbsp; <fmt:formatDate
									pattern="yyyy-MM-dd" value="${Rdetail.r_regdate}" /></td>
						</tr>
						<!-- 내용 보임 -->
						<tr>
							<td colspan="2" style="padding: 10px; 0 0 10px;">
								<div style="text-align: left;">
									<p style="font-size: small; color: #808080">
										<!-- 상품명 -->
										<a href="/goods/detail.toy?g_id=${Rdetail.g_id}"> <c:out
												value="${Rdetail.g_name}" /></a>&nbsp;&nbsp;
										<!-- [옵션], [수량] -->
										옵션 [
										<c:out value="${Rdetail.o_option}" />
										] / 수량 [
										<c:out value="${Rdetail.o_count}" />
										]
									</p>
									<p style="margin-bottom: 30px; word-break: break-all;">
										${fn:replace(Rdetail.r_content,crcn,br)}</p>
								</div>
								<div style="text-align: left; margin-bottom: 50px;">
									<p>
										<c:set var="optionArr"
											value="${fn:split(Rdetail.f_svname,',')}"></c:set>
										<c:forEach begin='0' end='${fn:length(optionArr) }'
											items="${optionArr}" varStatus='status'>
											<c:if test="${Rdetail.f_svname != null}">
												<a
													href="${pageContext.request.contextPath}/resources/assets/img/image/${optionArr[status.index]}"
													class="glightbox"> <img class="my_img"
													src="${pageContext.request.contextPath}/resources/assets/img/image/${optionArr[status.index]}"
													style="width: 250px; height: 250px;" />&nbsp;&nbsp;
												</a>
											</c:if>
											<c:if test="${Rdetail.f_svname == null}">
											</c:if>
										</c:forEach>
									</p>
								</div>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- 관리자 답변 작성 -->
				<div>
					<textarea
						style="border-radius: 10px; resize: none; margin-bottom: 10px; width: 100%;"
						rows="8" cols="182" id="r_comment" name="r_comment"
						placeholder="답변 작성"><c:out value="${Rdetail.r_comment}" /></textarea>

					<button type="submit" class="btn-book-a-table"
						data-opper="register" style="border: none"
						onclick="return alert('등록 되었습니다.')">등록</button>
					<button type="button" id="list" style="border: none"
						class="btn-book-a-table">취소</button>
				</div>


			</form>

		</div>

	</section>
</body>

<script type="text/javascript">
	$(document).ready(
			function() {
				$('#list').on('click', function() {
					self.location = "/admin/review/list.toy"
				});

				var operForm = $("#register");
				$("button[data-oper='register']").on(
						"click",
						function(e) {
							operForm.attr("action",
									"/admin/review/commentRegister.toy")
									.submit();
						});
			});
</script>


</html>
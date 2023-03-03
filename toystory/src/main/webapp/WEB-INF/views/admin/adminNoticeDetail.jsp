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
</head>
<body>

	<%
	pageContext.setAttribute("crcn", "\r\n");
	pageContext.setAttribute("br", "<br>");
	%>

	<br>
	<section id="noticeD">
		<div class="container">
			<h3>공지/이벤트 게시글</h3>
			<br>
		</div>

		<div class="container">
			<div style="border-bottom: 1px solid #444444;">
				<br> <br>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th style="text-align: left; padding-left: 50px;">제목</th>
						<th style="text-align: right; padding-right: 85px;">작성일</th>
					</tr>
					<tr>
						<td
							style="text-align: left; padding-left: 50px; font-weight: bold"><c:out
								value="${ARdetail.n_title}" /></td>
						<td style="text-align: right; padding-right: 50px;"><fmt:formatDate
								pattern="yyyy-MM-dd" value="${ARdetail.n_regdate}" /></td>
					</tr>
				</thead>
				<!-- 내용 보여줌 -->
			</table>
			<br>
			<div
				style="text-align: left; margin-left: 50px; margin-right: 50px; word-break: break-all;"
				id="content">
				<!-- <pre style = "font-size:15px; font-family:Malgun Gothic; white-space:pre-wrap;" > -->
				${fn:replace(ARdetail.n_content,crcn,br)} <br />
				<p>
					<c:set var="optionArr" value="${fn:split(ARdetail.f_svname,',')}"></c:set>
					<c:forEach begin='0' end='${fn:length(optionArr) }'
						items="${optionArr}" varStatus='status'>
						<c:if test="${ARdetail.f_svname != null}">
							<center>
								<img
									src="${pageContext.request.contextPath}/resources/assets/img/image/${optionArr[status.index]}"
									style="width: 700px; height: auto;" />
							</center>
							<br />
							<br />
						</c:if>
						<c:if test="${ARdetail.f_svname == null}">
						</c:if>
					</c:forEach>
				</p>
			</div>
			<div style="border-bottom: 1px solid #444444;">
				<br> <br>
			</div>
		</div>

		<div class="container" id="Nbtn">
			<a class="btn-book-a-table" href="/admin/notice/list.toy">목록보기</a>
		</div>
	</section>
</body>
</html>
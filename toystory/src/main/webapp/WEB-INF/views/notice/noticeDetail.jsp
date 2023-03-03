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
			<h3>공지사항</h3>
			<p>토이스토리의 공지사항을 알려드립니다.</p>
			<br>
		</div>

		<div class="container">
			<div style="border-bottom: 1px solid #444444;">
				<br>
				<br>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th style = "text-align:left; padding-left:50px;">제목</th>
						<th style = "text-align:right; padding-right:85px;">작성일</th>
					</tr>
					<tr>
						<td style = "text-align:left; padding-left:50px; font-weight:bold"><c:out value="${detail.n_title}" /></td>
						<td style = "text-align:right; padding-right:50px;" ><fmt:formatDate pattern="yyyy-MM-dd"
								value="${detail.n_regdate}" /></td>
					</tr>
				</thead>
				<!-- 내용 보여줌 -->
			</table>
			<br>
		<div style="text-align: left; margin-left: 50px; margin-right: 50px; word-break:break-all;">
				${fn:replace(detail.n_content,crcn,br)}
            <br>
            <br>
            <br>
            <c:if test="${detail.f_svname != null}">
            <center>
            <img src="${pageContext.request.contextPath}/resources/assets/img/image/${detail.f_svname}"  style="max-width: 100%; height: auto;"/>
			</center>
			</c:if>
			<c:if test="${detail.f_svname == null}">
			</c:if>
			</div>
			<div style="border-bottom: 1px solid #444444;">
				<br>
				<br>
			</div>
		</div>

		<div class="container" id="Nbtn">
			<a class="btn-book-a-table" href="/notice/list.toy">목록보기</a>
		</div>
	</section>
</body>
</html>
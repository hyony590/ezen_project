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

	<section id="noticeD">
		<div class="container">
			<h3>내가 쓴 리뷰/문의 게시글 확인</h3>
			<p>작성하신 게시글입니다.</p>
		</div>

		<div class="container">
			<div style="border-bottom: 1px solid #444444;">
				<br> <br>
			</div>
			<input type="hidden" value="${Rlist.r_num}" />

			<c:choose>
				<c:when test="${Rdetail.r_num ne null}">
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
										 <p style="margin-bottom: 30px; word-break:break-all;">
											${fn:replace(Rdetail.r_content,crcn,br)} 
										
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
														class="glightbox"> <img class = "my_img"
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
							<!-- 관리자 답변 내용-->
							<tr style="border: 1px;">
								<td colspan="2" style="height: 110px; vertical-align: middle;"><c:if
										test="${Rdetail.r_comment != null }">
										<div style="text-align: left;">
											<p style="font-weight: bold; font-size: 14.5px;">토이스토리</p>
											<p style="font-size: 14.5px;">
												<c:out value="${Rdetail.r_comment}" />
											</p>
										</div>
									</c:if> <c:if test="${Rdetail.r_comment == null }">
										<div style="text-align: left;">
											<p style="font-size: 14.5px; color: #c2c2c2">등록된 답변이
												없습니다.</p>
										</div>
									</c:if></td>
							</tr>
						</tbody>
					</table>

					<div class="container" id="Nbtn">
						<a class="btn-book-a-table"
							href="/myPage/reviewlist.toy?m_num=${sessionScope.loginNum}">목록보기</a>&nbsp;&nbsp;
						<a class="btn-book-a-table"
							href="/myPage/reviewModify.toy?r_num=${Rdetail.r_num}">수정하기</a>&nbsp;&nbsp;
						<button class="dbtn" style="border: 0"
							onclick="del(${Rdetail.r_num});">삭제하기</button>
					</div>

				</c:when>

				<c:otherwise>
					<table class="table" style="margin-bottom: 30px;">
						<thead></thead>
						<tbody>

							<tr>
								<td
									style="text-align: left; font-size: 17px; padding-left: 10px;">
									<!-- 제목 --> <a style="font-weight: bold;"> <c:out
											value="${Qdetail.q_title}" /></a>
								</td>
								<td style="text-align: right;">작성일&nbsp;&nbsp; <fmt:formatDate
										pattern="yyyy-MM-dd" value="${Qdetail.q_regdate}" /></td>
							</tr>
							<!-- 내용 보임 -->
							<tr>
								<td colspan="2" style="padding: 10px; 0 0 10px;">
									<div style="text-align: left;">
										<p style="font-size: small; color: #808080">
											<!-- 상품명 -->
											<a href="/goods/detail.toy?g_id=${Qdetail.g_id}"> <c:out
													value="${Qdetail.g_name}" /></a>
										</p>
										<p style="margin-bottom: 30px; word-break:break-all;">
											<c:out value="${Qdetail.q_content}" />
										</p>
									</div>
								</td>
							</tr>
							<!-- 관리자 답변 내용-->
							<tr style="border: 1px;">
								<td colspan="2" style="height: 110px; vertical-align: middle;"><c:if
										test="${Qdetail.q_comment != null }">
										<div style="text-align: left;">
											<p style="font-weight: bold; font-size: 14.5px;">토이스토리</p>
											<p style="font-size: 14.5px;">
												<c:out value="${Qdetail.q_comment}" />
											</p>
										</div>
									</c:if> <c:if test="${Qdetail.q_comment == null }">
										<div style="text-align: left;">
											<p style="font-size: 14.5px; color: #c2c2c2">등록된 답변이
												없습니다.</p>
										</div>
									</c:if></td>
							</tr>
						</tbody>
					</table>

					<!-- 버튼 -->
					<div class="container" id="Nbtn">
						<a class="btn-book-a-table"
							href="/myPage/reviewlist.toy?m_num=${sessionScope.loginNum}">목록보기</a>&nbsp;&nbsp;
						<button class="dbtn" style="border: 0"
							onclick="qDel(${Qdetail.q_num});">삭제하기</button>
					</div>
		   </div>
		</c:otherwise>
		</c:choose>

	</section>
</body>
<script type="text/javascript">
<!-- 리뷰 삭제 처리 -->
function del(r_num) {
   var r = r_num
   
    if (confirm("게시글을 삭제 하시겠습니까?") == true){ 
       alert("삭제 되었습니다.");
       location.href="/myPage/reviewDelete.toy?r_num=" + r;
       }else{
      location.href="/myPage/reviewdetail.toy?r_num=" + r;
          return false;
       }
    }
    
<!-- 문의 삭제 처리 -->
function qDel(q_num) {
   var q = q_num
   
    if (confirm("게시글을 삭제 하시겠습니까?") == true){ 
       alert("삭제 되었습니다.");
       location.href="/myPage/qnaDelete.toy?q_num=" + q;
       }else{
      location.href="/myPage/qnadetail.toy?q_num=" + q;
          return false;
       }
    }
</script>
</html>
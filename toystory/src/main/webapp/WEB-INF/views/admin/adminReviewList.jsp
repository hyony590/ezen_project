<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/notice.css" rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>

	<br>
	<section id="notice">
		<h3>리뷰/문의 관리</h3>
		<p>사용자가 작성한 리뷰/문의 리스트 입니다.</p>
		<br> <br> <br>
		<!-- 공지사항 목록 부분 -->
		<div class="container">
			<table class="table">
				<thead>
					<tr>
						<th>구분</th>
						<th>제목</th>
						<th>상품명</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>관리자 답변 여부</th>
					</tr>
				</thead>
				<tbody>
						<c:forEach items="${Rlist}" var="review">
						     <tr><td><c:if test = "${review.type eq 'R'}">
								<c:out value="리뷰" /></c:if>
								<c:if test = "${review.type eq 'Q'}">
								<c:out value = "문의"/></c:if>
								</td>
								<td width = "380"><c:if test="${review.type eq 'R'}">
								     <a href="/admin/review/detail.toy?r_num=${review.r_num}">
											${review.r_title}
										</a>
									</c:if> 
									<c:if test = "${review.type eq 'Q'}">
									 <a href="/admin/qna/detail.toy?q_num=${review.r_num}">
											${review.r_title}
										</a>
									</c:if></td>
								 <td><c:out value="${review.g_name}" /></td>
								<td><c:out value="${review.m_name}" /></td> 
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${review.r_regdate}" /></td>

								<td width = "150"><c:if test="${review.comment_yn eq 1}">
										<c:out value="Y" />
									</c:if> <c:if test="${review.comment_yn ne 1}">
										<c:out value="N" />
									</c:if> 
									<!-- 수정 삭제 버튼 --> 
									<!-- &nbsp&nbsp&nbsp
									<button style="border: 0;">답글달기</button></td> -->
							</tr>
						</c:forEach>
						
				</tbody>
			</table>
			
			<!-- 페이징 -->
			<div style="margin:auto; text-align:center; width:700px">
	<div class="inner">
			<ul class="pagination" style="text-align: center; justify-content: center;">
			
				<c:if test="${pageMaker2.prev }">
					<li class="paginate_button previous"><a class="page-link" href="${pageMaker2.startPage - 1 }"
						tabindex="-1" aria-disabled="true">Previous</a></li>
				</c:if>		
						
					<c:forEach var="num" begin="${pageMaker2.startPage }" end ="${pageMaker2.endPage }">
						<li class="page-item paginate_button  ${pageNum == num ? "active":""}">
							<a class="page-link" href="list.toy?pageNum=${num}">${num}</a>
						</li>
					</c:forEach>
					
				<c:if test="${pageMaker2.next }">
					<li class="paginate_button next"><a class="page-link" href="${pageMaker2.endPage + 1 }">Next</a></li>
				</c:if>	
			</ul>
	</div>
</div>
			
			
			
			<%-- <div class="inner">
         <ul class="pagination" style="text-align: center; justify-content: center;">

            <c:if test="${pageMaker2.prev}">
               <li class="paginate_button previous"><a class="page-link" 
                  href="${pageMaker2.startPage - 1 }">Previous&nbsp;&nbsp;&nbsp;</a>
               </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker2.startPage}"
               end="${pageMaker2.endPage}">
               <li class="paginate_button  ${pageNum == num ? "active":""}">
                  <a class="page-link" href="list.toy?pageNum=${num}">${num}&nbsp;&nbsp;&nbsp;</a>
               </li>
            </c:forEach>

            <c:if test="${pageMaker2.next}">
               <li class="paginate_button next"><a class="page-link"
                  href="${pageMaker2.endPage + 1 }">Next</a></li>
            </c:if>

         </ul>
      </div> --%>
		</div>
	</section>
</body>
<!-- 삭제 처리 -->
<script type="text/javascript">
	$(document).ready(function() {

		var operForm = $("#delForm");

		$("button[data-oper='delete']").on("click", function(e) {
			operForm.attr("action", "/admin/notice/delete.toy").submit();
		});
	});
</script>
</html>

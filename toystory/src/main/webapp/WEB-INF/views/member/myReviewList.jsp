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
		<h3>내가 쓴 리뷰/문의 게시글</h3>
		<p>작성하신 게시글 리스트 입니다.</p>
		<br> <br> <br>
		<!-- 공지사항 목록 부분 -->
		<div class="container">
			<table class="table">
				<thead>
					<tr>
						<th>구분</th>
						<th>제목</th>
						<th>상품명</th>
						<th>작성일</th>
						<th>관리자 답변 여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${Rlist}" var="review">
						<tr>
							<td><c:if test="${review.type eq 'R'}">
									<c:out value="리뷰" />
								</c:if> <c:if test="${review.type eq 'Q'}">
									<c:out value="문의" />
								</c:if></td>
							<td width="380"><c:if test="${review.type eq 'R'}">
									<a href="/myPage/reviewdetail.toy?r_num=${review.r_num}">
										${review.r_title} </a>
								</c:if> <c:if test="${review.type eq 'Q'}">
									<a href="/myPage/qnadetail.toy?q_num=${review.r_num}">
										${review.r_title} </a>
								</c:if></td>
							<td><c:out value="${review.g_name}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${review.r_regdate}" /></td>
							<td width="150"><c:if test="${review.comment_yn eq 1}">
									<c:out value="Y" />
								</c:if> <c:if test="${review.comment_yn ne 1}">
									<c:out value="N" />
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<nav style="margin-top: 50px;" aria-label="pagination">
            <ul class="pagination justify-content-center">
            
               <c:if test="${pageMaker.prev}">
                  <li class="paginate_button previous">
                     <a href="${pageMaker.startPage - 1 }">Previous</a>
                  </li>
               </c:if>
                  
               <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                  <li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""}">
                  <a href="reviewlist.toy?m_num=${sessionScope.loginNum}&pageNum=${num}">${num}&nbsp;&nbsp;&nbsp;</a></li>
               </c:forEach>
                  
               <c:if test="${pageMaker.next}">
                  <li class="paginate_button next">
                     <a href="${pageMaker.endPage + 1 }">Next</a>
                  </li>
               </c:if>
               
            </ul>   
         </nav>

	</section>
</body>
</html>

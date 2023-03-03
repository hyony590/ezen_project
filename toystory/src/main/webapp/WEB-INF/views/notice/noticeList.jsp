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
	<section id="notice" style="margin-bottom: 50px;">
		<h3>공지사항</h3>
		<p>토이스토리의 공지사항을 알려드립니다.</p>
		<br> <br> <br>
		<!-- 공지사항 목록 부분 -->
		<div class="container" >
			<table class="table">
				<thead>
					<tr>
						<th style = "text-align:left; padding-left:25px;">제목</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				
					<%-- <c:choose> 
       <c:when test="${noticeCount!=0}">  --%>
					<c:forEach items="${list}" var="notice">
					<input type = "hidden" value = "${notice.rownum}"/>
						<tr>
							<td style = "text-align:left; padding-left:25px;"><a
								href='./detail.toy?n_num=<c:out value="${notice.n_num}"/>'><c:out
										value="${notice.n_title}" /></a></td>
							<%-- <td><c:out value="${notice.n_count}" /></td> --%>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${notice.n_regdate}" /></td>
						</tr>
					</c:forEach>
					<%--  </c:when> --%>

					<%--   <c:otherwise> 
         <tr>
         <td colspan="4">조회된 결과가 없습니다.</td> 
      </tr>
   </c:otherwise>
   
   </c:choose>  --%>
				</tbody>
			</table>
		</div>
	<!-- 작성자 : 이효원, 남재욱 - 페이징 추가 -->
			<nav style="margin-top: 50px;" aria-label="pagination">
				<ul class="pagination justify-content-center">
				
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage - 1 }">Previous</a>
						</li>
					</c:if>
						
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button  ${pageMaker.cri.pageNum == num ? "active":""}">
						<a href="list.toy?pageNum=${num}">${num}&nbsp;&nbsp;&nbsp;</a></li>
					</c:forEach>
						
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a href="${pageMaker.endPage + 1 }">Next</a>
						</li>
					</c:if>
					
				</ul>	
			</nav>
	</section>

	<!-- <script type="text/javascript">
      $(document)
            .ready(
                  function() {

                     var result = '<c:out value="${result}"/>';

                     checkModal(result);

                     history.replaceState({}, null, null);

                     function checkModal(result) {

                        if (result === '' || history.state) {
                           return;
                        }

                        if (parseInt(result) > 0) {
                           $(".modal-body").html(
                                 "게시글 " + parseInt(result)
                                       + " 번이 등록되었습니다.");
                        }

                        $("#myModal").modal("show");
                     }

                     $("#regBtn").on("click", function() {

                        self.location = "/board/register";

                     });

                     var actionForm = $("#actionForm");

                     $(".paginate_button a").on(
                           "click",
                           function(e) {

                              e.preventDefault();

                              console.log('click');

                              actionForm
                                    .find("input[name='pageNum']")
                                    .val($(this).attr("href"));
                              actionForm.submit();
                           });

                     $(".move")
                           .on(
                                 "click",
                                 function(e) {

                                    e.preventDefault();
                                    actionForm
                                          .append("<input type='hidden' name='bno' value='"
                                                + $(this).attr(
                                                      "href")
                                                + "'>");
                                    actionForm.attr("action",
                                          "/board/get");
                                    actionForm.submit();

                                 });

                     var searchForm = $("#searchForm");

                     $("#searchForm button")
                           .on(
                                 "click",
                                 function(e) {

                                    if (!searchForm.find(
                                          "option:selected")
                                          .val()) {
                                       alert("검색종류를 선택하세요");
                                       return false;
                                    }

                                    if (!searchForm
                                          .find(
                                                "input[name='keyword']")
                                          .val()) {
                                       alert("키워드를 입력하세요");
                                       return false;
                                    }

                                    searchForm
                                          .find(
                                                "input[name='pageNum']")
                                          .val("1");
                                    e.preventDefault();

                                    searchForm.submit();

                                 });

                  });
   </script>
 -->
</body>
</html>

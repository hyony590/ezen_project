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
      <h3>공지/이벤트 게시글 관리</h3>
      <p>등록된 게시글 리스트입니다.</p>
      <br> <br> <br>
      <!-- 공지사항 목록 부분 -->
      <div class="container">
         <table class="table" id="mytab">
            <thead>
               <tr>
                  <th style = "text-align:left; padding-left:20px;">제목</th>
                  <th>작성일</th>
                  <th>관리</th>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${list}" var="notice">
               <input type = "hidden" value = "${notice.n_num}"/>
                  <tr>
                     <td style = "text-align:left; padding-left:20px;"><a
                        href='/admin/notice/detail.toy?n_num=<c:out value="${notice.n_num}"/>'><c:out
                              value="${notice.n_title}" /></a></td>
                     <%-- <td><c:out value="${notice.n_count}" /></td> --%>
                     <td><fmt:formatDate pattern="yyyy-MM-dd"
                           value="${notice.n_regdate}" /></td>

                     <!-- 수정 삭제 버튼 -->
                     <td>
                        <button class="NLB" style="border: 0;"
                           onclick="location.href='/admin/notice/modify.toy?n_num=<c:out value="${notice.n_num}"/>'">수정</button>/
                        <input type='hidden' id='n_num' name='n_num'
                        value="${notice.n_num}" />
                        <button class="NLB" style="border: 0"
                           onclick="del(${notice.n_num});">삭제</button>
                     </td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
      </div>

      <div class="container" id="ANbtn">
         <a class="btn-book-a-table" href="/admin/notice/register.toy">글쓰기</a>
      </div>
   <!-- 작성자 : 이효원, 남재욱 - 12.15 페이징 -->
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
   
   
</body>

<!-- 삭제 처리 -->
<script type="text/javascript">
function del(n_num) {
   var n = n_num
   
    if (confirm("게시글을 삭제 하시겠습니까?") == true){ 
       alert("삭제 되었습니다.");
       location.href="/admin/notice/delete.toy?n_num="+n;
       }else{
      location.href="/admin/notice/list.toy";
          return false;
       }
    }
</script>
</html>
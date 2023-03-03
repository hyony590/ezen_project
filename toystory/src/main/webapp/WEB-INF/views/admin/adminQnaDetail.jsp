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
   <section id="noticeD">
      <div class="container">
         <h3>문의 게시글</h3>
         <p>게시글입니다</p>
         <br>
      </div>

      <div class="container">
         <form id="register" role="form"
            action="/admin/qna/commentRegister.toy" method="post">
            <input type='hidden' id='q_num' name='q_num'
               value="${Qdetail.q_num}" />
               <input type = "hidden" value = "${Qdetail.g_id}"/>
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
               </tbody>
            </table>

            <!-- 관리자 답변 작성 -->
            <div>
               <textarea
                  style="border-radius: 10px; resize: none; margin-bottom: 10px; width: 100%"
                  rows="8" cols="182" id="q_comment" name="q_comment"
                  placeholder="답변 작성"><c:out value="${Qdetail.q_comment}" /></textarea>

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
   $(document).ready(function() {
      $('#list').on('click', function() {
         self.location = "/admin/review/list.toy"
      });

      var operForm = $("#register");
      $("button[data-oper='register']").on("click", function(e) {
         operForm.attr("action", "/admin/qna/commentRegister.toy").submit();
      });
   });
</script>


</html>
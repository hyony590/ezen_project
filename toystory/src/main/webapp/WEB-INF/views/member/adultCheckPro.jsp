<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<link href="/resources/assets/css/member.css" rel="stylesheet">
<script type="text/javascript" src="/resources/assets/js/member.js"></script>

<meta charset="UTF-8">
<title>성인인증</title>
</head>
<body>

   <br>
   <br>
   <br>
   <br>
   <br>
   <section class="join-form">

      <div style="text-align: center">
         <c:if test="${adultCheck eq -1}">
            <div style="padding: 20px;">
               <h3>성인이 아닙니다.</h3>
               <br> <br>
            </div>
            <button type="button" class="btn btn-login align-center" id="goMain">메인으로</button>

         </c:if>

         <c:if test="${adultCheck eq 0}">
            <div style="padding: 20px;">
               <h3 style="font-weight: bold;">성인인증이 완료되었습니다.</h3>
               <% session.setAttribute("loginAdult", "Y"); 
                  session.setMaxInactiveInterval(20*60);%><!-- (12.08)비회원 세션 만료 20분 설정 -->
               <% session.setAttribute("searchAdult", "searchAdultCheck"); %><!-- 현재 검색 창으로 redirect 시키기 위한 세션 -->
               <br> <br>
            </div>
            <button type="button" class="btn btn-login align-center" onclick="location.href='/goods/list.toy?g_category=5&pageNum=1'">상품<!-- 12.8 추가 -->
               보러가기</button>
         </c:if>

         <c:if test="${adultCheck eq 1}">
            <div style="padding: 20px;">
               <h3>
                  성인인증이 완료되었습니다.<br> 앞으로 성인인증 없이 접근이 가능합니다.
                  
               </h3>
               <% session.setAttribute("loginAdult", "Y"); %> <!-- (12.08)회원 성인 인증 시, 세션 값 Y로 변경 -->
               <% session.setAttribute("searchAdult", "searchAdultCheck"); %><!-- 현재 검색 창으로 redirect 시키기 위한 세션 -->
               <br>
            </div>
            <button type="button" class="btn btn-login" onclick="location.href='/goods/list.toy?g_category=5&pageNum=1'">상품 보러가기</button><!-- 12.8 추가 -->

         </c:if>

         <c:if test="${adultCheck eq -100}">
            <div style="padding: 20px;">
               <h3>
                  알 수 없는 오류가 발생하였습니다.<br> 오류코드 : ${adultCheck }
               </h3>
               <br>
               <button type="button" class="btn btn-login" id="goMain">메인으로</button>
            </div>
         </c:if>

         <c:if test="${adultCheck eq -200}">
            <div style="padding: 20px;">
               <h3>
                  알 수 없는 오류가 발생하였습니다. <br> 오류코드 : ${adultCheck }
               </h3>
               <br>
               <button type="button" class="btn btn-login" id="goMain">메인으로</button>
            </div>
         </c:if>
      </div>
   </section>

   <br>
   <br>
   <br>
   <br>
   <br>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/includes/include-header.jspf"%>
<script src = "//code.jquery.com/jquery-1.11.0.min.js"></script>
<html lang="en">
<title>토이스토리 관리자 페이지</title>
<meta content="" name="description">
<meta content="" name="keywords">
<body>
   <header id="header" class="header fixed-top d-flex align-items-center">
      <div
         class="container d-flex align-items-center justify-content-between">
   
         <!-- ======= 로그인 메뉴 ======= -->
      <div class="parent">
         <div class="loginArea">
         <c:if test="${empty sessionScope.loginId }">
               <a href="/login/login.toy">로그인</a>&nbsp
            &nbsp&nbsp&nbsp<a href="/join/join.toy">회원가입</a>
            </c:if>

            <c:if test="${!empty sessionScope.loginId }">
               <a href="/login/logout.toy">로그아웃</a>&nbsp
            &nbsp&nbsp&nbsp <c:out value="${sessionScope.loginName }" /> 님 환영합니다.
             &nbsp;&nbsp;&nbsp;
            </c:if>
         </div>
         
         
         <!-- ======= 토이스토리 로고 ======= -->
         <div class="first">
            <a
               class="logo d-flex align-items-center me-auto me-lg-0"> <img style="cursor:pointer;"
               src="/resources/assets/img/logo2.png" alt="Toy Story" id = "btn">
            </a>
         </div>
         <!-- 로고 끝-->



         <!-- ======= 카테고리 ======= -->
         <div class="second2">
         <div id="navbar" class="navbar">
            <ul>
               <li><a href="/admin/memberList.toy">회원관리</a></li>
               <li><a href="/admin/goodslist.toy">상품관리</a></li>
               <li><a href="/admin/orderlist.toy">주문관리</a></li>
               <li class="dropdown"><a href=""><span>게시판관리</span> <i
                     class="bi bi-chevron-down dropdown-indicator"></i></a>
                  <ul>
                     <li><a href="/admin/notice/list.toy">공지/이벤트 관리</a></li>
                     <li><a href="/admin/review/list.toy">리뷰/문의 관리</a></li>
                  </ul></li>
               <!-- <li><a href="#adult">메인페이지관리</a></li> -->
            </ul>
         </div>
         </div>
         <!-- .navbar -->


            <!-- ======= 통합검색창 ======= -->
            <div class="third">
            <div class="Hsearch">
               <!-- <input type="text" placeholder="&nbsp&nbsp연말 선물 DIY 키트 구경하기"
                  style="border: 0; border-bottom: 1px solid #e6e6e6;">
               <button type="button" id="img_btn">
                  <img
                     src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
               </button> -->
            </div>
         </div>
      </div>
      <!-- 카테고리 반응형 적용 -->
      <i class="mobile-nav-toggle mobile-nav-show bi bi-list"></i> <i
         class="mobile-nav-toggle mobile-nav-hide d-none bi bi-x"></i>
      </div>

   </header>
   <!-- End Header -->
<script>
$(function() {
   $("#btn").dblclick(function(){
      window.location='http://localhost:9000';
   })
   $("#btn").click(function(){
      window.location='/admin_main.toy';
   })
});

</script>
</body>
</html>
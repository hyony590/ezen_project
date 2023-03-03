<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/includes/include-header.jspf"%>

<script type="text/javascript" src="/resources/assets/js/header.js"></script>
<script src = "//code.jquery.com/jquery-1.11.0.min.js"></script>
<link href="/resources/assets/css/update.css" rel="stylesheet">

<title>모두를 위한 토이샵, 토이스토리</title>
<meta content="" name="description">
<meta content="" name="keywords">
</head>
<body>
   <header id="header" class="header fixed-top d-flex align-items-center">
      <div
         class="container d-flex align-items-center justify-content-between">

         <!-- ======= 로그인 메뉴 ======= -->
      <div class="parent">
         <div class="loginArea">
            <c:if test="${empty sessionScope.loginId }">
               <a href="/login/login.toy">로그인</a>
            &nbsp&nbsp&nbsp<a href="/join/join.toy">회원가입</a>
            </c:if>

            <c:if test="${!empty sessionScope.loginId }">
               <a href="/login/logout.toy">로그아웃</a>
            &nbsp&nbsp&nbsp <c:out value="${sessionScope.loginName }" /> 님 환영합니다.
            &nbsp&nbsp&nbsp<a href="/myPage/main.toy">마이페이지</a>
            &nbsp&nbsp&nbsp<a href="/basket/list.toy">장바구니</a>
            <br>
            
            </c:if>
         </div>

         <!-- ======= 토이스토리 로고 ======= -->
         <c:if test="${sessionScope.loginRank ne 'A' }">
         <div class="first">
            <a href="http://localhost:9000"
               class="logo d-flex align-items-center me-auto me-lg-0"> <img
               src="/resources/assets/img/logo2.png" alt="Toy Story">
            </a>
         </div>
         </c:if>
         <c:if test="${sessionScope.loginRank eq 'A' }">
         <div class="first" >
         <a 
            class="logo d-flex align-items-center me-auto me-lg-0"> <img id = "btn"
            src="/resources/assets/img/logo2.png" alt="Toy Story" style="cursor:pointer;">
         </a>
         </div>
         </c:if>
         <!-- 로고 끝-->



         <!-- ======= 카테고리 ======= -->
         <div class="second">
            <div id="navbar" class="navbar">

               <ul>
                  <li><a href="/goods/list.toy?g_category=1&pageNum=1">캐릭터/피규어</a></li>
                  <li><a href="/goods/list.toy?g_category=2&pageNum=1">창작DIY</a></li>
                  <li><a href="/goods/list.toy?g_category=3&pageNum=1">보드게임</a></li>
                  <li><a href="/goods/list.toy?g_category=4&pageNum=1">문구/팬시</a></li>
                  <li><a href="/goods/list.toy?g_category=5&pageNum=1">설렘토이</a></li>
                  <li><a href="/notice/list.toy?pageNum=1">공지사항</a></li>
               </ul>
            </div>
         </div>
         <!-- .navbar -->



         <!-- ======= 통합검색창 ======= -->
         <!-- 작성자 : 이효원, 남재욱 - 12.12 검색기능 위해 변경 -->
         <div class="third">
         <div class="Hsearch">
            <form id="searchList" action="/goods/search.toy" method="get" style="margin-top: -13%; margin-right: -20%;">
               <input type="text" name="keyword"
                  placeholder="&nbsp&nbsp연말 선물 DIY 키트 구경하기"
                  style="border: 0; border-bottom: 1px solid #e6e6e6;">
               <button type="submit">
                  <img
                     src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png">
               </button>
            </form>
         </div>
</div>

         <!-- <div class="container" style="font-size:small; text-align:right;">
         
            <a href="/loginForm.toy">로그인</a>&nbsp
            &nbsp&nbsp&nbsp<a href="/join/join.toy">회원가입</a>
            &nbsp&nbsp&nbsp<a href="https://monthlytoy.co.kr">마이페이지</a>
            &nbsp&nbsp&nbsp<a href="https://monthlytoy.co.kr">장바구니</a> -->
            
         
         
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
      window.location='/admin_main.toy';
   })
   $("#btn").click(function(){
      window.location='http://localhost:9000';
   })
});
</script>
</body>
</html>
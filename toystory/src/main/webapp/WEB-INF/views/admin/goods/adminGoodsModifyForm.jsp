<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/notice.css" rel="stylesheet">
<meta charset="UTF-8">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script defer type="text/javascript" src="/resources/assets/js/goodsModify.js"></script>
<title>관리자 수정 페이지</title>
</head>
<body>

<section id="noticeF">
   <div class="container">
      <h3>상품 수정하기</h3>
   </div>
   
   <div class="container" style="text-align: left; width: 700px">
      <form action="/admin/goodsmodifypro.toy" method="post" encType="multipart/form-data">
            <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">상품번호</p>
               <input class="form-control" name="g_id" type="text" value="${modify.g_id}" readonly>
         </div>
            <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">등록일</p>
               <input class="form-control" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${modify.g_date }"/>' readonly>
         </div>
         <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">카테고리</p>
               <select name="g_category" >
                       <option value="${modify.g_category}" hidden="hidden">
                            <c:if test="${modify.g_category eq '1'}">캐릭터/피규어</c:if>
                           <c:if test="${modify.g_category eq '2'}">창작DIY</c:if>
                           <c:if test="${modify.g_category eq '3'}">보드게임</c:if>
                           <c:if test="${modify.g_category eq '4'}">문구/팬시</c:if>
                           <c:if test="${modify.g_category eq '5'}">설렘토이</c:if>
                       </option>
                        <option value="1">캐릭터/피규어</option>
                        <option value="2">창작DIY</option>
                        <option value="3">보드게임</option>
                        <option value="4">문구/팬시</option>
                        <option value="5">설렘토이</option>
                     </select>
         </div>
         <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">브랜드명</p>
               <input class="form-control" type="text" name="g_brand" id="g_brand" value="${modify.g_brand}">
         </div>
         <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">상품명</p>
               <input class="form-control" type="text" name="g_name" id="g_name" value="${modify.g_name}">
         </div>
         <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">상품 옵션</p>
               <input class="form-control" type="text" name="g_option" id="g_option" value="${modify.g_option}">
         </div>
         <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">가격</p>
               <input class="form-control" type="text" name="g_price" id="g_price" value="${modify.g_price}">
         </div>
         <div class="form-group" style="margin-bottom: 30px;">
               <p style="font-weight: bold;">재고</p>
               <input class="form-control" type="text" name="g_stock" id="g_stock" value="${modify.g_stock}">
         </div>
         <div class="form-group" style="margin-bottom: 50px;">
               <p style="font-weight: bold;">할인율</p>
               <input class="form-control" type="text" name="g_sale" id="g_sale" value="${modify.g_sale}">
         </div>
         
         
         <div class="form-group" style="margin-bottom: 30px;">
         <hr>
         <p style="font-weight: bold; font-size: 20px">상품 메인이미지</p>
            <c:forEach items="${imageList }" var="imageList">
            <c:if test="${imageList.f_main_yn eq 'Y' }">
            <div style="text-align: center;">
               <img src="${pageContext.request.contextPath}/resources/assets/img/image/${imageList.f_svname}" 
               style="width: 90%; height: auto;" />
               <br /> <br />
            </div>
            </c:if>
            </c:forEach>
        </div>
        
        <div class="form-group" style="margin-bottom: 20px;">
         <p style="font-weight: bold;">상품 메인이미지 파일 변경</p>
            <input type="file" name="mainImage">
        </div>
      	<br/>
        
         <div style="margin-bottom: 20px;">
            <hr>
               <p style="font-weight: bold; font-size: 20px">상품 상세이미지(삭제할 이미지를 체크해주세요)</p>
               <c:forEach  items="${imageList}" var="imageList" varStatus='status'>
                  <c:if test="${imageList.f_main_yn eq 'N' }">
                        <div style="text-align: center;">
                           <img
                              src="${pageContext.request.contextPath}/resources/assets/img/image/${imageList.f_svname}"
                              style="width: 90%; height: auto;" />&nbsp;&nbsp;&nbsp; 
                              <input id="input1" class="check" type="checkbox" name="item" value="${imageList.f_num}"><br/><br/>
                        </div>
                        </c:if>
                     </c:forEach> 
 
                     <div id="fileDiv"
                        style="text-align: left; margin-top: 20px; margin-left: 20px;">
                        <p style="font-weight: bold;">상품 상세이미지 파일 추가</p>
                        <span><input type="file" id="file" name="file_0">
                           <a href="#this" class="btn" id="delete" name="delete"
                           style="font-size: 13px;">삭제</a> <a href="#this" class="btn"
                           id="addFile" style="font-size: 13px;">파일 추가</a></span>
                     </div> 
               
            </div>

            <div style="margin-top: 40px; text-align: center;">
               <button type="submit" class="btn-book-a-table"
                  style="border: 0; margin-right: 10px;" id="modifyButton">수정</button>
               <button type="button" data-oper='list' id="list"
                  class="btn-book-a-table" style="border: 0">취소</button>
            </div>
      </form>
   </div>
</section>
</body>


</html>
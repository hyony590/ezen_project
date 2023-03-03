<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/goods.css" rel="stylesheet">
<meta charset="UTF-8">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script defer type="text/javascript" src="/resources/assets/js/goodsRegister.js"></script>
<title>관리자 상품 등록 페이지</title>
</head>

<body>

	<section id="goodsF">
		<div class="container">
			<h3>상품 등록하기</h3>
		</div>

		<div class="container" style="text-align: left; width: 700px">
			<form action="/admin/goodsregisterpro.toy" method="post"
				encType="multipart/form-data">
				<div class="form-group" style="margin-bottom: 30px;">
					<p style="font-weight: bold;">상품번호</p>
					<c:forEach items="${id}" var="goods" varStatus="index">
					<c:if test="${index.last}">
					<input type="text" value="<c:out value="${goods.g_id +1}" />" readonly>
					</c:if>
					</c:forEach>
				</div>
				
				<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">등록일</p>
                  <input type="text" value="<c:out value="${now}" />" readonly>
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">카테고리</p>
               		<select name="g_category" id="g_category">
               					<option value="">카테고리를 선택하세요</option>
								<option value="1">캐릭터/피규어</option>
								<option value="2">창작DIY</option>
								<option value="3">보드게임</option>
								<option value="4">문구/팬시</option>
								<option value="5">설렘토이</option>
						</select>
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">브랜드명</p>
               		<input type="text" name="g_brand" id="g_brand">
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">상품명</p>
               		<input type="text" name="g_name" id="g_name">
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">상품옵션</p>
               		<input type="text" name="g_option" id="g_option">
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">가격</p>
               		<input type="text" name="g_price" id="g_price">
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">재고</p>
               		<input type="text" name="g_stock" id="g_stock">
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">할인율</p>
               		<input type="text" name="g_sale" id="g_sale" value="0">
            	</div>
            	
            	<div class="form-group" style="margin-bottom: 30px;">
                  <p style="font-weight: bold;">상품 메인 이미지</p>
               		<input type="file" name="mainImage" id="mainImage">
            	</div>
            	
            	<div id="fileDiv" style="text-align: left;">
            	<p>상품 이미지</p>
                  	<span><input type="file" id="file" name="file_0">
                  	<a href="#this" class="btn" id="delete" name="delete">삭제</a>
            		<a href="#this" class="btn" id="addFile">파일 추가</a></span>
         </div>
         
			<div style="margin-top: 100px; text-align: center;">
				<button type="submit" class="btn" id="registerButton">등록</button>
				<button type="reset" class="btn" onclick="location.href='goodslist.toy'">취소</button>
			</div>
			</form>
		</div>
	</section>
</body>

</html>
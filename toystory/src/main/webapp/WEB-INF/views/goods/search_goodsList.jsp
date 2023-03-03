<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


    
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/update.css" rel="stylesheet">
<meta charset="UTF-8">

<script>
	
	
	
	$(document).ready(function(){
		
		var table = document.getElementById('ca4');
		var totalRowCnt = $('ca4[p]').length;
		alert(totalRowCnt);
		
		let inner = "";
		inner += '<p>게시글이 없습니다</p>';
		
		if(totalRowCnt == 0){
			$('#ca4').html(inner);
		}
		
	})


</script>
</head>
<body>
	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<div class="container">
		<div class="row gy-5">
			<div class="col">
				<div style="float: left">total <c:out value="${fn:length(list) }"/> Items</div>
				<div style="float: right">
					<a href="">[인기도순]</a> 
					<a href="">[낮은가격순]</a> 
					<a href="">[높은가격순]</a>
					<a href="">[최신등록순]</a>
				</div>
			</div>
		</div>
		<div class="row gy-5">
			<div class="col">
				<hr>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	
	
	
	<div align="center">피규어/카테고리</div>
	<div class="container">
		<div class="row gy-5">
			<c:forEach items="${list }" var="goods">
				<c:if test="${goods.g_category eq 1 }">
					<div class="col-lg-3 menu-item">
					
						
					
						<p><c:out value='${goods.g_id}'/></p>
						<p><c:out value="${goods.g_name}" /></p>
						<p><c:out value="${goods.g_price }"/></p>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	
	<div align="center">창작diy</div>
	<div class="container">
		<div class="row gy-5">
			<c:forEach items="${list }" var="goods">
				<c:if test="${goods.g_category eq 2 }">
					<div class="col-lg-3 menu-item">
						<p><c:out value='${goods.g_id}'/></p>
						<p><c:out value="${goods.g_name}" /></p>
						<p><c:out value="${goods.g_price }"/></p>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	
	<div align="center">보드게임</div>
	<div class="container">
		<div class="row gy-5">
			<c:forEach items="${list }" var="goods">
				<c:if test="${goods.g_category eq 3 }">
					<div class="col-lg-3 menu-item">
						<p><c:out value='${goods.g_id}'/></p>
						<p><c:out value="${goods.g_name}" /></p>
						<p><c:out value="${goods.g_price }"/></p>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<div align="center">문구/팬시</div>
	<div class="container">
		<div class="row gy-5">
			<c:forEach items="${list }" var="goods">
					<div class="col-lg-3 menu-item" id="ca4">
				<c:if test="${goods.g_category eq 4 }">
						<p><c:out value='${goods.g_id}'/></p>
						<p><c:out value="${goods.g_name}" /></p>
						<p><c:out value="${goods.g_price }"/></p>
				</c:if>
					</div>
			</c:forEach>
		</div>
	</div>
	
	<div align="center">설렘토이</div>
	<div class="container">
		<div class="row gy-5">
			<c:forEach items="${list }" var="goods">
					<div class="col-lg-3 menu-item" id="ca5">
				<c:if test="${goods.g_category eq 5 }">
						<p><c:out value='${goods.g_id}'/></p>
						<p><c:out value="${goods.g_name}" /></p>
						<p><c:out value="${goods.g_price }"/></p>
				</c:if>
					</div>
			</c:forEach>
		</div>
	</div>
	
	<br />
	<br /><br />
	<br /><br />
	<br /><br />
	<br /><br />
	<br /><br />
	<br /><br />
	<br /><br />
	<br /><br />



<!-- 페이징 작업할 부분 -->
<div class="outer">
	<div class="inner">
		<nav aria-label="pagination">
			<ul class="pagination">
				<li class="page-item disabled"><a class="page-link" href=""
					tabindex="-1" aria-disabled="true">Previous</a></li>
				<li class="page-item"><a class="page-link" href="">1</a></li>
				<li class="page-item active" aria-current="page"><a
					class="page-link" href="">2</a></li>
				<li class="page-item"><a class="page-link" href="">3</a></li>
				<li class="page-item"><a class="page-link" href="">Next</a></li>
			</ul>
		</nav>
	</div>
</div>


	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>





</body>
</html>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


    
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/goods.css" rel="stylesheet">
<link href="/resources/assets/css/update.css" rel="stylesheet">
<meta charset="UTF-8">
</head>
<body>

<script type="text/javascript">

function sort(sortNum){
	
	var sortCom = sortNum;
	var sortType;
	
	if(sortCom==1){
		sortType = "best";			
	}else if(sortCom==2){
		sortType = "lowPrice";
	}else if(sortCom==3){
		sortType = "highPrice";	
	}else{
		sortType = "new";
	}
	sessionStorage.setItem("sort",sortType);
	location.href="list.toy?g_category=${category}&pageNum=1&sort="+sortType;
}

function callSort(){
	if(sessionStorage.getItem("sort")!=null){
		return "&sort="+sessionStorage.getItem("sort");
	}
	return '';
}

</script>
	
	
	<div class="container" style="margin-top:290px; margin-bottom: 140px;">
	
      <div class="row gy-5">
       
      <div class="container">
		<div class="row gy-5">
			<div class="col">
				<div style="float: left; font-size: 14.5px;">
				&nbsp;&nbsp;TOTAL&nbsp;
				<strong><c:out value="${pageMaker.total}"/></strong>&nbsp;&nbsp;ITEMS
				</div>
			<div style="float: right; font-size: 14.5px;">
					<a href="#" onclick="sort(1)">인기도순&nbsp;|&nbsp;</a>
					<a href="#" onclick="sort(2)"> 낮은가격순&nbsp;|&nbsp;</a>
					<a href="#" onclick="sort(3)"> 높은가격순&nbsp;|&nbsp;</a>
					<a href="#" onclick="sort(4)"> 최신등록순&nbsp;&nbsp;</a>
				</div>
				</div>
		</div>
		<div class="row gy-5">
			<div class="col" style="margin-top: 40px;">
				<hr>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
      
         <c:forEach begin="0" end="${fn:length(list)}" items="${list}"
            var="goods">
            <div class="col-lg-3 menu-item">
               <form id='goodsDetail' action='/goods/goodsDetail' method='get'>
                  <a href="/goods/detail.toy?g_id=${goods.g_id}">
                 <img
                     src="${pageContext.request.contextPath}/resources/assets/img/image/${goods.f_svname }" class="radius_img"
                     alt="" style='width: 300px; height: 300px'> <input
                     type='hidden' name='g_id' value="<c:out value='${goods.g_id}'/>">  </a> <br />
               </form>
               <span style="font-size: 17px; font-weight: bold; margin-left: 5px; margin-top: 5px;">
                  <c:out value="${goods.g_name}" />
               </span>
               
               <!-- 세일 중 -->
               <c:if test="${goods.g_sale ne 0}">     
		            	<c:if test="${(goods.g_price * (100-goods.g_sale)) / 100 lt 1}">
		            	<p style="color: #9b55d4; margin-left: 5px; margin-top:5px; font-weight: bold; margin-bottom: 0px;">
		            		<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * (100-goods.g_sale)) / 100 +1}" />&nbsp;
		            		</p>
		            	</c:if>
		            	<c:if test="${(goods.g_price * (100-goods.g_sale)) / 100 gt 1}">
		            	<p style="color: #9b55d4; margin-left: 5px; font-weight: bold; margin-bottom: 0px;">
		            		<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * (100-goods.g_sale)) / 100}" />&nbsp;₩
		            	<span style="color: #9b55d4; font-size: 12px;">
		            	(${goods.g_sale}%)&nbsp;&nbsp;
		            	</span>
		            	</p>
		            	</c:if>
		            	<p style="text-decoration: line-through; margin-left: 5px; margin-top: 5px; color: #c2c2c2;">${goods.g_price } ₩</p>
		      </c:if>

               <!-- 세일 안함-->
		            <c:if test="${goods.g_sale eq 0}">
		            <p style="color: #9b55d4; margin-left: 5px; margin-top:5px; font-weight: bold;">
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${goods.g_price}" />&nbsp;₩
            		</p>
		            </c:if>
            </div>
         </c:forEach>
      
	<br>
	<br>
	<br>
      </div>
   </div>
	
	<!-- 12.15 페이징 -->
         <nav aria-label="pagination" style="height: 100px;">
			<ul class="pagination" style="text-align: center; justify-content: center;">
				
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a type="button" class="page-link" onclick="location.href='list.toy?g_category=${category}&pageNum=${pageMaker.startPage - 1 }'+callSort()">이전</a>
						</li>
					</c:if>
						
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="page-item paginate_button  ${pageMaker.cri.pageNum == num ? 'active':''}">
							<a type="button" class="page-link" onclick="location.href='list.toy?g_category=${category}&pageNum=${num}'+callSort()">${num}</a>
						</li>
					</c:forEach>
						
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next">
							<a type="button" class="page-link" onclick="location.href='list.toy?g_category=${category}&pageNum=${pageMaker.endPage + 1 }'+callSort()">다음</a>
						</li>
					</c:if>
					
				</ul>	
</nav>


	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>





</body>
</html>



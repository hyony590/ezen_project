<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


    
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/goods.css" rel="stylesheet">
<meta charset="UTF-8">
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

    <div class="container" style="margin-top:100px">
	
      <div class="row gy-5">
       
      <div class="container">
		<div class="row gy-5">
			<div class="col">
				<div style="float: left">total <c:out value="${pageMaker.total}"/> Items </div>
			</div>
		</div>
		<div class="row gy-5">
			<div class="col">
				<hr>
			</div>
		</div>
	</div>

   <br/>
   <br/>
   <br/>
	
	<div class="container">
    	<div class="row gy-5">
    	<h3>"${key}"(으)로 검색한 결과 : </h3>
      		<c:forEach begin="0" end="${fn:length(arr)}" items="${arr}" var="goods">
		         <div class="col-lg-3 menu-item">
		            <form id='goodsDetail' action='/goods/goodsDetail' method='get'>
		                 <a href="/goods/detail.toy?g_id=${goods.g_id}"><img
		                     src="${pageContext.request.contextPath}/resources/assets/img/image/${goods.f_svname }" class="radius_img"
		                     alt="" style='width: 300px; height: 300px'> <input
		                     type='hidden' name='g_id' value="<c:out value='${goods.g_id}'/>">  </a> <br />
		            </form>
		            <p>
		            <c:out value="${goods.g_name}" /></p>
		            <c:if test="${goods.g_sale ne 0}">     
		            	<p>
		            	${goods.g_sale}%&nbsp;&nbsp;<span style="text-decoration: line-through;">${goods.g_price }</span>
		            	</p>
		            	<c:if test="${(goods.g_price * goods.g_sale) / 100 lt 1}">
		            		<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * (100-goods.g_sale)) / 100 +1}" />₩
		            	</c:if>
		            	<c:if test="${(goods.g_price * goods.g_sale) / 100 gt 1}">
		            		<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * (100-goods.g_sale)) / 100}" />₩
		            	</c:if>
		            </c:if>
		            <c:if test="${goods.g_sale eq 0}">
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${goods.g_price}" />₩
		            </c:if>
		            
		         </div>
			</c:forEach>
		</div>
	</div> 
</div></div>
	<br />
	<br />


	<!-- 12.15 페이징 -->
	<nav aria-label="pagination">
            <ul class="pagination justify-content-center">
            
               <c:if test="${pageMaker.prev}">
                  <li class="paginate_button previous">
                     <a type="button" class="page-link" onclick="location.href='searchmore.toy?g_category=${category}&pageNum=${pageMaker.startPage - 1 }&keyword=${key}'">이전</a>
                  </li>
               </c:if>
                  
               <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                  <li class="paginate_button  ${pageMaker.cri.pageNum == num ? 'active':''}">
                     <a type="button" class="page-link" onclick="location.href='searchmore.toy?g_category=${category}&pageNum=${num}&keyword=${key}'">${num}</a>
                  </li>
               </c:forEach>
                  
               <c:if test="${pageMaker.next}">
                  <li class="paginate_button next">
                     <a type="button" class="page-link" onclick="location.href='searchmore.toy?g_category=${category}&pageNum=${pageMaker.endPage + 1 }&keyword=${key}'">다음</a>
                  </li>
               </c:if>
               
            </ul>   
         </nav>



	<a href="#"
		class="scroll-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>





</body>
</html>



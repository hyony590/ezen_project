<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link href="/resources/assets/css/goods.css" rel="stylesheet">
<meta charset="UTF-8">
   
<body>
   <div class="container" style="margin-top:350px; margin-bottom: 100px;">
	
      <div class="row gy-5">
       
      <div class="container">
		<div class="row gy-5">
			<div class="col">
			<div style="float: left; font-size: 14.5px;">
				&nbsp;&nbsp;TOTAL&nbsp;
				<strong><c:out value="${cateSize}"/></strong>&nbsp;&nbsp;ITEMS
				</div>
			
			
				<%-- <div style="float: left">total <c:out value="${cateSize}"/> Items </div> --%>
			</div>
		</div>
				<hr>
		</div>
	</div>

   <br/>
   <br/>
   <br/>
   
<div class="container">
    <div class="row gy-5">
    
    
    
<h4 style="font-weight: bold;">캐릭터/피규어</h4>
<c:choose>
	<c:when test="${cate1 ne 0}">
		<c:forEach begin="0" end="3" items="${keyword1}" var="goods">
            <div class="col-lg-3 menu-item">
               <form id='goodsDetail' action='/goods/goodsDetail' method='get'>
						<a href="/goods/detail.toy?g_id=${goods.g_id}"><img
							src="${pageContext.request.contextPath}/resources/assets/img/image/${goods.f_svname }" class="radius_img"
							alt="" style='width: 300px; height: 300px'> <input
							type='hidden' name='g_id' value="<c:out value='${goods.g_id}'/>">  </a> <br />
					</form>
                  <p style="font-weight: bold;"><c:out value="${goods.g_name}" /></p>
                  
               <c:if test="${goods.g_sale ne 0}">     
		            	<c:if test="${(goods.g_price * goods.g_sale) / 100 lt 1}">
		            	<p>
		            	${goods.g_sale}%&nbsp;&nbsp;
		            	</p>
		            	<p style="color: #9b55d4; font-weight: bold; margin-bottom: 0px;">
		            		<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * (100-goods.g_sale)) / 100 +1}" />₩
		            	</p>
		            	</c:if>
		            	
		            	<p style="color: #9b55d4; font-weight: bold; margin-bottom: 0px;">
		            	<c:if test="${(goods.g_price * goods.g_sale) / 100 gt 1}">
		            		<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * (100-goods.g_sale)) / 100}" />₩
		            	</c:if>
		            	</p>
		            <p style="text-decoration: line-through; color: #c2c2c2;">${goods.g_price } ₩</p>
		            </c:if>
		            
		            <c:if test="${goods.g_sale eq 0}">
		            <p style="color: #9b55d4; font-weight: bold; margin-bottom: 0px;">
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${goods.g_price}" />₩
		            	</p>
		            </c:if>
		            
               </div>
			</c:forEach>
				<c:if test="${cate1 gt 3}">
					<form id="searchMore" action="/goods/searchmore.toy" method="get">
						<input type="hidden" name="g_category" value="1">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="keyword" value="${keyword}">
						<button type="submit" class="btn">더보기</button>
					</form>
					<%-- <a href="searchmore.toy?g_category=1&pageNum=1&keyword=${key}">더보기</a> --%>
					
				</c:if>
	</c:when>	
    <c:otherwise>
    <div class="container">
        상품이 존재하지 않습니다.
     </div>
     </c:otherwise>
	</c:choose>
<hr>
<br/>
<br/>
      

<h4 style="font-weight: bold;">창작 DIY</h4>
   <c:choose>
	<c:when test="${cate2 ne 0}">
		<c:forEach begin="0" end="3" items="${keyword2}" var="goods">
            <div class="col-lg-3 menu-item" id = "#goDiy">
               <form id='goodsDetail' action='/goods/goodsDetail' method='get'>
						<a href="/goods/detail.toy?g_id=${goods.g_id}"><img
							src="${pageContext.request.contextPath}/resources/assets/img/image/${goods.f_svname }" class="radius_img"
							alt="" style='width: 300px; height: 300px'> <input
							type='hidden' name='g_id' value="<c:out value='${goods.g_id}'/>">  </a> <br />
					</form>
                  <p><c:out value="${goods.g_name}" /></p>
               <c:if test="${goods.g_sale ne 0}">     
		            	<p>
		            	${goods.g_sale}%&nbsp;&nbsp;<span style="text-decoration: line-through;">${goods.g_price }</span>
		            	</p>
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * goods.g_sale) / 100}" />₩
		            </c:if>
		            <c:if test="${goods.g_sale eq 0}">
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${goods.g_price}" />₩
		            </c:if>
               </div>
			</c:forEach>
				<c:if test="${cate2 gt 3}">
					<form id="searchMore" action="/goods/searchmore.toy" method="get">
						<input type="hidden" name="g_category" value="2">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="keyword" value="${keyword}">
						<button type="submit" class="btn">더보기</button>
					</form>
				</c:if>
	</c:when>	
    <c:otherwise>
         <div class="container">
        상품이 존재하지 않습니다.
     </div>

     </c:otherwise>
	</c:choose>
<hr>     
<br/>
<br/>

<h4 style="font-weight: bold;">보드게임</h4>
    <c:choose>
	<c:when test="${cate3 ne 0}">
		<c:forEach begin="0" end="3" items="${keyword3}" var="goods">
            <div class="col-lg-3 menu-item">
               <form id='goodsDetail' action='/goods/goodsDetail' method='get'>
						<a href="/goods/detail.toy?g_id=${goods.g_id}"><img
							src="${pageContext.request.contextPath}/resources/assets/img/image/${goods.f_svname }" class="radius_img"
							alt="" style='width: 300px; height: 300px'> <input
							type='hidden' name='g_id' value="<c:out value='${goods.g_id}'/>">  </a> <br />
					</form>
                  <p><c:out value="${goods.g_name}" /></p>
               <c:if test="${goods.g_sale ne 0}">     
		            	<p>
		            	${goods.g_sale}%&nbsp;&nbsp;<span style="text-decoration: line-through;">${goods.g_price }</span>
		            	</p>
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * goods.g_sale) / 100}" />₩
		            </c:if>
		            <c:if test="${goods.g_sale eq 0}">
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${goods.g_price}" />₩
		            </c:if>
               </div>
			</c:forEach>
				<c:if test="${cate3 gt 3}">
					<form id="searchMore" action="/goods/searchmore.toy" method="get">
						<input type="hidden" name="g_category" value="3">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="keyword" value="${keyword}">
						<button type="submit" class="btn">더보기</button>
					</form>
				</c:if>
	</c:when>	
    <c:otherwise>
         	<div class="container">
        상품이 존재하지 않습니다.
     </div>

     </c:otherwise>
	</c:choose>
<hr>     
<br/>
<br/>


<h4 style="font-weight: bold;">문구/팬시</h4>
    <c:choose>
	<c:when test="${cate4 ne 0}">
		<c:forEach begin="0" end="3" items="${keyword4}" var="goods">
            <div class="col-lg-3 menu-item">
               <form id='goodsDetail' action='/goods/goodsDetail' method='get'>
						<a href="/goods/detail.toy?g_id=${goods.g_id}"><img
							src="${pageContext.request.contextPath}/resources/assets/img/image/${goods.f_svname }" class="radius_img"
							alt="" style='width: 300px; height: 300px'> <input
							type='hidden' name='g_id' value="<c:out value='${goods.g_id}'/>">  </a> <br />
					</form>
                  <p><c:out value="${goods.g_name}" /></p>
               <c:if test="${goods.g_sale ne 0}">     
		            	<p>
		            	${goods.g_sale}%&nbsp;&nbsp;<span style="text-decoration: line-through;">${goods.g_price }</span>
		            	</p>
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * goods.g_sale) / 100}" />₩
		            </c:if>
		            <c:if test="${goods.g_sale eq 0}">
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${goods.g_price}" />₩
		            </c:if>
               </div>
			</c:forEach>
				<c:if test="${cate4 gt 3}">
					<form id="searchMore" action="/goods/searchmore.toy" method="get">
						<input type="hidden" name="g_category" value="4">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="keyword" value="${keyword}">
						<button type="submit" class="btn">더보기</button>
					</form>
				</c:if>
	</c:when>	
    <c:otherwise>
         	<div class="container">
        상품이 존재하지 않습니다.
     </div>

     </c:otherwise>
	</c:choose>
<hr>     
<br/>
<br/>


<h4 style="font-weight: bold;">설렘토이</h4>
<c:choose>
<c:when test="${adultCheck eq 'Y' && cate5 ne 0}"> <!-- 성인일때 -->
		<c:forEach begin="0" end="3" items="${keyword5}" var="goods">
         <div class="col-lg-3 menu-item">
               <form id='goodsDetail' action='/goods/goodsDetail' method='get'>
						<a href="/goods/detail.toy?g_id=${goods.g_id}"><img
							src="${pageContext.request.contextPath}/resources/assets/img/image/${goods.f_svname }" class="radius_img"
							alt="" style='width: 300px; height: 300px'> <input
							type='hidden' name='g_id' value="<c:out value='${goods.g_id}'/>">  </a> <br />
					</form>
                  <p><c:out value="${goods.g_name}" /></p>
               <c:if test="${goods.g_sale ne 0}">     
		            	<p>
		            	${goods.g_sale}%&nbsp;&nbsp;<span style="text-decoration: line-through;">${goods.g_price }</span>
		            	</p>
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${(goods.g_price * goods.g_sale) / 100}" />₩
		            </c:if>
		            <c:if test="${goods.g_sale eq 0}">
		            	<fmt:formatNumber type="number" pattern="###,###,###,###,###,###" value="${goods.g_price}" />₩
		            </c:if>
               </div>
			</c:forEach>
				<c:if test="${adultCheck eq 'Y' && cate4 gt 3}">
					<form id="searchMore" action="/goods/searchmore.toy" method="get">
						<input type="hidden" name="g_category" value="5">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="keyword" value="${keyword}">
						<button type="submit" class="btn">더보기</button>
					</form>
				</c:if>
	</c:when>	
	<c:when test="${adultCheck eq 'Y' && cate5 eq 0}">
    
        <div class="container">
        상품이 존재하지 않습니다.
     </div>

	</c:when>

<c:otherwise> <!-- 성인이 아닐때 -->
<div class="container">
<p style="font-weight: bold; color: red;">※ 성인인증이 필요합니다. ※</p>
  <span><button type="button" class="btn" style="width: 500px; font-size: 15px;" onclick="location.href='/login/adultCheck.toy'">
   성인인증 페이지</button></span>
</div>
</c:otherwise>
</c:choose>    
   
   <br>
   <br>
   <br>
   <br>
</div></div>
</div>
         
           
   <a href="#"
      class="scroll-top d-flex align-items-center justify-content-center"><i
      class="bi bi-arrow-up-short"></i></a>





</body>
<script>

 
</script>

   
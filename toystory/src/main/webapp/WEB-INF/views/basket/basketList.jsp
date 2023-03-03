<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="/WEB-INF/includes/include-header.jspf" %>



<!DOCTYPE html>
<html>
<link href="/resources/assets/css/order.css" rel="stylesheet">
<head>

<meta charset="UTF-8">
<title>장바구니</title>
</head>

<script type="text/javascript">
 function chkAll(){
	 if( $("#chkAll").is(':checked') ){
	     $("input[name=checkRow]").prop("checked", true);
	 }else{
	     $("input[name=checkRow]").prop("checked", false);
	 }	 	 
 }
 function chkAll2(){
	     $("input[name=checkRow]").prop("checked", true);
 }
 function numberWithCommas(e) {
	    return e.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
 
</script>
<style>
.btn-group{
	align:center;
	width:100%;
	
}
</style>
<style>
.qty .count {
    color: #000;
    display: inline-block;
    vertical-align: top;
    font-size: 15px;
    font-weight: 700;
    line-height: 20px;
    padding: 0 2px;
    min-width: 35px;
    text-align: center;
}
.qty .plus {
    cursor: pointer;
    display: inline-block;
    vertical-align: top;
    color: white;
    width: 20px;
    height: 20px;
    font: 20px/1 Arial,sans-serif;
    text-align: center;
    border-radius: 50%;
    }
.qty .minus {
    cursor: pointer;
    display: inline-block;
    vertical-align: top;
    color: white;
    width: 20px;
    height: 20px;
    font: 20px/1 Arial,sans-serif;
    text-align: center;
    border-radius: 50%;
    background-clip: padding-box;
}

.minus:hover{
    background-color: #9b55d4 !important;
}
.plus:hover{
    background-color: #9b55d4 !important;
}
/*Prevent text selection*/

.count{  
    border: 0;
    width: 2%;
}
input::-webkit-outer-spin-button,
.count::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
.count:readonly{
    background-color:white;
}
.price, .sum{
	width:80px;
	font-size:14px;
}
tbody td{
	font-size:14px;
}

</style>
<link href="/resources/assets/css/order.css" rel="stylesheet">
<%--  <link href="<c:url value='/resources/css/default.css'/>" rel="stylesheet"> --%>
<body>
<div class="container" style="margin-top: 220px; margin-bottom: 95px;">
	<div>
		<h3 align="center" style="font-weight: bold; margin-bottom: 58px;">CART</h3>
	</div>
	<table class="table" style="width:80%; margin-left:10%;" id="myCart">
		<colgroup align="center">
			<col width="5%"/>
			<col width="15%"/>
			<col width="15%"/>
	        <col width="10%"/>
	        <col width="10%"/>
	        <col width="10%"/>
	        <col width="10%"/>
	        <col width="10%"/>
        </colgroup>
        <thead>
        	<tr style="text-align:center; border: 1px;">
        		<th scope="col" style="font-size:10px;">
        		 <input type="checkbox" id="chkAll" onclick="chkAll();">
        		</th>
        		<th scope="col" style="font-size:15px;">상품이미지</th>
        		<th scope="col" style="font-size:15px;">상품명</th>
        		<th scope="col" style="font-size:15px;">판매가</th>
        		<th scope="col" style="font-size:15px;">옵션</th>       		
        		<th scope="col" style="font-size:15px;">수량</th>
        		<th scope="col" style="font-size:15px;">배송비</th>
        		<th scope="col" style="font-size:15px;">합계</th>
        	</tr>
        </thead>
        
        <tbody id="tbody"> 
        	<c:forEach items="${basketList }" var="basket" varStatus="status" >       		
        		<tr align="center" id="row">
        			<td style="vertical-align: middle;">
        				<input type="checkbox" id="checkRow" name="checkRow">
        			</td>
        			<td style="vertical-align: middle;">
        			<a href="/goods/detail.toy?g_id=${basket.G_ID}"><img src='<c:url value="${pageContext.request.contextPath}/resources/assets/img/image/${basket.F_SVNAME }"/>' style="width:80px; height:80px; border-radius: 10%"> 
        			</a>
        			</td>
        			<td style="vertical-align: middle; font-weight: bold;"><c:out value="${basket.G_NAME }"/></td>
        			<td style="vertical-align: middle;">        			 
        			 <input class="price" type="hidden" name="g_price" id="price" class="price" value="${basket.G_PRICE}" readonly>
    				 <fmt:formatNumber value="${basket.G_PRICE}" type="number"/>원
        			</td>
        			<td style="vertical-align: middle;">${basket.B_OPTION }</td>        			
        			<td style="vertical-align: middle;">
        				<form id="items">
        				<input type="hidden" value="${basket.B_OPTION }"  name="b_option" >      	
        				<input type="hidden" value="${basket.G_PRICE }" name="g_price" >      	
        				<input type="hidden" value="${basket.G_ID }"  name="g_id" >      	
	        			<input type="hidden" value="${basket.B_NUM }" id="num" name="b_num" >    		
	        			<div class="qty">
             				<span class='minus bg-dark'>-</span>
            				<input type='number' class="count" name="b_count" id="cnt" value="${basket.B_COUNT }" readonly>
							<span class='plus bg-dark'>+</span>
						</div>
						</form>
        			</td>
        			<td style="vertical-align: middle;">
						<c:if test="${basket.G_PRICE * basket.B_COUNT >= 30000}">무료</c:if> 
						<c:if test="${basket.G_PRICE * basket.B_COUNT < 30000}">3,000원</c:if>

					</td>
        				
        			<td style="vertical-align: middle;">
				     <c:set var="sum1" value="${basket.G_PRICE * basket.B_COUNT}"/>
        			<fmt:formatNumber value="${sum1}" type="number" var="sss"/>
        			 <input type="text" id="sum" class="sum" value="${sum1}" readonly>
        			</td>		
        			
        		</tr>      		
        	</c:forEach>	        	
        </tbody>            
	</table>
	<div align="center" style="margin-top: 78px;">
		<button type="button" class="jbb2" id="deleteChk">선택상품삭제</button>
		&nbsp;&nbsp;
		<button type="button" class="jbb" onclick="chkAll2();">전체상품선택</button>
		&nbsp;&nbsp;
		<button type="button" class="jbb" onclick="buyItem()">선택상품주문</button>
		<%-- <button type="button" class="jbb" onclick="location.href='<c:url value='/main.toy'/>';">메인으로</button> --%>
	</div>
	
	
<script>
$(document).ready(function(){


    $(document).on('click','.plus',function(){
    	$(this).prev('.count').val(parseInt($(this).prev('.count').val()) + 1 );
		
    	var cnt = parseInt($(this).prev('.count').val());
    	var price =parseInt($(this).closest("tr").find('.price').val());
    	var sum = cnt*price;
    	
    	$(this).closest("tr").find('#sum').val(sum);
    	var num = parseInt($(this).parent().siblings("#num").val());
    	
    	/* alert(num);
    	alert(cnt); */
    	$.ajax({
			type: "POST",
			url:"<c:url value='/basket/modify.toy'/>",
			data:{b_num:num, b_count:cnt},
			success: function(data){
				location.reload();
				}	
        	});
    	var sum = cnt*price;	
 	});
 	
 	$(document).on('click','.minus',function(){
   		 $(this).next('.count').val(parseInt($(this).next('.count').val()) - 1 );
   		var cnt = parseInt($(this).next('.count').val());
    	var price =parseInt($(this).closest("tr").find('.price').val());
    	var sum = cnt*price;
    	$(this).closest("tr").find('#sum').val(sum);
    
   		 
       	 if ($(this).next('.count').val() == 0) {
          	$(this).next('.count').val(1);
          	cnt = parseInt($(this).next('.count').val());
        	price = parseInt($(this).closest("tr").find('.price').val());
        	sum = cnt*price; 
        	$(this).closest("tr").find('#sum').val(sum);
        	
         	return;
    	 }   
	       	var num = parseInt($(this).parent().siblings("#num").val());
	    	$.ajax({
				type: "POST",
				url:"<c:url value='/basket/modify.toy'/>",
				data:{b_num:num, b_count:cnt},
				success: function(data){
					location.reload();
					}	
	        });	 
	    
 	});

	$(document).on('click','#deleteChk', function(){
 		if($("input:checkbox[name=checkRow]:checked").length == 0){
 			alert("삭제할 대상을 선택하세요.");
 			return false;
 	 	} else if(confirm("선택한 상품을 삭제하시겠습니까?")== true){
 	 		$("input:checkbox[name=checkRow]:checked").each(function(){
 	 	 		
 				var tr = $(this).closest("tr").index();
 				var num = $("#tbody tr").eq(tr).find("#num").val();
 				$.ajax({
 	 				type: "POST",
 	 				async : false,
 	 				url:"<c:url value='/basket/basketDeleteOne.toy'/>",
 	 				data:{b_num:num},
 	 				success: function(data){
 	 						
 	 				}	
 	 	        });
 				location.reload();
 	 	        
 	 		});
 	 	}
 	});
 	
 		
});


 function buyItem(){

	if($("input:checkbox[name=checkRow]:checked").length == 0){
			alert("상품을 선택해주세요.");
			return false;
 	} else if(confirm("상품을 주문 하시겠습니까?")== true){
 		var b_num = $("#num").val();
 		
 		/* $.ajax({
		      type : "POST",
		      url : "<c:url value='/basket/delBuyItemBasket.toy'/>",
		      data : {"b_num":b_num},
		      async: false,
		      success : function(data){
		      }
		   }); */ 
 		
 		$("input:checkbox[name=checkRow]:checked").each(function(){
 			
 			var formOrder=$(this).closest("tr").find("form").serialize();
 			/* alert(formOrder); */
 			$.ajax({
 				type : "POST",
 				url : "<c:url value='/basket/buyItemBasket.toy'/>",
 				data : formOrder,
 				async: false,
 				success : function(data){
 					
 					
 				}
 			});
	    });
 		/* alert("어디로 가나요"); */
	   location.href="<c:url value='/order/orderForm.toy'/>"; 	        
	}	
}

</script>
</div>
</body>
</html>
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
    background-color: #717fe0 !important;
}
.plus:hover{
    background-color: #717fe0 !important;
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
	
	<table class="table table-hover" style="width:80%; margin-left:10%;" id="myCart">
		<br><br>
		<h5 align="center">CART</h5>
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
        <br>
        <thead>
        	<tr class="table-primary" style="text-align:center;">
        		<th scope="col" style="font-size:10px;">
        		 <input type="checkbox" id="chkAll" onclick="chkAll();">
        		</th>
        		<th scope="col">상품이미지</th>
        		<th scope="col">상품명</th>
        		<th scope="col">가격</th>
        		<th scope="col">옵션</th>       		
        		<th scope="col">수량</th>
        		<th scope="col">배송비</th>
        		<th scope="col">합계</th>
        	</tr>
        </thead>
        
        <tbody id="tbody"> 
        	<c:forEach items="${basketList }" var="basket" varStatus="status" >       		
        		<tr align="center" id="row">
        			<td>
        				<input type="checkbox" id="checkRow" name="checkRow">
        			</td>
        			<td>
        			 <img src="<c:url value="/resources/assets/img/menu/spiderman.png"/>" style="width:50px;">
        			</td>
        			<td><c:out value="${basket.G_NAME }"/></td>
        			<td>        			 
        			 <input class="price" type="hidden" name="g_price" id="price" class="price" value="${basket.G_PRICE}" readonly>
    				 <fmt:formatNumber value="${basket.G_PRICE}" type="number"/>
        			</td>
        			<td>${basket.B_OPTION }</td>        			
        			<td>
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
        			<td>
        			<span id="delivery_price_${status.index}"> 
						<c:if test="${basket.G_PRICE * basket.B_COUNT >= 30000}">무료</c:if> 
						<c:if test="${basket.G_PRICE * basket.B_COUNT < 30000}">3,000원</c:if>

						</span>
					</td>
        				
        			<td>
				     <c:set var="sum1" value="${basket.G_PRICE * basket.B_COUNT}"/>
        			<fmt:formatNumber value="${sum1}" type="number" var="sss"/>
        			 <input type="text" id="sum" class="sum" value="${sum1}" readonly>
        			</td>		
        			
        		</tr>      		
        	</c:forEach>	        	
        </tbody>            
	</table>
	
	<br><br>
	<div align="center">
		<button type="button" class="btn btn-primary" onclick="chkAll2();">전체선택</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn btn-primary" id="deleteChk">선택삭제</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn btn-primary" onclick="buyItem()">선택주문</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn btn-primary" onclick="location.href='<c:url value='/main.toy'/>';">메인으로</button>
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
 	 				url:"<c:url value='/basket/basketDeleteOne.toy'/>",
 	 				data:{b_num:num},
 	 				success: function(data){
 	 						location.reload();
 	 				}	
 	 	        });
 	 	        
 	 		});
 	 	}
 	});
 	
 		
});

function buyItem(){

	if($("input:checkbox[name=checkRow]:checked").length == 0){
			alert("상품체크하삼.");
			return false;
 	} else if(confirm("주문할꺼임?")== true){
 		var b_num = $("#num").val();
 		alert(b_num);
 		$.ajax({
		      type : "POST",
		      url : '<c:url value="/basket/delBuyItemBasket.toy"/>',
		      data : {"b_num":b_num},
		      async: false,
		      success : function(data){
		      }
		   }); 
 		$("input:checkbox[name=checkRow]:checked").each(function(){
 			
 			
 			
 			var formOrder=$(this).closest("tr").find("form").serialize();
 			alert(formOrder);
 			$.ajax({
 				type : "POST",
 				url : "<c:url value='/basket/buyItemBasket.toy'/>",
 				data : formOrder,
 				async: false,
 				success : function(data){
 					
 					
 				}
 			});
	    });
 		alert("어디로 가나요");
	   location.href="<c:url value='/order/orderForm.toy'/>";
 	        
	}
	
	//쥬얼 장바구니 동선
	/* function buyItem(){

		if($("input:checkbox[name=checkRow]:checked").length == 0){
				alert("상품체크하삼.");
				return false;
	 	} else if(confirm("주문할꺼임?")== true){
	 		$.ajax({
			      type : "POST",
			      url : '<c:url value="/order/delBuyItemCart"/>',
			      async: false,
			      success : function(data){
			      }
			   }); 
	 		$("input:checkbox[name=checkRow]:checked").each(function(){
	 			
	 			var formOrder=$(this).closest("tr").find("form").serialize();
	 			$.ajax({
	 				type : "POST",
	 				url : "<c:url value='/item/buyItemCart'/>",
	 				data : formOrder,
	 				async: false,
	 				success : function(data){
	 					
	 					
	 				}
	 			});
		    });
		    location.href="<c:url value='/item/qmember'/>";
	 	        
		} */
	
	
}

</script>
		
</body>
</html>
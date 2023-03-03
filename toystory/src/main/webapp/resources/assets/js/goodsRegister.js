﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿/**
 *작성자 : 남재욱, 이효원
 *작성일 : 2022.12.22
 *용도 : 상품 등록 시, 유효성 검사
 */

$(document).ready(function(){
		
		//상품 등록 버튼 클릭 시, 유효성 검사
		$('#registerButton').on('click', function(e){
	          var g_category = $('#g_category').val();
	          var g_brand = $('#g_brand').val();
	          var g_name = $('#g_name').val();
	          var g_price = $('#g_price').val();
	          var g_stock = $('#g_stock').val();
	          var g_sale = $('#g_sale').val();
	          var mainImage = $('#mainImage').val();
	          
	          if(g_category == ''){
	            alert("카테고리를 선택해주세요.");	
	            $('#g_category').focus();
	            return false;
	          }
	          if(g_brand == null || g_brand == ''){
	            alert("브랜드명을 입력해주세요.");	
	            $('#g_brand').focus();
	            return false;
	          }
	          if(g_name == null || g_name == ''){
	            alert("상품명을 입력해주세요.");	
	            $('#g_name').focus();
	            return false;
	          }
	          if(g_price == null || g_price == ''){
	            alert("가격을 입력해주세요.");	
	            $('#g_price').focus();
	            return false;
	          }
	          if(g_stock == null || g_stock == ''){
	            alert("재고를 입력해주세요.");	
	            $('#g_stock').focus();
	            return false;
	          }
	          
	          if(g_sale == null || g_sale == ''){
	            alert("할인율을 입력해주세요.");	
	            $('#g_sale').focus();
	            return false;
	          }
	          if(mainImage == null || mainImage == ''){
	            alert("메인 이미지를 추가해주세요.");	
	            $('#mainImage').focus();
	            return false;
	          }
	          
	        this.form.submit();
	     
		});
		
		var gfv_count = 1;
	
		//파일 추가 버튼
  		$("#addFile").on("click", function(e) { 
    		e.preventDefault();
    		fn_addFile();
  		});

		//삭제 버튼
	  	$("a[name='delete']").on("click", function(e) { 
	    	e.preventDefault();
	    	fn_deleteFile($(this));
	 	});

	 	function fn_addFile() {
	    	var str = "<p><input type='file' name='file_" + (gfv_count++)
	          				+ "'><a href='#this' class='btn' name='delete'>삭제</a></p>";
	    	$("#fileDiv").append(str);
	    	
	    	$("a[name='delete']").on("click", function(e) { //삭제 버튼
	       		e.preventDefault();
	       		fn_deleteFile($(this));
	    	});
	 	}

	 	function fn_deleteFile(obj) {
	    	obj.parent().remove();
	 	}
	 	
	 	$('#g_price, #g_stock, #g_sale').keyup(function(){
			let mobile = $(this).val();
			$(this).val(onlyNumber(mobile));
		});
});

function onlyNumber(data){
	data = data.replace(/[^0-9]/g, '');
	return data;
}
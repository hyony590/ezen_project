<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.align-center{
	margin-left:auto;
	margin-right:auto;
	text-align:center;
}
.orderInfo{
  display: inline-block;
  padding-top:10;
  vertical-align:bottom;
  
  
}

.form-control {
  display: inline-block;
  width: 100%;
  padding: 0.375rem 0.75rem;
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;
  color: #212529;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid #ced4da;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  border-radius: 0.375rem;
  transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.form-control-width-zipcode {
  display: inline-block;
  width: 100%;
  /* padding: 0.375rem 0.75rem; */
  font-size: 1rem;
  font-weight: 400;
  line-height: 1.5;
  color: #212529;
  background-color: #fff;
  background-clip: padding-box;
  border: 1px solid #ced4da;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  border-radius: 0.375rem;
  transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
}

.formHeader {
	text-align: center;
	font-size: 20pt;
	height: 100pt;
}


.order-form {

width: 500px;
margin:auto;
border: solid 1px;
font-size: 14px;
border-left: 0px;
border-right: 0px;
}


.order-form td{
     
     height: 100px;
     /* border:dotted 1px; */
     height: 30px;
   }

   .order-form tr {
     /* border-bottom: dotted 1px;; */
     height: 100px;
     
     height: 30px;
   }


   .btn-purple {
     
 --bs-btn-color: #ffffff;
 --bs-btn-bg: #9b55d4;
 --bs-btn-border-color: #9b55d4;
 --bs-btn-hover-color: #fff;
 --bs-btn-hover-bg: #9b55d4;
 --bs-btn-hover-border-color: #9b55d4;
 --bs-btn-focus-shadow-rgb: 49, 132, 253;
 --bs-btn-active-color: #fff;
 --bs-btn-active-bg: #9b55d4;
 --bs-btn-active-border-color: #9b55d4;
 --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
 --bs-btn-disabled-color: #fff;
 --bs-btn-disabled-bg: #9b55d4;
 --bs-btn-disabled-border-color: #9b55d4;
}



.order-header{
 padding:10px; 
 font-size:18px; 
 width:700px; 
 text-align:left; 
 margin:auto;
}



</style>
<script defer type="text/javascript" src="/resources/assets/js/daumPostcode.js"></script>
<script>

$(document).ready(function(){
	$('#sample6_postcode, #sample6_address').on("click", function(){
		$('#findZipcode').trigger("click");
	});
	
	
	$('#back').on('click', function(){
		window.history.back();
	})
});


</script>

</head>
<body>


  <section style="width:500px; margin:auto; padding-top: 200px;">

  <div style="width: 700px; "  >
    <span>회원정보수정</span>
  </div>
  <form id="#" action="/admin/memberModifyPro.toy" method="post">
  
    <table class="order-form">

      <tr>
        <td style="width: 120px;">이메일</td>
        <td colspan="2" style="width: 300px;">
          <input class="form-control-add form-control" name="m_email" value="<c:out value='${member.m_email }'/>" readonly>
          </td>
      </tr>


      
      <tr>
        <td style="width: 120px;">이름</td>
        <td colspan="2" style="width: 300px;">
          <input class="form-control-add form-control" name="m_name" value="<c:out value='${member.m_name }'/>" readonly>
          </td>
      </tr>
      <tr>
        <td style="width: 120px;">생일</td>
        <td colspan="2" style="width: 300px;">
          <input type="text" class="form-control-add form-control" name="m_birth" value="<c:out value='${member.m_birth }'/>" readonly>
          </td>
      </tr>

      <tr>
        <td>휴대전화</td>
        <td colspan="2"><input class="form-control-add form-control"
          type="text" name="m_mobile" value="<c:out value='${member.m_mobile }'/>" readonly></td>
      </tr>

      <tr>
        <td>전화번호</td>
        <td colspan="2"><input class="form-control-add form-control"
          type="text"  name="m_phone" value="<c:out value='${member.m_phone }'/>"></td>
      </tr>


      <tr>
        <td>우편번호</td>
        <td colspan="2"><input style="width:100px" id="sample6_postcode" class="form-control-add form-control" type="text"  name="m_zipcode" value="<c:out value='${member.m_zipcode }'/>" readonly>
          <button type="button" class=" btn btn-purple" id="findZipcode" onclick="sample6_execDaumPostcode()">검색</button></td>
      </tr>

      <tr>
        <td>주소</td>
        <td colspan="2"><input class="form-control-add form-control" id="sample6_address"
          type="text"  name="m_address1" value="<c:out value='${member.m_address1 }'/>" readonly></td>
      </tr>

      <tr>
        <td>상세주소</td>
        <td colspan="2"><input class="form-control-add form-control" id="sample6_detailAddress"
          type="text"  name="m_address2" value="<c:out value='${member.m_address2 }'/>"></td>
      </tr>

      


      <tr>
        <td><div>비고</div></td>
        <td colspan="3"><textarea class="form-control" name="m_note"
            style="width: 400px; height: 120px;" placeholder="빠른 배송 부탁드립니다."><c:out value='${member.m_note }'/>
          </textarea>
        </td>
      </tr>

      

      <tr>
        <td colspan="3">
          <div style="text-align: center">
            <span class="orderPrice" style="float: left"></span> 
            <span class="dp"></span>
            <span style="float: right;" class="totalPrice"></span>
          </div>
        </td>
      </tr>

      <tr>
        <td colspan="3" style="text-align: center; height: 50px;">
          <button type="button" id="back" class="btn btn-outline-submit"style="width: 100px; margin: 4px;">뒤로가기</button>
          <button type="submit" class="btn btn-purple" style=" width: 60px; margin: 4px;">수정</button>
        </td>
      </tr>

    </table>
  </form>
  
</section>
</body>
</html>
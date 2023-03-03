<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/assets/css/goods.css" rel="stylesheet">
<meta charset="UTF-8">

<script type="text/javascript">
//체크박스 전체 선택
function selectAll(selectAll)  {
  const checkboxes 
       = document.getElementsByName('item');
  
  checkboxes.forEach((checkbox) => { checkbox.checked = selectAll.checked;})
} 

//상품명 클릭시 상품 상세보기 팝업창 띄우기
function winPopup(gId) {
   var a = gId;
    var popUrl = "/goods/detail.toy?g_id="+a ;
    var blank = "_blank";
    var popOption ="top=10, left=120, width=1150, height=1100, status=no, menubar=no, toolbar=no, resizable=no";
    window.open(popUrl, blank, popOption);
} 
</script>

<!-- 12/7 추가 -->
<script>
$(document).ready(function(){
   $('#deleteButton').on('click', function(){
      var $checked = $('input.chec[type=checkbox]:checked');
      
      if($checked.length < 1){
         alert('삭제할 상품을 선택해주세요. ');
         return false;
      }
      
      var gIdList = [];
      
      $.each($checked, function(k, v){
         gIdList.push($(this).val());
      });
      
      
      
      $.ajax({
          url : "/admin/goodsdeleteproarr.toy", //12-8 url 수정
          type : "get",
          data : { chbox : gIdList}, //변수이름 chbox ,변수값: gIdList 
          success: function(result){
             if(result != null){
                alert("성공적으로 삭제 되었습니다.");
               window.location.href="/admin/goodslist.toy";
             }else{
                alert('삭제에 실패했습니다.');
                window.location.href="/admin/goodslist.toy";
             }
          }
      });
   });
});

//상품 삭제 클릭 시 alert창 생성
function delConfirm(gid){
      var a = gid;
      if(!confirm("해당 상품을 삭제하시겠습니까?")){
         location.href="/admin/goodslist.toy";
      }else{
         alert("성공적으로 삭제 되었습니다.");
         location.href="/admin/goodsdeletepro.toy?g_id="+a;
      }
   }


</script>
<!--12/7추가 끝-->


</head>
<body>

   <br>
   <section id="goods">
         <h3>상품 리스트</h3>
         <p>토이스토리의 상품 리스트입니다.</p>
      
      <div class="container" id="ANbtn">
            <!-- <input id="check" type="button" style="float:left" value="선택 상품 삭제"> -->
            
            <!-- 12/7 버튼으로 바꿈 -->
            <a type="button" id="deleteButton" class="btn-book-a-table" style="float:left">선택상품삭제</a> 
         
            <!-- 12/7수정끝 -->
            <a class="btn-book-a-table" href="/admin/goodsregisterform.toy" style="float:right" >글쓰기</a>
      </div>
      
      <br> <br> <br>
      
      <!-- 상품 목록 부분 -->
      <div class="container">
         <table class="table">
            <thead>
               <tr>
                  <th scope="col">
                     <!-- 전체 체크박스 선택하기 -->
                     <input id="input1" type="checkbox" name="item" value="selectall" onclick="selectAll(this)" />
                     
                  </th>
                  <th scope="col">상품번호</th>
                  <th scope="col">상품이미지</th>
                  <th scope="col">상품 카테고리</th>
                  <th scope="col">상품명</th>
                  <th scope="col">상품금액</th>
                  <th scope="col">재고</th>
                  <th scope="col">선택</th>
               </tr>
            </thead>
            <tbody>
            
               <c:if test="${fn:length(admingoodslist) == 0 }">
                상품 없음
               </c:if>
               
               <c:if test="${fn:length(admingoodslist) != 0 }" >
                  <c:forEach items="${admingoodslist}" var="goods">
                   <tr>
                        <td><!-- 체크박스 --> 
                           <input id="input2" class="chec" type="checkbox" name="item" value="${goods.g_id }">
                        </td>
                       <td><!-- 상품번호 -->
                          <c:out value="${goods.g_id}" />
                       </td>
                       <td><!-- 상품이미지 -->
                             <c:out value="파일" />
                       </td>
                       <td><!-- 상품 카테고리 -->
                           <c:if test="${goods.g_category eq '1'}">캐릭터/피규어</c:if>
                           <c:if test="${goods.g_category eq '2'}">창작DIY</c:if>
                           <c:if test="${goods.g_category eq '3'}">보드게임</c:if>
                           <c:if test="${goods.g_category eq '4'}">문구/팬시</c:if>
                           <c:if test="${goods.g_category eq '5'}">설렘토이</c:if>
                       </td>
                       <td><!-- 상품명 -->
                           <a href="javascript:void(0);" onclick="winPopup(${goods.g_id});">
                           <input type='hidden' value="<c:out value='${goods.g_id}'/>">
                           ${goods.g_name}</a>
                       </td>
                       <td><!-- 상품금액 -->
                           <c:out value="${goods.g_price}" />
                       </td>   
                       <td><!-- 재고 -->
                           <c:out value="${goods.g_stock}" />
                       </td>
                       <td><!-- 선택 -->
                           <a class="btn-book-a-table" href="/admin/goodsmodifyform.toy?g_id=<c:out value="${goods.g_id}"/>">
                           수정하기</a>
                              / 
                           <a class="btn-book-a-table" onclick="delConfirm(${goods.g_id})" style="cursor:pointer">  <!-- 12/7 수정 -->
                           상품삭제</a>
                       </td>
               </tr>
               </c:forEach>
            </c:if>
         </tbody>
      </table>
   </div>
</section>

<!-- 12.15 페이징 -->
         <nav aria-label="pagination">
            <ul class="pagination justify-content-center">
            
               <c:if test="${pageMaker.prev}">
                  <li class="paginate_button previous">
                     <a href="goodslist.toy?&pageNum=${pageMaker.startPage - 1}" class="page-link" >이전</a>
                  </li>
               </c:if>
                  
               <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                  <li class="paginate_button  ${pageMaker.cri.pageNum == num ? 'active':''}">
                  <a href="goodslist.toy?pageNum=${num}" class="page-link" >${num}</a></li>
               </c:forEach>
                  
               <c:if test="${pageMaker.next}">
                  <li class="paginate_button next">
                     <a href="goodslist.toy?&pageNum=${pageMaker.endPage + 1 }" class="page-link" >다음</a>
                  </li>
               </c:if>
               
            </ul>   
         </nav>

</body>
</html>
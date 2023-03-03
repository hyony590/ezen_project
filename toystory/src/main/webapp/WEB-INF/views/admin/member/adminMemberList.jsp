<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>

<link href="/resources/assets/css/member.css" rel="stylesheet">
<style>
tbody tr:hover{
		background-color:#dddddd;
	}
</style>

<script>

	$(document).ready(function(){
		$('#resetSearch').on('click', function(){
			self.location="/admin/memberList.toy";
		})
	})

</script>


<script>

$(document).ready(function(){
	
	var actionForm = $("#actionForm");


	$(".paginate_button a").on("click", function(e){
		
		
		e.preventDefault();
		
		console.log('click');
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
		
	});
	
	

})

function getMemberDetail(m_num){
	self.location="/admin/modifyForm.toy?m_num="+m_num;
}

///admin/modifyForm.toy

</script>

<style>
	.member-list{
		width: 1200px;
		margin: auto;
		padding: 5px;
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
	
	

</style>
</head>
<body>

<section id="member-list">

		<div class="container" style="margin-top: 150px;">
			<div style="width: 1000px; margin: auto;">
				<h4 style="text-align: center; font-weight: bold;">회원관리</h4>
			</div>
		</div>


		<div class="container" style="margin-top: 20px;">
			<div style="width: 1200px; margin: auto; padding: 5px;" class="admin-search-form">
				<form method="get" action="/admin/memberList.toy">
						<span style="float:left;">회원상세보기</span>

						<span style="float:right;">
							<span><select class="form-header"
									name="type" style="height: 35px;">
										<option value="m_email">email</option>
										<option value="m_name">이름</option>
										<option value="m_mobile">휴대폰번호</option>
								</select></span> 
							<span><input type="text" class="form-control" name="keyword" style="width: 200px; height: 35px; display: inline-block;"></span> 
							<span>
								<button type="submit" class="btn btn-purple" style="width: 70px;vertical-align:baseline;">검색</button>
								<button type="button" id = resetSearch class="btn btn-purple" style="width: 100px; vertical-align:baseline;">전체보기</button>
							</span>
						</span>
				</form>
			</div>
		</div>


		<div class="container">


		<table class="member-list">
			<thead>
				<tr>
					<!-- <th width="5%">번호</th> -->
					<th width="20%">이메일</th>
					<th width="10%">이름</th>
					<th width="20%">핸드폰번호</th>
					<th width="*">주소</th>
				</tr>
			</thead>

			<tbody>
				<tr>
					<c:if test="${fn:length(memberList) == 0}">
	
						<td colspan="5" height="100" align="center">조회된 회원이 없습니다.</td>
	
					</c:if>
				</tr>
				
				<c:if test="${fn:length(memberList) != 0}">
					<c:forEach var="member" items="${memberList }">
						<tr onclick="getMemberDetail('${member.m_num}')">
							<%-- <td width="5%"><c:out value='${member.m_num }'/></td> --%>
							<td width="20%"><c:out value='${member.m_email}'/></td>
							<td width="10%"><c:out value='${member.m_name}'/></td>
							<td width="20%"><c:out value='${member.m_mobile}'/></td>
							<td width="*">
								<c:out value='${member.m_zipcode}'/>&nbsp;
								<c:out value='${member.m_address1}'/>&nbsp;
								<c:out value='${member.m_address2}'/>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>


		</table>


</div>


<form id='actionForm' action="/admin/memberList.toy" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="type" value="${pageMaker.cri.type }">
	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
</form>





<!-- 페이징 작업할 부분 -->
<div style="margin:auto; text-align:center; width:700px">
	<div class="inner">
			<ul class="pagination" style="text-align: center; justify-content: center;">
			
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a class="page-link" href="${pageMaker.startPage - 1 }"
						tabindex="-1" aria-disabled="true">Previous</a></li>
				</c:if>		
						
					<c:forEach var="num" begin="${pageMaker.startPage }" end ="${pageMaker.endPage }">
						<li class="page-item paginate_button ${pageMaker.cri.pageNum == num ? 'active' : '' }">
							<a class="page-link" href="${num }">${num }</a>
						</li>
					</c:forEach>
					
				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a class="page-link" href="${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>	
			</ul>
	</div>
</div>

</section>





</body>


</html>
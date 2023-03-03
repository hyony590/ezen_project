<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="/resources/assets/css/member.css" rel="stylesheet">
<script defer type="text/javascript" src="/resources/assets/js/member.js"></script>
<script>


</script>
</head>
<body onload="findIdResult(${result})">


  <br><br><br><br><br><br><br>
    
      
    
    <div>
    
      <form action="/login/findAccount.toy" method="post" id="findIdForm">
      	<input type="hidden" name="accountName" value="id">
    
        <table class="input-form">
          <thead>
            <tr>
              <th colspan="2" class="formHeader">FIND ID</th>
            </tr>
          </thead>
    
          <tbody>
            <tr>
              <th><label for="m_name" class="form-header">이름</label></th>
              <td>
                <input type="text" class="form-control" id="m_name" name="m_name" placeholder="홍길동" maxlength="10">
              </td>
            </tr>
            <tr>
              <th><label for="m_mobile" class="form-header">휴대폰번호</label></th>
              <td><input type="text" class="form-control" id="m_mobile" name="m_mobile" placeholder="-제외하고 입력" maxlength="12"> </td>
            </tr>
  
            <tr>
              <td colspan="2" align="center" height="30"></td>
            </tr>
  
            <tr>
              <td colspan="2" align="center">
                <button type="button" class="btn btn-login w-75 h-50" onclick="findIdVali()">아이디 찾기</button>
              </td>
            </tr>
  
            
            
          </tbody>
        </table>
        
        </form>
    </div>
    
    <br><br><br><br><br>
    
    
	


</body>
</html>
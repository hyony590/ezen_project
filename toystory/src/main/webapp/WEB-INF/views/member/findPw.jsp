<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="/resources/assets/css/member.css" rel="stylesheet">
<script defer type="text/javascript" src="/resources/assets/js/member.js"></script>
</head>
<body onload="findPwResult(${result})">

<br><br><br><br><br><br><br>
    
      
    
    <div>
    
      <form action="/login/findAccount.toy" method="post">
     	 <input type="hidden" name="accountName" value="pw">
    
        <table class="join-table input-form">
          <thead>
            <tr>
              <th colspan="2" class="formHeader">FIND PW</th>
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
              <th><label for="m_email" class="form-header">이메일</label></th>
              <td>
                <input type="text" class="form-control" id="m_email" name="m_email" placeholder="toy@story.com" maxlength="30">
              </td>
            </tr>
            <tr>
              <th><label for="m_mobile" class="form-header">휴대전화</label></th>
              <td><input type="text" class="form-control" id="m_mobile" name="m_mobile" placeholder="-제외하고 입력" maxlength="12"> </td>
            </tr>
  
            <tr>
              <td colspan="2" align="center" height="30"></td>
            </tr>
  
            <tr>
              <td colspan="2" align="center">
                <button type="submit" class="btn btn-login w-75 h-50" onclick="findPwVali()">패스워드 찾기</button>
              </td>
            </tr>
  
            
            
          </tbody>
        </table>
        
        </form>
    </div>
    
    <br><br><br><br><br>
	


</body>
</html>
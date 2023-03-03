﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿﻿/**
 * 
 */

//가입, 회원정보 수정시 비밀번호, 비밀번호 확인 값 맞는지 확인
$(document).ready(function(){
		$('#m_password, #m_password2').keyup(function(){
			var password1 = $("#m_password").val();
			var password2 = $("#m_password2").val();
			
			if(checkPassword(password1) == false) {
				$('#passwordCheck').css("color", "red");
				$('#passwordCheck').css("font-size", "8px;");
				$('#passwordCheck').html("영문(대소문자), 특수기호, 숫자로 구성된<br>8~20자리 비밀번호를 설정해주시기 바랍니다.");
				$('#passwordSameCheck').val(0);
				return false;
			}
			
			$('#passwordCheck').css("font-size", "16px;");
			
			if(password1 == null || password1 == '') {
			
				$('#passwordCheck').css("color", "red");
				$('#passwordCheck').html("비밀번호를 입력해주세요.");
			}else {
				
			
				if(password1 != password2){
					$('#passwordCheck').css("color", "red");
					$('#passwordCheck').html("비밀번호가 일치하지 않습니다.");
					$('#passwordSameCheck').val(0);
				}else if(password1 == password2){
					$('#passwordCheck').css("color", "green");
					$('#passwordCheck').html("비밀번호가 일치합니다.")
					$('#passwordSameCheck').val(1);
				}
			}
		});
		
		//아이디찾기 버튼 클릭시 아이디찾기 화면으로
		$('#findId').on("click", function(){
			self.location = "/login/findId.toy";
		})
		
		
		//비번찾기 버튼 클릭시 비번찾기 화면으로
		$('#findPw').on("click", function(){
			self.location = "/login/findPw.toy";
		})
		
		//가입화면으로 이동
		$('#joinForm').on("click", function(){
			self.location = "/join/join.toy";
		})
		
		
		//우편번호에 직접 입력 막고 우편번호 input 클릭시 검색 버튼 실행
		$('#sample6_postcode, #sample6_address').on("click", function(){
			$('#findZipcode').trigger("click");
		});
		

		//마이페이지 내정보수정 화면으로
		$('#modifyForm').on("click", function(){
			let form = $('#myPage-form');
			
			form.attr('action', '/myPage/modifyForm.toy').submit();
			
		});
		
		//마이페이지 내 주문 리스트 화면으로
		$('#myOrderList').on('click', function(){
			let form = $('#myPage-form');
			
			form.attr('action', '/myPage/orderList.toy').submit();
/*			form.attr('action', '/myPage/orderList.toy').submit();
*/			
			
		});
		
		//회원가입 리셋버튼 클릭 시 id, 비번동일여부 모바일 체크 결과도 같이 리셋
		$('#resetJoin').on('click', function(e){
			e.preventDefault();
			$("#id_check_result").html(null);
			$("#mobile_check_result").html(null);
			$("#passwordCheck").html(null);
			$('#mobileCheck').val(0);
			$('#idCheck').val(0);
			this.form.reset();
			
		});

		
		//회원가입시 필수입력사항 입력 체크
		$('#join').on('click', function(e){
	          
	          var email = $('#email_check').val();
	          var password1 = $('#m_password').val();
	          var password2 = $('#m_password2').val();
	          var name = $('#m_name').val();
	          var birth = $('#m_birth').val();
	          var mobile = $('#m_mobile').val();
	          var zipcode = $('#sample6_postcode').val();
	          var address1 = $('#sample6_address').val();
	          var address2 = $('#sample6_detailAddress').val();
	          var idCheck = $('#idCheck').val();
	          var mobileCheck = $('#mobileCheck').val();
	          var passwordSameCheck = $('#passwordSameCheck').val();
	          
	          
	          if(email == null || email == ''){
	            alert("아이디를 입력해주세요.");	
	            $('#m_email').focus();
	            return false;
	          }
	          
	          if(password1 == null || password1 == ''){
	            alert("비밀번호를 입력해주세요.");	
	            $('#m_password1').focus();
	            return false;
	          }
	          
	          if(password2 == null || password2 == ''){
	            alert("비밀번호 확인을 입력해주세요.");	
	            $('#m_password2').focus();
	            return false;
	          }
	          
	          if(name == null || name == ''){
	            alert("이름을 입력해주세요.");	
	            $('#m_name').focus();
	            return false;
	          }
	          
	          if(birth == null || birth == ''){
	            alert("생일을 입력해주세요.");	
	            $('#m_birth').focus();
	            return false;
	          }
	          
	          if(mobile == null || mobile == ''){
	            alert("휴대전화를 입력해주세요.");	
	            $('#m_mobile').focus();
	            return false;
	          }
	          
	          if(zipcode == null || zipcode == ''){
	            alert("우편번호를 입력해주세요.");	
	            $('#sample6_postcode').focus();
	            return false;
	          }
	          
	          if(address1 == null || address1 == ''){
	            alert("주소를 입력해주세요.");	
	            $('#sample6_address').focus();
	            return false;
	          }
	          
	          if(address2 == null || address2 == ''){
	            alert("상세주소를 입력해주세요.");	
	            $('#sample6_detailAddress').focus();
	            return false;
	          }
	          
	          if(idCheck == 0) {
	        	  alert("아이디가 중복되었습니다. 다른 아이디를 입력해주세요.")
	        	  $('#m_email').focus();
	        	  return false;
	          }
	          
	          if(mobileCheck == 0) {
	        	  alert("휴대폰번호가 중복되었습니다. 다른 휴대폰번호를 입력해주세요.")
	        	  $('#m_mobile').focus();
	        	  return false;
	          }
	          
	          if(passwordSameCheck == 0) {
	        	  alert('비밀번호가 일치하지 않습니다. 다시 확인해주시기 바랍니다.');
	        	  $('#m_password1').focus();
	        	  return false();
	          }
	          
	        this.form.submit();
	        alert('회원가입에 성공하셨습니다.')
	          
	          
	        });
		
		
		/*resetJoin*/
		
		//로그인시 아이디, 비번 입력 체크
		$('#login-btn').on('click', function(e){
	          
	          var email = $('#m_email').val();
	          var password1 = $('#m_password').val();
	          
	          
	          if(email == null || email == ''){
	            alert("아이디를 입력해주세요.");	
	            $('#m_email').focus();
	            return false;
	          }
	          
	          if(password1 == null || password1 == ''){
	            alert("비밀번호를 입력해주세요.");	
	            $('#m_password').focus();
	            return false;
	          }
	          
	        this.form.submit();
	          
	          
	          
	   });
		
		
		//성인인증시 생년월일 입력 확인
		$('#adultCheck').on("click", function(){
			
			var birth = $('#m_birth').val();
			
			if(birth == null || birth ==''){
				alert("생년월일을 입력해주세요");
				false
			}
			
			this.form.submit();
			
			
		});
		
		
		//메인화면으로 보내기
		$('#goMain').on("click", function(){
			$(location).attr('href', "/main.toy")
					
		});
		
		
		//로그인 화면으로 보내기
		$('#goLogin').on("click", function(){
			$(location).attr('href', "/login/login.toy")
			
		});
		
		
		//아이디 중복검사 ajax
		$('#email_check').focusout(function() {
			let email = $('#email_check').val(); // input_id에 입력되는 값
			let idCheck = $('#idCheck');
			
			//바이트 체크하는건데 안씀...
			let textLength = getByteLengthOfString($(this).val());
			
			if(checkEmail(email) == false) {
				$('#id_check_result').css("color", "red");
				$('#id_check_result').html("정확한 이메일을 입력해주시기 바랍니다.");
				$('#passwordSameCheck').val(0);
				return false;
			}
			
			
			if(email != null && email !='') {
				
				$.ajax({
					url : "/join/idCheck.toy",
					type : "post",
					contentType: "application/json",
					data : JSON.stringify({
						email : email
					}),
					dataType:'json',
					success : function(result, status, xhr) {
						if (result != 0) {
							$("#id_check_result").html('중복된 아이디입니다.');
							$("#id_check_result").css('color', 'red');
							$('#idCheck').val(0);
						} else {
							$("#id_check_result").html('사용할 수 있는 아이디입니다.');
							$("#id_check_result").css('color', 'green');
							$('#idCheck').val(1);
						}
					},
					error : function() {
						alert("서버요청실패");
					}
				})
			}else {
				$("#id_check_result").html('아이디를 입력해 주세요.');
				$("#id_check_result").css('color', 'red');
				$('#idCheck').val(-1);
			}
		});
	
	
	
	
		
		//휴대폰번호 입력시 숫자제외 모두 제거 
		$('#m_mobile').keyup(function(){
			let mobile = $('#m_mobile').val();
			$('#m_mobile').val(onlyNumber(mobile));
		});
		
		$('#m_phone').keyup(function(){
			let phone = $('#m_phone').val();
			$('#m_phone').val(onlyNumber(phone));
		});
	
		
		
		
		
		//휴대폰번호 중복검사 ajax
		
		
		
		$('#m_mobile').focusout(function() {
			
			let mobile = $('#m_mobile').val();
			let pattern = /^[0-9]{10,12}$/i;
			
			if(!pattern.test(mobile)) {
				$("#mobile_check_result").html('10~12 자리수로 입력해주세요');
				$("#mobile_check_result").css('color', 'red');
				$('#mobileCheck').val(0);
				return false;
				
			}
			
			if(mobile != null && mobile != '' ) {
				
				$.ajax({
					url : "/join/mobileCheck.toy",
					type : "post",
					contentType: "application/json",
					data : JSON.stringify({
						mobile : mobile
					}),
					dataType : 'json',
					success : function(result, status, xhr) {
						if (result != 0) {
							$("#mobile_check_result").html('중복된 휴대폰번호 입니다.');
							$("#mobile_check_result").css('color', 'red');
							$('#mobileCheck').val(0);
						} else {
							$("#mobile_check_result").html('사용 가능한 휴대폰번호 입니다.');
							$("#mobile_check_result").css('color', 'green');
							$('#mobileCheck').val(1);
						}
					},
					error : function() {
						alert("서버요청실패");
					}
				})
			}else {
				$("#mobile_check_result").html("휴대폰 번호를 입력해주세요");
				$("#mobile_check_result").css('color', 'red');
				$('#mobileCheck').val(-1);
			}
		});
		
	
		
		
	});


//다음 주소검색
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                
            
            } else {
                
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

//비밀번호 유효성검사 8~20자 입력, 숫자, 영문, 특수기호만 입력 가능
function checkPassword(pw) {
	var regexPw = /^[A-Za-z0-9`~!@#\$%\^&\*\(\)\{\}\[\]\-_=\+\\|;:'"<>,\./\?]{8,20}$/;
	if(!regexPw.test(pw)) {
		return false;
	}
	  return true;
}

function checkEmail(email) {
	var pattern = /^[0-9a-zA-Z가-힣]([-_.]?[0-9a-zA-Z가-힣])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if(!pattern.test(email)) {
		return false;
	}
	return true;
}



//로그인 실패여부
function loginCheck(code){
	
	if(code =='1' || code == 1 ){
		alert("로그인에 실패하였습니다");
	};

};


function findIdVali() {
	let form = document.getElementById('findIdForm');
	let name = document.getElementById('m_name');
	let mobile = document.getElementById('m_mobile');
	
	if(name.value == '') {
		alert("이름을 입력해주세요'");
		name.focus();
		return false;
	}
	
	if(mobile.value == '') {
		alert("휴대폰번호를 입력해주세요'");
		mobile.focus();
		return false;
	}
	
	form.submit();
		
};

function findPwVali() {
	let form = document.getElementById('findPwForm');
	let name = document.getElementById('m_name');
	let mobile = document.getElementById('m_mobile');
	let email = document.getElementById('m_email');
	
	if(email.value == '') {
		alert("아이디를 입력해주세요'");
		email.focus();
		return false;
	}
	
	if(name.value == '') {
		alert("이름을 입력해주세요'");
		name.focus();
		return false;
	}
	
	if(mobile.value == '') {
		alert("휴대폰번호를 입력해주세요'");
		mobile.focus();
		return false;
	}
	
	form.submit();
		
};

function findIdResult(result) {
	
	if(result == 0) {
		alert("아이디 찾기에 실패하였습니다. 정보를 다시 확인해주시기 바랍니다");
		
	}
	
};

function findPwResult(result) {
	if(result == 0) {
		alert("비밀번호 찾기에 실패하였습니다. 정보를 다시 확인해주시기 바랍니다");
		
	}
}

function onlyNumber(data){
	data = data.replace(/[^0-9]/g, '');
	return data;
}


const getByteLengthOfString = function(s,b,i,c){
    for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
    return b;
};
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center align-items-center"
	id="sectionWrap">
	<div class="container">
		<h2 class="text-center">회원가입</h2>
		<div class="d-flex justify-content-between align-items-center pt-3">
			<label for="loginId">아이디</label> 
			<input type="text" class="form-control col-8 ml-3" id="loginId">
		</div>
		<div class="d-flex justify-content-end align-items-center pt-1">
			<div id="idStatusArea" class="mr-4"></div>
			<button type="button" class="btn btn-warning mr-0" id="isDuplicatedBtn">
				<small>중복확인</small>
			</button>
		</div>
		<div class="d-flex justify-content-between align-items-center pt-3">
			<label for="password">비밀번호</label> 
			<input type="password" class="form-control col-8 ml-3" id="password">
		</div>
		<div class="d-flex justify-content-between align-items-center pt-3">
			<label for="passwordConfirm">비밀번호 확인</label>
			<input type="password" class="form-control col-8 ml-3" id="passwordConfirm">
		</div>
		<div class="d-flex justify-content-between align-items-center pt-3">
			<label for="name">이름</label>
			<input type="text" class="form-control col-8 ml-3" id="name">
		</div>
		<div class="d-flex justify-content-between align-items-center pt-3">
			<label for="email">이메일 주소</label>
			<input type="text" class="form-control col-8 ml-3" id="email">
		</div>
		<button type="button" class="btn btn-success d-block w-100 mt-3" id="signUpBtn">회원가입</button>
	</div>
</div>

<script>
	$(document).ready(function() {
		$('#isDuplicatedBtn').on('click', function() {
			$('#idStatusArea').empty();
			let loginId = $('#loginId').val().trim();
			// 비어있는지 체크
			if (loginId == '') {
				alert('아이디를 입력하세요.');
				return;
			}
			
			// 아이디가 4자 이상인지 체크
			if (loginId.length < 4) {
				$('#idStatusArea').append("<small class='text-danger'>ID를 4자 이상 입력해주세요.</small>");
				return;
			}
			
			// ajax 서버 호출 (중복 여부)
			$.ajax({
				type: 'GET'
				, url : '/user/is_duplicated_id'
				, data : {"loginId" : loginId}
				, success : function(data) {
					if (data.result) {
						// 중복이다
						$('#idStatusArea').append("<small class='text-danger'>중복된 아이디입니다.</small>");
					} else {
						// 중복이 아니다.
						$('#idStatusArea').append("<small class='text-success'>사용가능한 아이디입니다.</small>");
					}
				}
				, error : function(e) {
					alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		$('#signUpBtn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			if (loginId == '') {
				alert('아이디를 입력하세요');
				return;
			}
			let password = $('#password').val().trim();
			let passwordConfirm = $('#passwordConfirm').val().trim();
			if (password == '' || passwordConfirm == '') {
				alert('비밀번호를 입력하세요.');
				return;
			}
			if (password != passwordConfirm) {
				alert('비밀번호가 일치하지 않습니다. 다시 입력해주세요');
				$('#password').val('');
				$('#passwordConfirm').val('');
				return;
			}
			let name = $('#name').val().trim();
			if (name == '') {
				alert('이름을 입력하세요');
				return;
			}
			let email = $('#email').val().trim();
			if (email == '') {
				alert('이메일을 입력하세요');
				return;
			}
			if ($('#idStatusArea').children('.text-success').text() == '') {
				alert('아이디 중복확인을 확인해주세요');
				return;
			}
			
			// 서버에 요청!!!
			let url = '/user/sign_up';
			let data = {
					"loginId" : loginId
					, "password" : password
					, "name" : name
					, "email" : email
			};
			// form 태그를 사용했을 경우
			/*
				let data = $('#signUpForm').serialize(); 폼태그에 있는 데이터를 한번에 보낼 수 있게 구성한다. 그렇지 않으면 json으로 구성을 해야한다.
			*/
			
			$.post(url, data)
			.done(function(data) {
				if (data.result == "success") {
					alert("가입을 환영합니다!!! 로그인 해주세요");
					location.href = "/user/sign_in_view";
				} else {
					alert("가입에 실패했습니다.");
				}
			});
		});
	});
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center align-items-center">
	<div id="sectionWrap">
		<div class="input-group">
			<div class="input-group-text">
				<img src="/static/images/user.png" alt="user" width="30">
			</div>
			<input type="text" class="form-control" id="loginId">
		</div>
		<div class="input-group pt-2">
			<div class="input-group-text">
				<img src="/static/images/key.png" alt="key" width="30">
			</div>
			<input type="password" class="form-control" id="password">
		</div>
		<button type="button" class="btn btn-primary d-block w-100 mt-3" id="loginBtn">로그인</button>
		<a href="/user/sign_up_view" class="btn btn-success d-block w-100 mt-2">회원가입</a> 
	</div>
</div>

<script>
	$(document).ready(function() {
		$('#loginBtn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			if (loginId == '') {
				alert('아이디를 입력하세요');
				return;
			}
			let password = $('#password').val().trim();
			if (password == '') {
				alert('비밀번호를 입력하세요');
			}
			
			/*
				form 태그로 했을 경우
				let url = $(this).attr('action');
				let data = $(this).serialize(); // form의 name 속성으로 data를 구성한다.
			*/
			
			$.ajax({
				type : "post"
				, url : '/user/sign_in'
				, data : {
					'loginId' : loginId
					, 'password' : password 
				}
				, success : function(data) {
					if (data.result == "success") {
						location.href = "/post/post_list_view";
					} else {
						alert('로그인 실패');
						$('#password').val('');
					}
				}
				, error : function(e) {
					alert('로그인이 되지 않습니다. 관리자에게 문의해주세요');
				}
			});
		});
	})
</script> 
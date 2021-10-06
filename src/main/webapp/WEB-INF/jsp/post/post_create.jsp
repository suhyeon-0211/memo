<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center align-items-center" id="sectionWrap">
	<div class="w-50">
		<h1>글쓰기</h1>
		<div>
			<input type="text" class="form-control" placeholder="제목을 입력해주세요" id="subject">
			<textarea class="form-control" rows="15" cols="100" placeholder="내용을 입력해주세요" id="content"></textarea>
		</div>
		<div class="d-flex justify-content-end">
			<input type="file" id="file" accept=".jpg,.jpeg,.png,.gif">
		</div>
		<div class="d-flex justify-content-between">
			<div>
				<a href="/post/post_list_view" class="btn btn-dark">목록</a>
			</div>
			<div>
				<button type="button" id="clearBtn" class="btn btn-secondary">모두 지우기</button>
				<button type="button" id="saveBtn" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 모두지우기 버튼 클릭
		$('#clearBtn').on('click', function() {
			// 제목 input, 내용 textarea 영역을 빈칸으로 만든다.
			if(confirm("내용을 지우시겠습니까?")) {
				$('#subject').val('');
				$('#content').val('');
			}
		});
		
		// 저장 버튼 클릭
		$('#saveBtn').on('click', function() {
			let subject = $('#subject').val().trim();
			if (subject == '') {
				alert('제목을 입력하세요');
				return;
			}
			let content = $('#content').val();
			if (content == '') {
				alert('내용을 입력하세요');
				return;
			}
			
			// 파일이 업로드 된 경우에 확장자 검사
			let file = $('#file').val();
			console.log('file:' + file);
			if (file != '') {
				//console.log(file.split('.')); // 파일명을 . 기준으로 자른다.(배열에 저장)
				let ext = file.split('.').pop().toLowerCase(); // 스택구조에서 제일 마지막 요소를 꺼낸후 소문자로 변환
				if ($.inArray(ext, ['jpg', 'png', 'jpeg', 'gif']) == -1) {
					alert('이미지 파일만 업로드 할 수 있습니다.');
					$('#file').val(''); // 잘못된 파일을 비운다.
					return;
				}
			}
			console.log($('#file'));
			
			// 폼태그를 자바스크립트에서 만든다.
			let formData = new FormData();
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			// ajax
			$.ajax({
				type: 'post'
				, url : '/post/create'
				, data : formData
				, enctype : 'multipart/form-data' // 파일 업로드 필수 설정
				, processData : false // 파일 업로드 필수 설정
				, contentType : false // 파일 업로드 필수 설정
				, success : function(data) {
					if (data.result == 'success') {
						alert('메모가 저장됐습니다.');
						location.href="/post/post_list_view";
					}
				}
				, error : function(e) {
					alert('저장 에러' + e);
				}
			});
		});
	});
</script>
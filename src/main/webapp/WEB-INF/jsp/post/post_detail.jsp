<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center align-items-center" id="sectionWrap">
	<div class="w-50">
		<h1>글 상세 수정</h1>
		<input type="text" id="subject" class="form-control" value="${post.subject}">
		<textarea class="form-control" rows="10" id="content">${post.content}</textarea>
		
		<%-- 이미지가 있을 때만 이미지 영역 추가 --%>
		<c:if test="${not empty post.imagePath}">
		<div>
			<img src="${post.imagePath}" alt="업로드 이미지" width="300">
		</div>
		</c:if>
		<div class="d-flex justify-content-end">
			<input type="file" id="file" accept=".jpg,.jpeg,.png,.gif">
		</div>
		<div class="d-flex justify-content-between">
			<div>
				<a href="#" id="delBtn" class="btn btn-secondary" data-post-id="${post.id}">삭제</a>
			</div>
			<div>
				<button type="button" id="toListBtn" class="btn btn-dark">목록으로</button>
				<button type="button" id="saveBtn" class="btn btn-primary" data-post-id="${post.id}">수정</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 목록으로 버튼 클릭
		$('#toListBtn').on('click', function() {
			if (!confirm('목록으로 이동하시겠습니까?')) {
				return;
			}
			location.href="/post/post_list_view";
		});
		
		// 수정 버튼 클릭
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
			
			let fileName = $('#file').val();
			if (fileName != '') {
				let ext = fileName.split('.').pop().toLowerCase();
				if ($.inArray(ext, ['jpg', 'png', 'jpeg', 'gif']) == -1) {
					alert('이미지 파일만 업로드 할 수 있습니다.');
					$('#file').val('');
					return;
				}
			}
			
			let postId = $(this).data('post-id');
			
			// 폼태그를 자바스크립트에서 만든다.
			let formData = new FormData();
			formData.append("postId", postId);
			formData.append("subject", subject);
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
			// ajax 통신으로 서버에 전송한다.
			$.ajax({
				type : 'put'
				, url : '/post/update'
				, data : formData
				, enctype : 'multipart/form-data'
				, processData : false
				, contentType : false
				, success : function(data) {
					if (data.result == "success") {
						alert('메모 수정에 성공했습니다.');
						location.reload(true); // 새로고침
					} else {
						alert('메모 수정에 실패했습니다.');
					}
				}
				, error : function(e) {
					alert("관리자에게 문의해주세요");
				}
			})
		});
		
		$('#delBtn').on('click', function(e) {
			e.preventDefault(); // 화면 상단으로 올라가는 것 방지
			let postId = $(this).data('post-id');
			
			// ajax 통신으로 삭제 요청
			$.ajax({
				type : 'delete'
				, url : '/post/delete'
				, data : {'postId' : postId}
				, success : function(data) {
					if (data.result == 'success') {
						alert("삭제 완료");
						location.href="/post/post_list_view";
					} else {
						alert('삭제 불가');
					}
				}
				, error : function(e) {
					alert('삭제가 불가합니다. 관리자에게 문의해주세요');
				}
			})
		})
	});
</script>
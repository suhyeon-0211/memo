<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="d-flex justify-content-center align-items-center" id="sectionWrap">
	<div>
		<table class="table table-bordered text-center">
			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>작성날짜</th>
					<th>수정날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${postList}" var="post">
					<tr>
						<td>${post.id}</td>
						<td>${post.subject}</td>
						<td><fmt:formatDate value="${post.createdAt}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/></td>
						<td>${post.updatedAt}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-around">
			<button type="button" class="btn btn-success">이전</button>
			<button type="button" class="btn btn-success">다음</button>
		</div>
		<div class="d-flex justify-content-end">
			<a href="/post/post_create_view" class="btn btn-success">글쓰기</a>
		</div>
	</div>
</div>


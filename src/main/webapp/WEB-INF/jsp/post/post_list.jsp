<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="d-flex justify-content-center align-items-center" id="sectionWrap">
	<div>
		<table class="table table-bordered table-hover text-center">
			<thead>
				<tr>
					<th width="250px">No.</th>
					<th width="250px">제목</th>
					<th width="250px">작성날짜</th>
					<th width="250px">수정날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${postList}" var="post">
					<tr>
						<td>${post.id}</td>
						<td><a href="/post/post_detail_view?postId=${post.id}">${post.subject}</a></td>
						<td>
							<%--Date 객체로 내려온 값을 String Format으로 변경해서 출력 --%>
							<fmt:formatDate value="${post.createdAt}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/>
						</td>
						<td><fmt:formatDate value="${post.updatedAt}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="d-flex justify-content-around">
			<c:if test="${prevId ne 0}">
				<a href="/post/post_list_view?prevId=${prevId}">&lt;&lt; 이전</a>
			</c:if>
			<c:if test="${nextId ne 0}">
				<a href="/post/post_list_view?nextId=${nextId}">다음 &gt;&gt;</a>
			</c:if>
		</div>
		<div class="d-flex justify-content-end">
			<a href="/post/post_create_view" class="btn btn-success">글쓰기</a>
		</div>
	</div>
</div>


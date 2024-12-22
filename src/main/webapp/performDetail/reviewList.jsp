<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.*" %>
<%@page import="dto.UserDTO" %>
<%@page import="common.LoginManager" %>
<%
		UserDTO user = LoginManager.getUser();
    List<ReviewDTO> reviews = (List<ReviewDTO>) request.getAttribute("reviews");
    for (ReviewDTO review : reviews) {
%>
    <div class="d-flex container border-primary border-2 border-bottom pb-3 my-3">
        <div class="container border d-flex flex-column py-3" style="width: 195px; height: 210px; ">
            <div id="profile" class="container border mx-auto my-0"  style="font-family:'SeoulNamsanM';">사진</div>
            <div id="nickname" class="container border">
            
                <h5 class="text-center m-0"  style="font-family:'Jeju Gothic';"><%= review.getNickname() %></h5>
            </div>
            <div id="starpoint" class="container border" >
                <p class="text-center m-0"style="font-family:'Jeju Gothic';">별점 <%= review.getStar_num() %></p>
            </div>
        </div>
        <div class="border border-primary-subtle" style="width: 1px; height: 210px;"></div>
        <div class="container border p-2 my-auto" style="width: 972px;">
            <div class="border ms-1 mt-1 review_content">
                <%= review.getContents() %>
            </div>
            <div class="border ms-1 d-flex review_subcontent">
<%--                 <p class="me-auto my-auto"><%= review.getFormattedCreateAt() %></p> --%>
<%--                 <button class="btn btn-outline-primary p-1 me-2" onclick="submitReview('like', <%= review.getId() %>)">좋아요</button> --%>
<%--                 <button class="btn btn-danger p-1" onclick="deleteReview(<%= review.getId() %>)">신고</button> --%>
								// FIXME:JHK - review 병합시 확인필요
                <button class="btn btn-danger p-1" onclick="reportReview(<%= review.getId() %>)">신고</button>

                <% if (user != null && user.getEmail().equals(review.getEmail())) { %>
                    <button class="btn btn-warning p-1 ms-2" onclick="showEditForm(<%= review.getId() %>)">수정</button>
                    <button class="btn btn-danger p-1 ms-2" onclick="deleteReview(<%= review.getId() %>)">삭제</button>
                <% } %>
            </div>

            <div id="editForm_<%= review.getId() %>" class="edit-form" style="display: none;">
                <textarea class="form-control" name="contents" style="height: 100px; resize: none;"><%= review.getContents() %></textarea>
                <select name="star_num">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
                <button type="button" class="btn btn-outline-primary mt-2" onclick="updateReview(<%= review.getId() %>)">수정 완료</button>
            </div>
        </div>
    </div>
<%
    }
%>

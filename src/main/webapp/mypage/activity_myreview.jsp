<%@page import="dto.PerformDTO"%>
<%@page import="dao.PerformDAO"%>
<%@page import="common.LoginManager"%>
<%@page import="dto.UserDTO"%>
<%@page import="dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	UserDTO user = LoginManager.getUser();
	ReviewDAO reviewdao = new ReviewDAO();
	List<ReviewDTO> reviews = reviewdao.getReviewByUser(user.getEmail());
	reviewdao.close();
	
	if(reviews == null || reviews.isEmpty()){
%>
		<p>작성한 한줄평이 없습니다.</p>
	<%
	}else{
		for(ReviewDTO review : reviews){
			//아이디로 연극명 뽑아내기
			PerformDAO performdao = new PerformDAO();
			PerformDTO performdto = performdao.getPerformName(review.getPerform_detail_id());
			performdao.close();
	%>
		<div class="reviewitem">
          <a href="../performDetail/performDetail.jsp?id=<%=performdto.getPerform_Detail_id()%>" id="reviewLink<%=review.getId()%>">
            <div class="rating-container">
              <h3><%=performdto.getName().length() > 10 ?performdto.getName().substring(0, 10)+"..." : performdto.getName() %></h3>
              <div class="rating">
                <span class="star" data-value="1">&#9733;</span>
                <span class="star" data-value="2">&#9733;</span>
                <span class="star" data-value="3">&#9733;</span>
                <span class="star" data-value="4">&#9733;</span>
                <span class="star" data-value="5">&#9733;</span>
              </div>
            </div>

            <p id="reviewText<%=review.getId()%>"><%=review.getContents().length() > 30 ? review.getContents().substring(0, 30)+"..." : review.getContents() %></p>
       		  <textarea rows="2" id="reviewTA<%=review.getId()%>" style="display:none; width:245px;"><%=review.getContents() %></textarea>
            <p id="reviewDate<%=review.getId()%>"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(review.getCreate_at()) %></p>
          </a>
          <img class="reviewEdit" src="../resources/image/edit.png" alt="수정" onclick="showEdit(<%=review.getId() %>, event)" />
          <img
            class="reviewDelete"
            src="../resources/image/delete.png"
            alt="삭제"
            onclick="deleteReview('<%=review.getId() %>', '<%=user.getEmail() %>')"
          />
          <button class="editsavebtn" id="saveButton<%=review.getId() %>" style="display:none;" onclick="saveReview(<%=review.getId() %>)" type="button">수정 완료</button>
          <%if(review.getRepot_state() == 2) {%>
	        	<span class="report">신고된 글입니다. 자세한 사항은 Q&A로 문의해주세요.</span>
	       	<%} %>
  	 </div>
   <%
			}
		}
   %>

<script src="../resources/js/activity_myreview.js"></script>
   
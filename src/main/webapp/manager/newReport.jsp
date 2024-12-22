<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->


<style>
@charset "UTF-8";

.report-item{
	position: relative;
/* 	padding:10px; */
}
.report-item > .border{
	display: flex;
	height:100px;
	justify-content: space-between;
	align-items: center;
	justify-content: center;
	padding: 10px;
	margin: 10px 10px 0px 10px;
	background-color: rgb(231, 231, 231);
	border-top: 1px solid #4e92f1;
	border-bottom: 1px solid #4e92f1;
}
.report-item .column1  {
	width: 20%;
	display: flex;
	white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis;
/* 	flex-direction: column; */
}
.report-item .column2 {
	width: 25%;
	display: flex;
/* 	flex-direction: column; */
	white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis;
}
.report-item .column3 {
	width: 35%;
	text-align: left;
	white-space: nowrap; 
    overflow: hidden;
    text-overflow: ellipsis;
}
.report-item > .border > p{
	padding:20px;
}
h3, h4{
	margin:0;
	display:inline;
}
.report-item a {
    text-decoration: none; /* ???? ???? */
    color: inherit; /* ?θ? ????? ???? ???? ??? */
}

.report-item a:link, 
.report-item a:visited {
    color: inherit; /* ??? ???? ??? */
}

.report-item img.report-pass{
    position: absolute;
    width: 30px;
    height: 30px;
    right: 11.5%;
    top: 33%;
    /* margin-right: 10px; */
    cursor: pointer;
}
.report-item img.report-blind{
    position: absolute;
    width: 40px;
    height: 40px;
    right: 5%;
    top: 26%;
    cursor: pointer;
}
.report-item .writer,
.report-item .reporter,
.report-item .write-type{
	display:flex;
	font-size: 18px;
/* 	font-weight: bold; */
}

,
.report-item .report-date{
	font-size: 15px;
	color: #808080;
	margin-top: 5px;
}
.report-item .report-content{
	font-size: 15px;
	margin-top: 10px;
}



</style>
<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
    
<!-- insertReportIte()에서 new-report-list에 넣어준다.     -->
<div id="new-report-list">

<!-- 수정용 샘플입니다, 지우지마세요, 항상 var reportItem = 동기화 하세요 -->
<!-- <div class="report-item"> -->
<!-- 	<div class="border"> -->
<!-- 		<div class="column2"> -->
<!-- 			<a href="#"> -->
<!-- 				<p class="writer">r.writerName</p> -->
<!-- 				<p class="reporter">r.reporterName</p> -->
<!-- 				<p class="report-date">formattedDate</p> -->
<!-- 			</a> -->
<!-- 		</div> -->
<!-- 		<div class="column3"> -->
<!-- 			<p class="write-type">type</p> -->
<!-- 			<p class="report-content">r.report.reason</p> -->
<!-- 		</div> -->
<!-- 		<div class="column1"> -->
<!-- 			<img class="report-pass" data-report-id="r.report.id" -->
<!-- 			 src="../resources/image/report_actionPass.png" alt="신고글 패스" /> -->
<!-- 			<img class="report-blind" data-report-id="r.report.id" -->
<!-- 			 src="../resources/image/report_actionBlock.png" alt="신고글 블라인트" /> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->


</div>

<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->
<!-- /////////////////////////////////////////////////////////// -->

			
			
<script src="../resources/js/newReport.js"></script>























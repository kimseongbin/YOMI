<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*,com.spring.madi.*"%>
<%@page import="com.spring.madi.MessageVO"%>
<%@page import="com.spring.madi.NotificationVO"%>
<%@page import="com.spring.madi.MemberVO"%>
<% 
	// Header에 들어갈 기본 정보 불러오기
	MemberVO memberVO= (MemberVO)request.getAttribute("memberVO");
	// 메시지 리시트 받아오기 
	ArrayList<MessageVO> messageList = (ArrayList<MessageVO>) request.getAttribute("messageList");
	// 알림 리스트 받아오기
	ArrayList<NotificationVO> notificationList = (ArrayList<NotificationVO>) request.getAttribute("notificationList");
	// 내 재료 목록 받아오기
	ArrayList<MemberBoxVO> myIrdntList = (ArrayList<MemberBoxVO>) request.getAttribute("myIrdntList");
	
	// myPage에서 사용할 기본 정보 
	// 내 팔로워 리스트 
	List<MemberFollowVO> followerList= (ArrayList<MemberFollowVO>)request.getAttribute("followerList");
	// 내가 팔로잉 리스트
	List<MemberFollowVO> followingList= (ArrayList<MemberFollowVO>)request.getAttribute("followingList");
	// 팔로잉 추천 리스트
	List<MemberFollowVO> recommendList= (ArrayList<MemberFollowVO>)request.getAttribute("recommendList");
	// 나의 게시판 목록
	List<BoardVO> myBoardList= (ArrayList<BoardVO>)request.getAttribute("myBoardList");
	// 팔로워 + 나 자신의 글 목록 불러옴
	List<BoardVO> allBoardList= (ArrayList<BoardVO>)request.getAttribute("allBoardList");

	
	//INCLUDE JSP 문서와 객체 공유
	request.setAttribute("memberVO", memberVO);
	request.setAttribute("notificationList", notificationList);
	request.setAttribute("messageList", messageList);
	request.setAttribute("myIrdntList", myIrdntList);

%>
<!DOCTYPE>
<html>
<head style="position: relative; z-index: 1; height: 260px;  margin:0 auto;">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마디 - 재료로  요리하다</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.glyphicon.glyphicon-comment {
	color: #4C4C4C;
}

.glyphicon.glyphicon-heart {
	color: #DB005B;
}

.glyphicon.glyphicon-pencil {
	color: #3D3D3D;
}

.glyphicon.glyphicon-share-alt {
	color: #487BE1;
}
.glyphicon.icon-size {
	font-size: 25px;
}
/*table 디자인*/
table {
	border-radius: 10px;
}
/* 테이블 간격 */
td {
	padding: 10px;
}
/*본문 배경색*/
.well.content_color{
 	background-color:#FFFFFF;
}
/* 냉장고 재료들 리스트 정렬 */
.ul.hori {
    list-style:none;
    margin:0;
    padding:0;
}

.li.hori {
    margin: 0 0 0 0;
    padding: 15px;
    border : 0;
    float: left;
    font-size:15px;
}
/* 팔로워, 팔로잉 리스트 정렬 */
.ul.fol {
    list-style:none;
    margin:0;
    padding:0;
}

.li.fol {
    margin: 0 0 0 0;
    padding: 19px;
    border : 0;
    float: left;
    font-size:17px;
}
/* 팔로우 추천 정렬 */
.ul.fol2 {
    list-style:none;
    margin:0;
    padding:0;
}
.li.fol2 {
    padding: 4px;
    font-size:17px;
}
/* 본문 아이콘 정렬 */
.li.fol3 {
    padding: 2px;
    float: left;
    border : 0;
    margin: 0 0 0 0;
}

/* follow 모달 크기 조절 */
.modal-dialog.follow-size {
    width: 470px;
    height: 50%;
    margin: 0;
    padding: 0;
}
.modal-content.follow-size {
    height: auto;
    min-height: 50%;
}
.modal.modal-center {
	    text-align: center;
}
@media screen and (min-width: 768px) {
    .modal.modal-center:before {
        display: inline-block;
        vertical-align: top;
        content: " ";
        height: 100%;
    }
}
.modal-dialog.modal-center {
    display: inline-block;
    text-align: left;
    vertical-align: top;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script>
	function deleteFollowing(user_id, following_user_id) {
		//location.href="deleteFollowing.do?user_id=" + user_id + "&following_user_id=" + following_user_id;
		//alert("팔로잉 삭제 성공");
		var content = user_id+ "님께서 " + following_user_id+ "님을 팔로우 취소했습니다."
		$.ajax({
			url: "./deleteFollowing.do",
			type: "GET",
			data: {
				user_id: user_id,
				following_user_id: following_user_id,
				notice_to : following_user_id,
				notice_from : user_id,
				content : content,
				notice_type : "팔로잉 삭제"
			},
			dataType: "text",
			success: function(data) {
				alert(data);
				$("#following_modal").empty();
				$("#following_modal").append(data);
				followingMinus();
			}
		});
	}
	function deleteFollower(user_id, following_user_id) {
		//location.href="deleteFollowing.do?user_id=" + user_id + "&following_user_id=" + following_user_id;
		//alert("팔로워 삭제 성공");
		var content= user_id+ "님께서 " + following_user_id+ "님의 팔로우를 취소했습니다."
		$.ajax({
			url: "./deleteFollower.do",
			type: "GET",
			data: {
				user_id: user_id,
				following_user_id: following_user_id,
				notice_to : following_user_id,
				notice_from : user_id,
				content : content,
				notice_type : "팔로워 삭제"
			},
			dataType: "text",
			success: function(data) {
				alert(data);
				/* location.href="./mypage.do"; */
				$("#follower_modal").empty();
				$("#follower_modal").append(data);
				followerMinus();
			}
		});
	}	
	function insertFollowing(user_id, following_user_id, user_img, following_user_img) {
		//location.href="insertFollowing.do?user_id=" + user_id + "&following_user_id=" + following_user_id +
		//"&user_img=" + user_img + "&following_user_img=" + following_user_img;
		//alert("팔로잉 추가 성공");
		var content= user_id+ "님께서 " + following_user_id+ "님을 팔로우 했습니다."
		$.ajax({
			url: "./insertFollowing.do",
			type: "POST",
			data: {
				user_id: user_id,
				following_user_id: following_user_id,
				user_img: user_img,
				following_user_img: following_user_img,
				notice_to : following_user_id,
				notice_from : user_id,
				content : content,
				notice_type : "팔로잉 추가"
			},
			dataType: "text",
			success: function(data) {
				alert(data);
				location.href="./mypage.do";
				//location.href="./mypage.do";
				//$("#insertFollowing_modal").empty();
				//$("#insertFollowing_modal").append(data);
			}
		});
	}
	function updateBoardLike(board_num, user_id, index) {
		//location.href="updateBoardLike.do?user_id=" + user_id;
		
		var content= user_id+ "님께서" +board_num+ "번 게시물에 좋아요를 입력했습니다.";
		$.ajax({
			url: "./updateBoardLike.do",
			type: "GET",
			data: {
				user_id: user_id,
				board_num: board_num,
				notice_to : board_num,
				notice_from : user_id,
				content : content,
				notice_type : "좋아요 입력"
			},
			success: function(data) {
				/* location.href="./mypage.do"; */
				//alert("success");
				if (data == 0) {
					alert("좋아요 실패");
					document.getElementsByClassName("boardLike")[index].innerHTML = Number(document.getElementsByClassName("boardLike")[index].innerHTML) - 1;
				} else {
					alert("좋아요 성공");
					document.getElementsByClassName("boardLike")[index].innerHTML = Number(document.getElementsByClassName("boardLike")[index].innerHTML) + 1;				
				}
			}
		});
	}
</script>
</head>
<body style="background-color: #FFFFFF;">
	<!-- 헤더 시작 -->
	<div class="header">
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<!-- 헤더 끝 -->
	<!-- 내용 시작 -->
	<div class="container">		
		<div class="row">
		<!--left side -->
			<div class="col-sm-1"></div>
			<div class="col-sm-3 text-center" style="border-radius: 10px;">
				<div>
					<img src="<%=memberVO.getUser_img()%>" class="img-circle" height="80" width="80"
						alt="Avatar" style="margin-left:7px;"> <br>
					<h3 class="text-primary" style="padding-left:10px; margin-top:10px;">
						<strong><%=memberVO.getUser_id()%></strong>
					</h3>
					<strong style="font-size:17px; padding-left:20px;"><%=memberVO.getUser_email()%></strong>
					
					<!-- 게시글, 팔로워, 팔로잉 -->
					<div class="row text-center">
                    	<div class="col-sm-2"></div>
						<div class="col-sm-3">
							<p data-target="#myboards" data-toggle="modal" style="cursor: pointer; margin-bottom: 0px;">
							<strong class="bg-danger" style="font-size:14px;">게시글</strong>
                            <br></p>
                            <div style="font-size:15px;">
                            <p style="cursor: pointer;" data-toggle="modal" data-target="#myboards">
                            <%=myBoardList.size()%>
                            </p>
                            </div>
						</div>
						<div class="col-sm-3">
							<p style="cursor: pointer; margin-bottom: 0px;" data-toggle="modal" data-target="#following">
							<strong class="bg-danger" style="font-size:14px;">팔로잉</strong>
                            <br></p>
                            <div id="followingSize" style="font-size:15px;">
                            <p style="cursor: pointer;" data-toggle="modal" data-target="#follower">
                            <%=followingList.size()%>
                            </p>
                            </div>
						</div>
						<div class="col-sm-3">
							<p style="cursor: pointer; margin-bottom: 0px;" data-toggle="modal" data-target="#follower">
							<strong class="bg-danger" style="font-size:14px;">팔로워</strong>
                            <br></p>
                            <div id="followerSize" style="font-size:15px;">
                            <p style="cursor: pointer;" data-toggle="modal" data-target="#follower">
                            	<%=followerList.size()%>
                            </p>
                            </div>
                            
						</div>
                        
					</div>
					<br>
				<!-- 내 게시글 -->
				<div class="modal fade" id="myboards" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header" style="background-color: #DE4F4F;">
								<h3 class="modal-title">
								<strong style="color:#FFFFFF;">게시글 목록</strong>
								</h3>
							</div>
							<div class="modal-body">
							
								<%
									for(int i=0; i<allBoardList.size(); i++) {
									BoardVO board= allBoardList.get(i);
								%>
								
										
								<%	} %>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 팔로잉 Modal -->
				<div class="modal fade" id="following" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header" style="background-color: #DE4F4F;">
								<h3 class="modal-title">
									<strong style="color:#FFFFFF;">Following 목록</strong>
								</h3>
							</div>
							<!-- 팔로잉 삭제 목록 Content -->
							<div class="modal-body">
								<div class="btn-group-vertical">
									<form>
										<ul class="ul fol" id="following_modal" style="text-align:center;">
											<%for(int j= 0; j<followingList.size(); j++) {
												MemberFollowVO following= followingList.get(j);
											%>
												<li class="li fol">
											        <img src="<%=following.getFollowing_user_img()%>" class="img-circle" height="40"
													width="40">&nbsp;<a href="#"><strong><%=following.getFollowing_user_id()%></strong></a>

													&nbsp;
													<button type="button" class="btn btn-danger btn-sm"
													onclick="deleteFollowing('<%=following.getUser_id()%>', '<%=following.getFollowing_user_id()%>')"
													style="border-radius: 20px;"><strong>삭제</strong></button>
											    </li>
										    <%} %>
									    </ul>
									</form>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- 팔로워 모달 -->
				<div class="modal fade" id="follower" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header" style="background-color: #DE4F4F;">
								<h3 class="modal-title">
									<strong style="color:#FFFFFF;">Follower 목록</strong>
								</h3>
							</div>
							<!-- 팔로워 삭제 목록 Content -->
							<div class="modal-body">
								<div class="btn-group-vertical">
									<form>
										<ul class="ul fol" id="follower_modal" style="text-align:center;">
											<%for(int i= 0; i< followerList.size(); i++) {
												MemberFollowVO follower= followerList.get(i);
											%>
												<li class="li fol">
											        <img src="<%=follower.getUser_img()%>" class="img-circle" height="40"
													width="40">&nbsp;<a href="#"><strong><%=follower.getUser_id()%></strong></a>
													&nbsp;
													<button type="button" class="btn btn-danger btn-sm"
													onclick="deleteFollower('<%=follower.getUser_id()%>', '<%=follower.getFollowing_user_id()%>')"
													style="border-radius: 20px;"><strong>삭제</strong></button>
											    </li>
										   <%} %>
									    </ul>
								   </form>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 팔로워 추천 -->
			<div style="margin-top: 20%; margin-left:15px; font-size:18px;">
				<p style="margin-bottom:10px;">
					<strong>팔로워 추천   &nbsp;<a href="#" style="cursor:pointer" class="moreRecommends" id="refresh">새로고침</a></strong>
				</p>
				<div id="recommend_area" class="btn-group-vertical" style="font-size: 17px; background-color: #FFFFFF">
				<!-- reloadRecommend.jsp에서 불러옴?? -->
					<form>	
						<ul class="ul fol2">
							<%for(int y= 0; y< recommendList.size(); y++) {
								MemberFollowVO recommend= recommendList.get(y);
								
								if(y%3==0) {
							%>
									<div class="recommends">
							<%
								}
							%>
								<li class="li fol2">
									<img src="<%=recommend.getFollowing_user_img()%>" class="img-circle" height="40"
									width="40">&nbsp; <a href="#">
									<strong><%=recommend.getFollowing_user_id()%></strong></a>
									&emsp;
									<button type="button" class="btn btn-danger btn"
									onclick="insertFollowing('<%=memberVO.getUser_id()%>', 
									'<%=recommend.getFollowing_user_id()%>',
									'<%=memberVO.getUser_img()%>', '<%=recommend.getFollowing_user_img()%>')"
									style="border-radius: 10px;">
									<strong style="font-size:15px;">팔로우</strong>
									</button>&nbsp;
								</li>
								
							<%
								if(y%3==2 || y == (recommendList.size() -1) ) {
							%>
									</div>
							<%
								}
							} // recommendList for 
							%>
						</ul>
					</form>
				</div>
			</div>
			<script>
				$(document).ready(function() {
					var div = document.getElementsByClassName("recommends");
					for (var int = 0; int < div.length; int++) {
						if(int == 0) {
							div[int].style.display = "block";
						} else {
							div[int].style.display = "none";
						}
					}
					var currentLocation = 0;
					$("#refresh").click(function() {
						currentLocation += 1;
						if(currentLocation == div.length) {
							div[div.length-1].style.display = "none";
							div[0].style.display = "block";
							currentLocation = 0;
						} else {
							div[currentLocation-1].style.display = "none";
							div[currentLocation].style.display = "block";
						}
					});
				});
			</script>
			<br>
		</div>
		<!-- middle side -->
		<div class="col-sm-6">
			<div class="row text-center" style="border-radius: 10px;">
				<!-- 본문 글 시작 -->
				<%
					for(int i=0; i<allBoardList.size(); i++) {
						BoardVO board= allBoardList.get(i);
				%>
				<div class="well content_color">
					<div class="row">
						<div class="col-sm-4" style="font-size: 16px; text-align: left;">
						<!-- profile -->
							<img src="<%=board.getUser_img()%>" class="img-circle" height="40" width="40">&nbsp;<a
								href="#"><strong><%=board.getUser_id()%></strong></a>
						</div>
						<!-- title -->
						<div class="col-sm-8" style="text-align: left;">
							<p>
								<strong style="font-size:25px;"><%=board.getBoard_title()%></strong>
							</p>
						</div>
					</div>
					<!-- image and date, like-->
					<img src="<%=board.getBoard_img()%>" style="width:40%; height:40%;" class="img-squere"><br>
					<div class="row">
						<table style="border-spacing: 20px; font-size: 17px;">
							<tr>
								<td>
									<p>
										<%=board.getBoard_time()%>
									</p>
								</td>
								<td><span class="glyphicon glyphicon-heart"
									style="padding-bottom: 14px;"></span></td>
								<td>
									<p style="padding-bottom: 3px;">
										<em class="boardLike"><%=board.getBoard_like()%></em>
									</p>
								</td>
							</tr>
						</table>
					</div>
					<!-- 글 내용 -->
					<div class="row">
						<p style="font-size: 17px;"><%=board.getBoard_summry()%></p>
					</div>
					<br>
					<br>
					<!-- Icon -->
					<div class="row">
						<div class="pull-right">
							<form>
							<ul class="ul fol2" id="updateBoardLike_modal">
								<li class="li fol3">
									<span style="cursor: pointer" 
									class="glyphicon glyphicon-comment icon-size"
									data-toggle="collapse" data-target="#comment<%=board.getBoard_num()%>">
									</span>&emsp;
								</li>
								<li class="li fol3">
									<span style="cursor: pointer"  
										class="glyphicon glyphicon-heart icon-size"
										onclick="updateBoardLike('<%=board.getBoard_num()%>', '<%=memberVO.getUser_id()%>', '<%=i%>')">
									</span> &emsp;
								</li>
								<li class="li fol3">
									<span style="cursor: pointer" 
									 class="glyphicon glyphicon-share-alt icon-size">
									</span>&emsp; 
								</li>
							</ul>
							</form>
						</div>
					</div> 
				<!-- 댓글 comment -->
					<div id="comment<%=board.getBoard_num()%>" class="collapse">
						<ul class="list-group" style="text-align: left;">
						<%
							List<BoardReplyVO> replyList = board.getBoardReplyList(); 
							for(int j = 0; j < replyList.size(); j++) {
								BoardReplyVO reply= replyList.get(j);
						%>
							<li class="list-group-item">
								<img src="<%=reply.getUser_img()%>"
								class="img-circle" height="30" width="30">&nbsp; <a
								href="#"><strong><%=reply.getUser_id()%></strong></a> &emsp;
								<strong><%=reply.getRep_content()%></strong>
							</li>
						<%
						} // for replyList
						%>
						</ul>
					</div>
				<!-- 본문 글 끝 -->
				</div>
				<%
				} // for allBoardList
				%>
			</div>
		</div>
	</div>
</div>
	<footer class="container-fluid text-center">
	<p>MADI</p>
	</footer>
</body>
</html>
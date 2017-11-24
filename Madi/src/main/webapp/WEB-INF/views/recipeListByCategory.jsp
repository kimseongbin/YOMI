<%@page import="com.spring.madi.RecipeVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList<RecipeVO> recipeList = (ArrayList<RecipeVO>)request.getAttribute("recipeList");
%>
<%
	if(recipeList == null) {
%>
	<hr/>
	<h3>조건에 맞는 레시피가 없습니다.</h3>
	<hr/>
<%
	} else {
		
		for(int i = 0; i < recipeList.size(); i++) {
			
			RecipeVO recipeVO = recipeList.get(i);
%>			
<%
			if(i % 8 == 0) {
%>
				<div class="category">
<%
			}
%>
				<div class="col-sm-3 col-lg-3s">
				   <div class="thumbnail">
				   	  <!-- 이미지 링크 recipe_id값 전달 클릭 시 recipe_detail화면으로-->
				      <a href="./recipeDetail.do?recipe_id=<%=recipeVO.getRecipe_id()%>"><img src="<%=recipeVO.getImg_url() %>" class="img-responsive" style="width:100%; height:234px; z-index:1;" alt="Image"></a>
				      <div class="container-fluid" style="margin-top:-33px; z-index:5; position:relative; padding-left:0; padding-right:0; height:180px; overflow:hidden;">
				      	<!-- user_id 링크 -->
				      	<img src="./resources/profile/bird.jpg" class="img-circle" height="61" width="61" alt="Avatar">
				        <p><strong><%=recipeVO.getUser_id() %></strong></p>
				        <h5><b><%=recipeVO.getRecipe_title() %></b></h5>
				        <span><%=recipeVO.getRecipe_desc() %></span>
				      </div>

				       <div class="container-fluid" style="padding:0;">
				        	<div class="col-xs-4 col-sm-4 text-muted" style="padding-left:0; padding-right:0;">
				            	<button class="btn" style="background:white; border:none; outline:none;">
				                	<span class="glyphicon glyphicon-home" style="font-size:10px;"></span>&nbsp; <%=recipeVO.getCooking_time() %>
				                </button>
				            </div>
				            <div class="col-xs-4 col-sm-4 text-muted" style="padding-left:0; padding-right:0;">
				            	<button class="btn" style="background:white; border:none; outline:none;">
				                	<span class="glyphicon glyphicon-home" style="font-size:10px;"></span>&nbsp; 좋아요
				                </button>
				            </div>
				            <div class="col-xs-4 col-sm-4 text-muted" style="padding-left:0; padding-right:0;">
				            	<button class="btn" style="background:white; border:none; outline:none;">
				                	<span class="glyphicon glyphicon-home" style="font-size:10px;"></span>&nbsp; 공유
				                </button>
				            </div>
				        </div>
				    </div>
	    		</div>
<%
			if(i%8==7 || i==(recipeList.size()-1)) {    		
%>
				</div>
<%
			} // if
%>
<%
		} // for
%>
		<button class="btn btn-default btn-block moreOfCategory">더보기</button>
<%
	} // else
%>
	<script>
	$(document).ready(function() {
		var category = document.getElementsByClassName("category");
		for(var i = 0; i < category.length; i++) {
			if(i==0) {
				category[i].style.display="block";
			} else {
				category[i].style.display="none";
			}
		}
		
		var currentCategory = 0;
		$(".moreOfCategory").click(function() {
			currentCategory += 1;
			category[currentCategory].style.display="block";
			category[currentCategory].focus();	
		});
	});
		
	</script>

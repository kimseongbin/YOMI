package com.spring.madi;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

public interface MemberMapper {
	//(진산) 로그인한 아이디 자신에 대한 member정보
	MemberVO getMember(String user_id);
	//(진산) 임시 MemberFollow에서 following_user_id 불러오기
	//MemberFollowVO getFollowing_user_id(String user_id);
	//(진산) 팔로워 수 구하기
	ArrayList<MemberVO> getFollower(String user_id);
	//(진산) 팔로잉 수 구하기
	ArrayList<MemberVO> getFollowing(String user_id);
	//(진산) 팔로워 추천 리스트
	ArrayList<MemberVO> getRecommendFollower(MemberFollowVO memberFollowVO);
	// (성빈) 팔로워 추천 팔로워 수 많은 순
	ArrayList<MemberVO> getRecommendByFollowerCnt(String user_id);
	// (성빈) 팔로워 추천 레시피 작성 많은 순
	ArrayList<MemberVO> getRecommendByRecipeCnt();
	// (성빈) 좋아요 수 많은 순
	ArrayList<MemberVO> getRecommendByLikeCnt();
	//(진산) 추천 리스트 새로고침
	ArrayList<MemberFollowVO> getReloadRecommend();
	//(진산) 팔로잉 한 명 삭제
	void deleteFollowing(@Param("user_id") String user_id, @Param("following_user_id") String following_user_id);
	//(진산) 팔로워 한 명 삭제
	void deleteFollower(@Param("user_id") String user_id, @Param("following_user_id") String following_user_id);
	//(진산) 팔로잉 한 명 추가
	void insertFollowing(@Param("user_id") String user_id, @Param("following_user_id") String following_user_id,
			@Param("user_img") String user_img, @Param("following_user_img") String following_user_img);
	
	//성빈 : 로그인 체크를 위한 password 조회 메소드
	MemberVO getPasswordByUserId(MemberVO memberVO);
	// 성빈 : 회원가입 메소드 (입력된 회원정보를 member 테이블에 insert한다)
	void setMember(MemberVO memberVO);
	
	// 성빈 :Member_Box 테이블에서 내 재료 목록을 불러오기 위한 조회 메소드
	ArrayList<MemberBoxVO> getMyIrdntByUserId(String user_id);
	//(진산) 냉장고에 있는 재료인지 확인하기
	MemberBoxVO getCheckIrdnt(MemberBoxVO memberBoxVO);
	//(진산) 자신의 냉장고 박스에 재료 입력하기
	void insertIrdnt(MemberBoxVO memberBoxVO);
	//(진산) 냉장고 재료가 중복이라 삭제하기
	void deleteIrdnt(MemberBoxVO memberBoxVO);
	
	// 성빈 : 회원  기본 정보 조회 쿼리 (사용안한 메소드, 필요할까봐)
	MemberVO getUserInfoById(String user_id);
	// 성빈 : 회원  기본 정보 조회 쿼리 (사용안한 메소드, 필요할까봐)
	ArrayList<MemberVO> getUserInfoById(String[] user_id);
	// 성빈 : following 추가
	void setFollowing(MemberFollowVO memberFollowVO);
	// 성빈 : following 체크
	int checkFollowing(MemberFollowVO memberFollowVO);
	

}

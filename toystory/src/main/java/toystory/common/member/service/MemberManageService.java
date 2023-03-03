package toystory.common.member.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import toystory.common.member.model.MemberModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;

public interface MemberManageService {

	public MemberModel getMemberDetail(String m_num);

	public int memberModifyPro(MemberModel memberModel);

	public int adminMemberModifyPro(MemberModel model);

	public int leave(String email);


	/*
	 * 작성자: 강승현, 장한원 용도: 마이페이지 내가 쓴 리뷰/문의 관련
	 */
	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 리뷰 문의 리스트
	public List<ReviewModel> memberReviewList(int m_num, int amount, int pageNum);

	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 리뷰 문의 갯수 합계
	public int memberRQtotal(int m_num);

	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 리뷰 상세보기
	public ReviewModel memberReviewDetail(int r_num);

	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 문의 상세보기
	public QnaModel memberQnaDetail(int q_num);

	// 마이페이지에서 본인이 쓴 리뷰 수정
	public void reviewModifyPro(ReviewModel reviewModel, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception;

	// 리뷰 삭제
	public void reviewDelete(int n_num);

	// 문의글 삭제
	public void qnaDelete(int q_num);

	// 파일삭제
	public void fileDelete(String f_svname);


}

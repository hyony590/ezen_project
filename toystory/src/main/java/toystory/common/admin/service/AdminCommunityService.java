package toystory.common.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import toystory.common.notice.model.NoticeModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;

public interface AdminCommunityService {

	// 게시글 작성 + 이미지 업로드
	public void noticeRegister(NoticeModel noticeModel, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception;

	// 작성자 : 이효원, 남재욱 - 12.15 페이징(매개변수) 추가
	public List<NoticeModel> selectNotice(int amount, int pageNum);

	// 게시글 상세보기
		public NoticeModel noticeDetail(int n_num, NoticeModel noticeModel);

		// 게시글 수정 폼으로 넘김
		public NoticeModel noticeModify(int n_num);

	// 작성자 : 이효원, 남재욱 - 12.15 게시글 전체 개수 계산 메소드 추가
	public int noticeListTotalCount();

	// 게시글 수정 처리
	public void noticeModifyPro(NoticeModel noticeModel, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception;

	// 게시글 삭제
	public void noticeDelete(int n_num);
	
	//파일삭제
	public void fileDelete(String f_svname);

	// 관리자가 보는 리뷰+문의 리스트
	public List<ReviewModel> adminReviewList(int amount, int pageNum);

	// 관리자가 보는 문의 상세보기(답글 달 수 있는..)
	public QnaModel adminQnaDetail(int q_num);

	// 관리자가 보는 리뷰 상세보기(답글 달 수 있는..)
	public ReviewModel adminReviewDetail(int q_num);

	// 관리자 리뷰 댓글 처리
	public void reviewCommentRegister(ReviewModel reviewModel);

	// 관리자 문의 댓글 처리
	public void qnaCommentRegister(QnaModel qnaModel);
	
	// 작성자 : 이효원, 남재욱 - 12.19 게시글 리뷰, 문의 게시판 개수 계산 메소드 추가
		public int reviewListTotalCount();


}

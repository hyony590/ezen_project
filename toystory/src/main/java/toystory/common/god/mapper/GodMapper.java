/* 작성자: 강승현 장한원
   작성일:
   용도: 관리자 커뮤니티 관련
 */
package toystory.common.god.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import toystory.common.comment.model.CommentModel;
import toystory.common.notice.model.NoticeModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;

public interface GodMapper {

	// 공지이벤트 리스트
	// 작성자 : 이효원, 남재욱 - 12.15 페이징(매개변수) 추가
	public List<NoticeModel> selectNotice(@Param("amount") int amount, @Param("pageNum") int pageNum);

	// 작성자 : 이효원, 남재욱 - 12.15 게시글 전체 개수 계산 메소드 추가
	public int noticeListTotalCount();

	// 작성자 : 이효원, 남재욱 - 12.19 리뷰, 문의 게시판 전체 개수 계산 메소드 추가
	public int reviewListTotalCount();

	// 공지이벤트 상세보기
	public NoticeModel noticeDetail(int n_num);

	// 공지이벤트게시판 조회수 증가
	public void upNoticeHitCount(int n_num, int n_count);

	/*
	 * 관리자 게시판 관련
	 */
	// 관리자가 공지이벤트 게시글 등록
	public void noticeRegister(NoticeModel noticeModel);

	// 관리자가 공지이벤트 게시글 수정폼
	public NoticeModel noticeModify(int n_num);

	// 관리자 공지 이벤트 수정 처리
	public void noticeModifyPro(NoticeModel noticeModel);

	// 파일삭제
	public void fileDelete(String f_svname);

	// 관리자가 게시글 삭제
	public int noticeDelete(int n_num);

	// 작성자 : 이효원, 남재욱 - 12.19 페이징(매개변수) 추가
	public List<ReviewModel> adminReviewList(@Param("amount") int amount, @Param("pageNum") int pageNum);

	// 관리자가 보는 리뷰+문의 상세보기 및 댓글 폼
	public CommentModel commentRegister(int r_num, String type);

	// 관리자가 보는 리뷰+문의 상세보기에 댓글 입력 처리
	public void commentRegisterPro(CommentModel commentModel);

	// 관리자가 보는 문의 상세보기(답글 달 수 있는..)
	public QnaModel adminQnaDetail(int q_num);

	// 관리자가 보는 문의 상세보기(답글 달 수 있는..)
	public ReviewModel adminReviewDetail(int q_num);

	// 관리자 리뷰 댓글 처리
	public void reviewCommentRegister(ReviewModel reviewModel);

	// 관리자 문의 댓글 처리
	public void qnaCommentRegister(QnaModel qnaModel);

	/*
	 * 상품 상세보기 관련
	 */
	// 상품 상세보기에서 리뷰 리스트 띄움
	public List<ReviewModel> selectReview(@Param("g_id") int g_id, @Param("amount") int amount,
			@Param("pageNum") int pageNum);

	// 상품 상세보기에서 문의 리스트 띄움
	public List<QnaModel> selectQna(@Param("g_id") int g_id, @Param("Qamount") int Qamount,
			@Param("QpageNum") int QpageNum);

	public int goodsReviewTotal(int g_id);

	public int goodsQnaTotal(int g_id);

	// 상품 상세보기에서 문의 작성 처리
	public void qnaRegisterPro(QnaModel qnaModel);

	// 상품 상세보기에서 문의 작성폼에 값 넘겨줌
	public QnaModel qnaRegister(int g_id);

	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 리뷰 문의 리스트
	public List<ReviewModel> memberReviewList(@Param("m_num") int m_num, @Param("amount") int amount,
			@Param("pageNum") int pageNum);

	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 리뷰 문의 갯수 합계
	public int memberRQtotal(int m_num);

	// 마이페이지-주문내역 확인 구매확정 버튼을 통한 리뷰 작성 폼 띄움
	public ReviewModel reviewRegister(int o_num);

	// 마이페이지-주문내역 확인 구매확정 버튼을 통한 리뷰 작성 처리
	public void reviewRegisterPro(ReviewModel reviewModel);

	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 리뷰 상세보기
	public ReviewModel memberReviewDetail(int r_num);

	// 마이페이지에서 볼 수 있는 사용자 본인이 쓴 문의 상세보기
	public QnaModel memberQnaDetail(int q_num);

	// 마이페이지에서 본인이 쓴 리뷰 수정
	public void reviewModifyPro(ReviewModel reviewModel);

	//마이페이지에서 리뷰 수정 폼 띄움
	public ReviewModel reviewModifyForm(int r_num);

	// 리뷰 삭제
	public int reviewDelete(int n_num);

	// 문의글 삭제
	public int qnaDelete(int q_num);

}
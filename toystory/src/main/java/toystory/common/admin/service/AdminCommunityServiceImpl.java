/* 작성자: 강승현 장한원
   작성일:
   용도: 관리자 커뮤니티 관련 serviceImpl
 */
package toystory.common.admin.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.AllArgsConstructor;
import toystory.common.file.mapper.FileMapper;
import toystory.common.god.mapper.GodMapper;
import toystory.common.notice.model.NoticeModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;
import toystory.utils.file.AttachFileModel;
import toystory.utils.file.FileUtils;

@Service
@AllArgsConstructor
public class AdminCommunityServiceImpl implements AdminCommunityService {

	private GodMapper godMapper;
	private FileMapper fileMapper;

	@Resource(name = "fileUtils")
	private FileUtils fileUtils;

	@Override
	public void noticeRegister(NoticeModel noticeModel, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception {
		godMapper.noticeRegister(noticeModel);

		noticeModel.setF_jtkey(noticeModel.getN_num());

		List<AttachFileModel> list = fileUtils.parseInsertFileInfo(noticeModel, request);

		for (int i = 0, size = list.size(); i < size; i++) {
			fileMapper.fileRegister(list.get(i));
		}
	}

	// 작성자 : 이효원, 남재욱 - 12.15 페이징(매개변수) 추가
	@Override
	public List<NoticeModel> selectNotice(int amount, int pageNum) {
		// TODO Auto-generated method stub
		return godMapper.selectNotice(amount, pageNum);
	}

	@Override
	public NoticeModel noticeDetail(int n_num, NoticeModel noticeModel) {
		return godMapper.noticeDetail(n_num);
	}

	@Override
	public NoticeModel noticeModify(int n_num) {
		return godMapper.noticeModify(n_num);
	}
	@Override
	public void fileDelete(String f_svname) {
		godMapper.fileDelete(f_svname);

	}

	@Override
	public void noticeModifyPro(NoticeModel noticeModel, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception {
		godMapper.noticeModifyPro(noticeModel);

		noticeModel.setF_jtkey(noticeModel.getN_num());

		List<AttachFileModel> list = fileUtils.parseInsertFileInfo(noticeModel, request);

		for (int i = 0, size = list.size(); i < size; i++) {
			fileMapper.fileRegister(list.get(i));
		}
	}

	@Override
	public void noticeDelete(int n_num) {
		godMapper.noticeDelete(n_num);
	}

	// 작성자 : 이효원, 남재욱 - 12.19 페이징(매개변수) 추가
		@Override
		public List<ReviewModel> adminReviewList(int amount, int pageNum) {
			// TODO Auto-generated method stub
			return godMapper.adminReviewList(amount, pageNum);
		}

	@Override
	public QnaModel adminQnaDetail(int q_num) {
		return godMapper.adminQnaDetail(q_num);
	}

	@Override
	public ReviewModel adminReviewDetail(int q_num) {
		return godMapper.adminReviewDetail(q_num);
	}

	@Override
	public void reviewCommentRegister(ReviewModel reviewModel) {
		godMapper.reviewCommentRegister(reviewModel);

	}

	@Override
	public void qnaCommentRegister(QnaModel qnaModel) {
		godMapper.qnaCommentRegister(qnaModel);

	}

	// 작성자 : 이효원, 남재욱 - 12.15 게시글 전체 개수 계산 메소드 추가
	@Override
	public int noticeListTotalCount() {
		return godMapper.noticeListTotalCount();
	}
	
	// 작성자 : 이효원, 남재욱 - 12.19 리뷰, 문의 게시글 전체 개수 계산 메소드 추가
	@Override
	public int reviewListTotalCount() {
		return godMapper.reviewListTotalCount();
	}

}

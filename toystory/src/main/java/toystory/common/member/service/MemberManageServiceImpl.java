package toystory.common.member.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.AllArgsConstructor;
import toystory.common.file.mapper.FileMapper;
import toystory.common.god.mapper.GodMapper;
import toystory.common.member.mapper.MemberMapper;
import toystory.common.member.model.MemberModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;
import toystory.utils.file.AttachFileModel;
import toystory.utils.file.FileUtils;

@Service
@AllArgsConstructor
public class MemberManageServiceImpl implements MemberManageService{
	
	private MemberMapper memberMapper;
	private GodMapper godMapper;
	private FileMapper fileMapper;

	@Resource(name = "fileUtils")
	private FileUtils fileUtils;

	@Override
	public MemberModel getMemberDetail(String m_num) {
		
		return memberMapper.memberDetail(m_num);
	}

	@Override
	public int memberModifyPro(MemberModel memberModel) {
		
		return memberMapper.memberModify(memberModel);
	}
	
	public int leave(String email) {
		
		return memberMapper.deleteMember(email);
	}
	

	@Override
	public int adminMemberModifyPro(MemberModel model) {

		return memberMapper.adminMemberModifyPro(model);
	}
	
	/*
	 * 작성자: 강승현, 장한원 용도: 마이페이지 내가 쓴 리뷰/문의 관련
	 */
	@Override
	public List<ReviewModel> memberReviewList(int m_num, int amount, int pageNum) {
		return godMapper.memberReviewList(m_num, amount, pageNum);
	}
	
	// 리뷰 상세보기
	@Override
	public ReviewModel memberReviewDetail(int r_num) {
		return godMapper.memberReviewDetail(r_num);
	}

	// 문의 상세보기
	@Override
	public QnaModel memberQnaDetail(int q_num) {
		return godMapper.memberQnaDetail(q_num);
	}

	//페이징 처리를 위한 리뷰,문의 게시글 수
	@Override
	public int memberRQtotal(int m_num) {
		return godMapper.memberRQtotal(m_num);
	}

	//리뷰 수정 처리
	@Override
	public void reviewModifyPro(ReviewModel reviewModel, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception {
		godMapper.reviewModifyPro(reviewModel);

		reviewModel.setF_jtkey(reviewModel.getR_num());

		List<AttachFileModel> list = fileUtils.parseInsertFileInfo(reviewModel, request);

		for (int i = 0, size = list.size(); i < size; i++) {
			fileMapper.fileRegister(list.get(i));
		}
	}

	// 리뷰 삭제
	@Override
	public void reviewDelete(int r_num) {
		godMapper.reviewDelete(r_num);
	}

	// 문의 삭제
	@Override
	public void qnaDelete(int q_num) {
		godMapper.qnaDelete(q_num);
	}

	// 파일 삭제
	@Override
	public void fileDelete(String f_svname) {
		godMapper.fileDelete(f_svname);
	}

	

}

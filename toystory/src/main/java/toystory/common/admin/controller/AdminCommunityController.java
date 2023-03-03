/* 작성자: 강승현 장한원
   작성일:
   용도: 관리자 커뮤니티 관련 컨트롤러
 */
package toystory.common.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import toystory.common.admin.service.AdminCommunityService;
import toystory.common.notice.model.NoticeModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Controller
@RequestMapping("/admin/")
@AllArgsConstructor
public class AdminCommunityController {

	private AdminCommunityService adminCommunityService;

	// 이벤트 리스트
	// 작성자 : 이효원, 남재욱 - 12.15 페이징(매개변수) 추가, model 추가
	@GetMapping("/notice/list.toy")
	public String noticeList(Model model, Criteria cri) {
		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();
		int total = adminCommunityService.noticeListTotalCount();

		model.addAttribute("list", adminCommunityService.selectNotice(amount, pageNum));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		return "admin/adminNoticeList";
//      return "admin_notice_list";
	}

	/*
	 * 작성자: 장한원, 강승현
	 */
	// 게시글 등록 처리
	@PostMapping("/notice/registerpro.toy")
	public String adminNoticeRegisterPro(NoticeModel noticeModel, RedirectAttributes rttr, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception {
		adminCommunityService.noticeRegister(noticeModel, request, multiRequest); // 입력처리

		String contents = (noticeModel.getN_content().replace("\r\n", "<br>"));
		noticeModel.setN_content(contents);

		rttr.addFlashAttribute("result", noticeModel.getN_num()); // 새롭게 등록된 번호를 가짐

		return "redirect:/admin/notice/list.toy"; // 입력 성공시 글목록 페이지로 리다이렉트 - url 쓰기!!
	}

	// 게시글 등록 폼
	@GetMapping("/notice/register.toy")
	public String noticeRegister() {

		return "admin/noticeRegister";
	}

	// 게시글 수정 폼
	@GetMapping("/notice/modify.toy")
	public String noticeModify(@RequestParam("n_num") int n_num, NoticeModel noticeModel, Model model) {

		model.addAttribute("modify", adminCommunityService.noticeDetail(n_num, noticeModel));

		return "admin/noticeModify";
	}

	// 게시글 수정 처리
	@PostMapping("/notice/modifypro.toy")
	public String noticeModifyPro(NoticeModel noticeModel, RedirectAttributes rttr, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception {

		String contents = (noticeModel.getN_content().replace("\r\n", "<br>"));
		noticeModel.setN_content(contents);

		adminCommunityService.noticeModifyPro(noticeModel, request, multiRequest);
		rttr.addFlashAttribute("f_num", noticeModel.getF_num());

		return "redirect:/admin/notice/list.toy";
	}

	// 파일 삭제 처리
	@GetMapping("/notice/modifypro.toy")
	public void fileDelte(@RequestParam(value = "chbox[]", required = false) String[] chArr, RedirectAttributes rttr) {
		String f_svname = null;
		for (int i = 0; i < chArr.length; i++) {
			f_svname = chArr[i];
			adminCommunityService.fileDelete(f_svname);
			rttr.addFlashAttribute("result", "success");

		}
	}

	// 게시글 조회
	@GetMapping("/notice/detail.toy")
	public String noticeDetail(@RequestParam("n_num") int n_num, NoticeModel noticeModel, Model model) {

		model.addAttribute("ARdetail", adminCommunityService.noticeDetail(n_num, noticeModel));

		return "admin/adminNoticeDetail";
	}

	// 게시글 삭제
	@GetMapping("/notice/delete.toy")
	public String noticeDelete(@RequestParam("n_num") int n_num, RedirectAttributes rttr) {

		adminCommunityService.noticeDelete(n_num);

		return "redirect:/admin/notice/list.toy";
	}

	// 관리자가 볼 수 있는 리뷰+문의 리스트
	// 작성자 : 이효원, 남재욱 - 12.19 페이징(매개변수) 추가, model 추가
	@GetMapping("/review/list.toy")
	public String adminReviewList(Model model, Criteria cri) {

		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();
		int total = adminCommunityService.reviewListTotalCount();

		model.addAttribute("Rlist", adminCommunityService.adminReviewList(amount, pageNum));
		model.addAttribute("pageMaker2", new PageDTO(cri, total));

		return "admin/adminReviewList";

	}

	// 관리자가 보는 문의 게시글 상세보기
	@GetMapping("/qna/detail.toy")
	public String adminQnaDetail(@RequestParam("q_num") int q_num, Model model) {

		model.addAttribute("Qdetail", adminCommunityService.adminQnaDetail(q_num));
		// 댓글 등록

		return "admin/adminQnaDetail";
	}

	// 관리자가 보는 리뷰 게시글 상세보기
	@GetMapping("/review/detail.toy")
	public String adminReviewDetail(@RequestParam("r_num") int r_num, Model model, HttpServletRequest request) {

		model.addAttribute("Rdetail", adminCommunityService.adminReviewDetail(r_num));
		// 댓글 등록

		return "admin/adminReviewDetail";
	}

	// 관리자가 리뷰에 댓글
	@PostMapping("/review/commentRegister.toy")
	public String reviewCommentRegister(ReviewModel reviewModel, RedirectAttributes rttr) {

		adminCommunityService.reviewCommentRegister(reviewModel);
		rttr.addFlashAttribute("result", "success");

		return "redirect:/admin/review/list.toy";
	}

	// 관리자가 문의에 댓글
	@PostMapping("/qna/commentRegister.toy")
	public String qnaCommentRegister(QnaModel qnaModel, RedirectAttributes rttr) {

		adminCommunityService.qnaCommentRegister(qnaModel);
		rttr.addFlashAttribute("result", "success");

		return "redirect:/admin/review/list.toy";
	}

}
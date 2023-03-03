package toystory.common.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import toystory.common.member.model.MemberModel;
import toystory.common.member.service.MemberManageService;
import toystory.common.review.model.ReviewModel;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Controller
@AllArgsConstructor
public class MemberManageController {

	MemberManageService manageService;

	// 마이페이지 메인화면으로 이동
	@GetMapping("/myPage/main.toy")
	public String myPageMain() {

		// views 아래 경로
		return "member/myPage";
	}

	// 내정보 수정 화면으로 이동 이 화면에서 수정, 탈퇴 두 가지 가능
	// 이용자 디테일
	@PostMapping("/myPage/modifyForm.toy")
	public String myModifyForm(@RequestParam("m_num") String m_num, Model model) {

		MemberModel resultModel = manageService.getMemberDetail(m_num);
		model.addAttribute("member", resultModel);

		return "member/myModifyForm";
	}

	// 마이페이지 회원정보 수정처리
	@PostMapping("/myPage/modifyPro.toy")
	public String myModifyPro(RedirectAttributes rttr, MemberModel memberModel) {

		// 내정보 수정
		manageService.memberModifyPro(memberModel);

		return "redirect:/myPage/main.toy";
//		return "redirect:/myPage/main.toy?="+memberModel.getM_email();
	}

	// 탈퇴처리 후 메인페이지로 이동
	// 서비스, 매퍼 통해서 삭제처리 필요함
	@PostMapping("/myPage/leave.toy")
	public String leave(MemberModel memberModel, HttpServletRequest request) {

		manageService.leave(memberModel.getM_email());
		HttpSession session = request.getSession();

		session.invalidate();

		return "redirect:/main.toy";
	}

	/*
	 * 작성자: 강승현, 장한원 용도: 마이페이지 내가 쓴 리뷰/문의 관련
	 */
	// 사용자 본인이 볼 수 있는 리뷰+문의 리스트
	@GetMapping("/myPage/reviewlist.toy")
	public String memberReviewList(@RequestParam("m_num") int m_num, ReviewModel reviewModel, Model model,
			HttpServletRequest request, Criteria cri) {

		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();
		int total = manageService.memberRQtotal(m_num);

		HttpSession session = request.getSession();

		int m_num1 = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

		reviewModel.setM_num(m_num1);

		model.addAttribute("Rlist", manageService.memberReviewList(m_num1, amount, pageNum));
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		return "member/myReviewList";

	}

	 //사용자 본인이 볼 수 있는 리뷰 상세보기
	@SuppressWarnings("unused")
	@GetMapping("/myPage/reviewdetail.toy")
	public String memberReviewDetail(@RequestParam("r_num") int r_num, Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();

		int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

		model.addAttribute("Rdetail", manageService.memberReviewDetail(r_num));

		return "member/myRQdetail";
	}
	

	@SuppressWarnings("unused")
	@GetMapping("/myPage/qnadetail.toy")
	public String memberQnaDetail(@RequestParam("q_num") int q_num, Model model, HttpServletRequest request) {

		HttpSession session = request.getSession();

		int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

		model.addAttribute("Qdetail", manageService.memberQnaDetail(q_num));

		return "member/myRQdetail";
	}

	// 리뷰글 수정 폼
	@SuppressWarnings("unused")
	@GetMapping("/myPage/reviewModify.toy")
	public String reviewModifyFrom(@RequestParam("r_num") int r_num, ReviewModel reviewModel, Model model,
			HttpServletRequest request) {

		HttpSession session = request.getSession();

		int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

		model.addAttribute("modify", manageService.memberReviewDetail(r_num));

		return "member/reviewModify";
	}

	// 리뷰글 수정 처리
	@PostMapping("/myPage/reviewModifypro.toy")
	public String reviewModifyPro(ReviewModel reviewModel, RedirectAttributes rttr, HttpServletRequest request,
			MultipartHttpServletRequest multiRequest) throws Exception {

		HttpSession session = request.getSession();

		int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));
		
		String contents = (reviewModel.getR_content().replace("\r\n", "<br>"));
		reviewModel.setR_content(contents);

		manageService.reviewModifyPro(reviewModel, request, multiRequest);
		rttr.addFlashAttribute("f_num", reviewModel.getF_num());

		return "redirect:/myPage/reviewlist.toy?m_num=" + m_num;
	}
	// 리뷰글 파일 삭제 처리

	// 파일 삭제 처리
	@GetMapping("/myPage/reviewModifypro.toy")
	public void fileDelete(@RequestParam(value = "chbox[]", required = false) String[] chArr, RedirectAttributes rttr) {
		String f_svname = null;

		if (f_svname == null) {
			for (int i = 0; i < chArr.length; i++) {
				f_svname = chArr[i];
				manageService.fileDelete(f_svname);
				rttr.addFlashAttribute("result", "success");

			}
		}
	}

	// 리뷰 삭제
	   @GetMapping("/myPage/reviewDelete.toy")
	   public String reviewDelete(@RequestParam("r_num") int r_num, RedirectAttributes rttr, HttpServletRequest request) {

	      HttpSession session = request.getSession();

	      int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

	      manageService.reviewDelete(r_num);

	      return "redirect:/myPage/reviewlist.toy?m_num=" + m_num;
	   }

	   // 문의 삭제
	   @GetMapping("/myPage/qnaDelete.toy")
	   public String qnaDelete(@RequestParam("q_num") int q_num, RedirectAttributes rttr, HttpServletRequest request) {

	      HttpSession session = request.getSession();

	      int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

	      manageService.qnaDelete(q_num);

	      return "redirect:/myPage/reviewlist.toy?m_num=" + m_num;
	   }
}

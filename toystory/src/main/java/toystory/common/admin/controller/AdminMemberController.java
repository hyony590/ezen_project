package toystory.common.admin.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.member.model.MemberModel;
import toystory.common.member.service.MemberManageService;
import toystory.common.member.service.MemberService;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Log4j
@Controller
@AllArgsConstructor
public class AdminMemberController {

	private MemberManageService manageService;
	private MemberService memberService;

	// 관리자 회원 상세정보 보기
	@GetMapping("/admin/modifyForm.toy")
	public String adminModifyForm(@RequestParam("m_num") String m_num, Model model) {

		MemberModel resultModel = manageService.getMemberDetail(m_num);
		model.addAttribute("member", resultModel);

		return "admin/member/adminMemberDetail";
	}

	// 관리자용 회원정보 수정 처리
	@PostMapping("/admin/memberModifyPro.toy")
	public String adminModifyPro(RedirectAttributes rttr, MemberModel memberModel) {

		// 내정보 수정
		manageService.adminMemberModifyPro(memberModel);

		return "redirect:/admin/memberList.toy";
	}

	// 회원목록 불러오기 관리자용 회원 리스트
	@GetMapping("/admin/memberList.toy")
	public String adminMemberList(Model model, Criteria cri) {

		cri.setAmount(10);
		int totalCount = memberService.totalMemberCount(cri);

		PageDTO pageMaker = new PageDTO(cri, totalCount);

		List<MemberModel> memberList = memberService.adminMemberList(cri);

		model.addAttribute("memberList", memberList);
		model.addAttribute("pageMaker", pageMaker);

		log.info("페이지 메이커 : " + pageMaker.toString());
		log.info("페이지 메이커 : " + pageMaker.toString());

		return "admin/member/adminMemberList";
	}

}

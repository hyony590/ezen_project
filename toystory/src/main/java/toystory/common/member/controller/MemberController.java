/*작성자 : 최창선
용도 : 회원관련 컨트롤러
작성일 : 22년 11월...
*/

package toystory.common.member.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.member.model.MemberModel;
import toystory.common.member.service.MemberService;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Log4j
@Controller
@AllArgsConstructor
public class MemberController {

	private MemberService memberService;

	// 아이디 중복체크 ajax
	@ResponseBody
	@PostMapping(value = "/join/idCheck.toy", consumes = "application/json")
	public int idCheckService(@RequestBody HashMap<String, String> param) {

		int result = memberService.idCheck(param.get("email"));
		return result;
	}

	// 휴대폰번호 중복체크 ajax
	@ResponseBody
	@PostMapping(value = "/join/mobileCheck.toy", consumes = "application/json")
	public int mobileCheckService(@RequestBody HashMap<String, String> param) {

		int result = memberService.mobileCheck(param.get("mobile"));
		return result;
	}

	// 회원가입 폼으로 이동
	@GetMapping("/join/join.toy")
	public String join() {
		return "member/joinForm";
	}

	// 회원가입 처리, 이후 메인으로 보냄...
	@PostMapping("/join/join.toy")
	public String joinPro(MemberModel memberModel) {
		memberService.insertMember(memberModel);
		return "redirect:/main.toy";
	}

	// 로그인 화면 불러오기
	@GetMapping("login/login.toy")
	public String loginForm() {
		return "member/loginForm";

	}

	// 로그인 처리, 이후 메인으로 보냄
	@PostMapping("/login/loginPro.toy")
	public String loginCheck(HttpServletRequest request, RedirectAttributes rttr, MemberModel memberModel) {

		MemberModel resultMemberModel = memberService.loginCheck(memberModel);

		if (resultMemberModel != null) {
			HttpSession session = request.getSession();

			// 로그인 후 세션 설정...
			session.setAttribute("loginMember", resultMemberModel);
			session.setAttribute("loginId", resultMemberModel.getM_email());
			session.setAttribute("loginName", resultMemberModel.getM_name());
			session.setAttribute("loginNum", Integer.toString(resultMemberModel.getM_num()));
			session.setAttribute("loginRank", resultMemberModel.getM_rank());
			session.setAttribute("loginAdult", resultMemberModel.getM_adult());

			session.setMaxInactiveInterval(60 * 30);

			// 관리자일 경우 관리자 페이지로

			if (resultMemberModel.getM_rank().equals("A")) {
				return "redirect:/admin_main.toy";
			}

			return "redirect:/main.toy";

		} else {

			// 로그인 실패시 1 코드를 보내 로그인 실패 경고창 팝업
			rttr.addFlashAttribute("code", "1");
			System.out.println(rttr.getFlashAttributes());

			return "redirect:/login/login.toy";
		}

	}

	// 로그아웃, 세션 삭제 후 메인으로 보냄
	@GetMapping("/login/logout.toy")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();

		return "redirect:/main.toy";
	}

	// 아이디 찾기 폼으로 이동
	@GetMapping("/login/findId.toy")
	public String findId() {

		return "member/findId";
	}

	// 비밀번호 찾기 폼으로 이동
	@GetMapping("/login/findPw.toy")
	public String findPw() {

		return "member/findPw";
	}

	// 계정찾기 완료 폼으로 이동 (아이디, 비번 모두 이 메소드 사용)
	@PostMapping("/login/findAccount.toy")
	public String findAccountPro(@RequestParam("accountName") String accountName, MemberModel memberModel, Model model,
			RedirectAttributes rttr) {

		MemberModel findAccount = memberService.findAccount(memberModel);
		System.out.println(findAccount);

		// 찾는 계정이 없다면
		if (findAccount == null) {
			model.addAttribute("result", "0");
			if (accountName.equals("id")) {
				return "member/findId";
			} else {
				return "member/findPw";
			}

			// 찾는 계정이 있다면
		} else {

			if (memberModel.getM_email() == null) {
				model.addAttribute("findAccount", findAccount);
				model.addAttribute("check", "id");
			} else {
				model.addAttribute("findAccount", findAccount);
				model.addAttribute("check", "pw");

			}
		}

		return "member/findAccountResult";

	}

	// 성인 유무 확인
	@PostMapping("/login/adultCheck.toy")
	public String adultCheck(Date m_birth, HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		String loginNum = (String) session.getAttribute("loginNum");

		int adultCheck = memberService.adultCheck(m_birth, loginNum);

		model.addAttribute("adultCheck", adultCheck);

		return "member/adultCheckPro";
	}

	// 테스트용, 이후 상품 컨트롤러 완성되면 Mapping url 변경해야함
	@GetMapping("/login/adultCheck.toy")
	public String adultCheck() {

		return "member/adultCheck";
	}

}

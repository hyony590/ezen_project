package toystory.common.goods.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.goods.model.GoodsModel;
import toystory.common.goods.service.GoodsService;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;
import toystory.utils.page.Criteria;
import toystory.utils.page.Criteria2;
import toystory.utils.page.Criteria3;
import toystory.utils.page.PageDTO;
import toystory.utils.page.PageDTO2;
import toystory.utils.page.PageDTO3;

@Log4j
@Controller
@AllArgsConstructor
public class GoodsController {

	private GoodsService goodsService;

	/*
	 * @GetMapping("/goods/list.toy") public String goodsList(GoodsModel g_category,
	 * Model model) { model.addAttribute("list",
	 * goodsService.goodsList(g_category)); return "goods/goodsList"; }
	 */

	// 12.08 성인인증 여부 설정, 12.09 비회원 세션 추가, 12.13 searchAdult 세션 추가, 12.15 페이징 추가
	// 12.08 성인인증 여부 설정, 12.09 비회원 세션 추가, 12.13 searchAdult 세션 추가, 12.15 페이징 추가
	@GetMapping("/goods/list.toy")
	public String goodsList(@RequestParam("g_category") String g_category, Model model, HttpServletRequest request,
			RedirectAttributes rttr, Criteria cri, String sort) {
		model.addAttribute("category", g_category);

		HttpSession session = request.getSession();

		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();
		int total = goodsService.goodsListTotalCount(g_category);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		session.setAttribute("keySession", null);

		String searchAdult = (String) session.getAttribute("searchAdult"); // searchAdult : 검색 페이지에서 성인인증 후, 검색 화면으로
																			// redirect시키기 위한 세션

		String keyword = (String) session.getAttribute("keyword"); // goodsSearchAll에서 설정한 keyword 세션 값 받아옴

		if (searchAdult != null) { // 성인인증이 된 경우
			session.setAttribute("searchAdult", null); // searchAdult 세션 값 초기화, 없으면 카테고리들 클릭 시, 현재 검색 창 무한 리다이렉트
			if (keyword != null) { // 검색어가 있는 경우
				rttr.addAttribute("keyword", keyword); // ?keyword=keyword
				return "redirect:/goods/search.toy";
			} else { // 검색어가 없는 경우
				model.addAttribute("list", goodsService.goodsList(g_category, amount, pageNum, sort));
				return "goods/goodsList";
			}
		} else { // 성인인증이 되지 않은 경우
			if (g_category.equals("5")) { // 5번(설렘토이) 헤더에서 클릭 시,
				session.setAttribute("keyword", null);
				if (session.getAttribute("loginAdult") == null) { // 비회원이라면
					session.setAttribute("loginAdult", "N"); // session에서 성인인증 값을 "N"으로 줌
					return "redirect:/login/adultCheck.toy"; // 성인인증이 안되었기 때문에, 성인인증창으로 이동
				} else { // 회원이라면
					String adult = (String) session.getAttribute("loginAdult"); // session에서 성인 확인값 가져오기
					if (adult.equals("Y")) { // 성인이라면,

						model.addAttribute("list", goodsService.goodsList(g_category, amount, pageNum, sort));
						return "goods/goodsList";// 바로 설렘토이창으로 넘어감
					} else { // 성인인증을 하지 않은 회원이라면
						return "redirect:/login/adultCheck.toy"; // 성인인증창으로 이동
					}
				}
			}

			model.addAttribute("list", goodsService.goodsList(g_category, amount, pageNum, sort)); // 5번 제외한 다른 카테고리
			return "goods/goodsList";
		}
	}

	// 12.13 상품 통합검색
	@GetMapping("/goods/search.toy")
	public String goodsSearchAll(@RequestParam("keyword") String keyword, GoodsModel goodsmodel, Model model,
			HttpServletRequest request, RedirectAttributes rttr, Criteria cri) {
		HttpSession session = request.getSession();
		String adult = (String) session.getAttribute("loginAdult");
		model.addAttribute("adultCheck", adult);
		session.setAttribute("keyword", keyword); // 검색 페이지에서 성인인증 후, 검색 화면으로 redirect시, keyword파라미터 제공하기 위한 세션
		model.addAttribute("key", keyword);
		session.setAttribute("keySession", keyword);

		int cateSize = 0;
		for (int i = 1; i <= 5; i++) {
			cateSize += goodsService.goodsSearchCateCount(keyword, Integer.toString(i));
		}
		model.addAttribute("cateSize", cateSize);

		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();

		// 추가
		model.addAttribute("cate1", goodsService.goodsSearchCateCount(keyword, "1"));
		model.addAttribute("cate2", goodsService.goodsSearchCateCount(keyword, "2"));
		model.addAttribute("cate3", goodsService.goodsSearchCateCount(keyword, "3"));
		model.addAttribute("cate4", goodsService.goodsSearchCateCount(keyword, "4"));
		model.addAttribute("cate5", goodsService.goodsSearchCateCount(keyword, "5"));

		model.addAttribute("keyword1", goodsService.goodsSearchAll(keyword, "1", amount, pageNum));
		model.addAttribute("keyword2", goodsService.goodsSearchAll(keyword, "2", amount, pageNum));
		model.addAttribute("keyword3", goodsService.goodsSearchAll(keyword, "3", amount, pageNum));
		model.addAttribute("keyword4", goodsService.goodsSearchAll(keyword, "4", amount, pageNum));
		model.addAttribute("keyword5", goodsService.goodsSearchAll(keyword, "5", amount, pageNum));

		return "goods/goodsSearchList";
	}

	/*
	 * 작성자: 1. 남재욱, 이효원 / 2. 강승현, 장한원 용도: 1. 상품 상세보기 / 2. 상품 상세보기에서 리뷰/문의 리스트 띄우기
	 */
	// 상품 상세보기 + 리뷰/문의 리스트 띄우기
	@GetMapping("/goods/detail.toy")
	public String goodsDetail(@RequestParam("g_id") int g_id, Model model, ReviewModel reviewModel, QnaModel qnaModel,
			Criteria2 cri, Criteria3 cri3) {

		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();

		int Qamount = cri3.getQamount();
		int QpageNum = cri3.getQpageNum();

		int total = goodsService.goodsReviewTotal(g_id);
		int Qtotal = goodsService.goodsQnaTotal(g_id);

		List<ReviewModel> Rlist = new ArrayList<ReviewModel>(goodsService.selectReview(g_id, amount, pageNum)); // 리뷰
																												// 리스트
		List<QnaModel> Qlist = new ArrayList<QnaModel>(goodsService.selectQna(g_id, Qamount, QpageNum)); // 문의 리스트

		// 이미지 가져오기 - 최창선
		Map<String, Object> map = new HashMap<>();
		map.put("f_jtkey", g_id);
		map.put("f_jtname", "G");
		model.addAttribute("imageList", goodsService.imageList(map));

		model.addAttribute("detail", goodsService.goodsDetail(g_id));

		PageDTO2 dto2 = new PageDTO2(cri, total);
		PageDTO3 dto3 = new PageDTO3(cri3, Qtotal);

		model.addAttribute("RpageMaker", dto2);
		model.addAttribute("QpageMaker", dto3);
		model.addAttribute("QpageNum", dto3.getCri3().getQpageNum());
		model.addAttribute("pageNum", dto2.getCri().getPageNum());
		model.addAttribute("total", dto2.getTotal());
		model.addAttribute("Qtotal", dto3.getQtotal());

		model.addAttribute("Rlist", Rlist); // 리뷰 리스트
		model.addAttribute("Qlist", Qlist); // 문의 리스트

		return "goods/goodsDetail";
	}

	/*
	 * // 문의 게시글 등록 처리
	 * 
	 * @PostMapping("/goods/qnapro.toy") public String qnaRegisterPro(QnaModel
	 * qnaModel, RedirectAttributes rttr, HttpServletRequest request, Model model) {
	 * // RedirectAttributes: 등록 작업이 끝난 후 다시 목록으로 이동하기 위함
	 * 
	 * int m_num = (int) request.getSession().getAttribute("m_num"); // 세션에 등록된
	 * 
	 * qnaModel.setM_num(m_num);
	 * 
	 * goodsService.qnaRegisterPro(qnaModel); // 입력처리
	 * 
	 * rttr.addFlashAttribute("result", qnaModel.getQ_num()); // 새롭게 등록된 번호를 가짐 int
	 * g_num = qnaModel.getG_id();
	 * 
	 * return "redirect:/goods/detail.toy?" + g_num; // 입력 성공시 상세보기 페이지로 리다이렉트 }
	 */
	
	// 문의 게시글 등록 처리
		@PostMapping("/goods/qnapro.toy")
		public String qnaRegisterPro(QnaModel qnaModel, @RequestParam("g_id") int g_id, RedirectAttributes rttr, HttpServletRequest request) {
			// RedirectAttributes: 등록 작업이 끝난 후 다시 목록으로 이동하기 위함

			HttpSession session = request.getSession();
			int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

			qnaModel.setM_num(m_num);
			qnaModel.setG_id(g_id);

			goodsService.qnaRegisterPro(qnaModel); // 입력처리

			rttr.addFlashAttribute("result", qnaModel.getQ_num()); // 새롭게 등록된 번호를 가짐

			return "redirect:/goods/detail.toy?g_id=" + qnaModel.getG_id(); // 입력 성공시 상세보기 페이지로 리다이렉트
		}

	// 문의 게시글 등록 폼 띄움
	@GetMapping("/goods/qregister.toy")
	public String qnaRegister(@RequestParam("g_id") int g_id, Model model) {

		model.addAttribute("g_id", g_id);
		
		/* model.addAttribute("qregister", goodsService.qnaRegister(g_id)); */

		return "goods/goodsQnaRegister";
	}

	// 12.23 검색 - 더보기 리스트
	@GetMapping("/goods/searchmore.toy")
	public String goodsSearchMore(String g_category, String keyword, Model model, HttpServletRequest request,
			Criteria cri) {
		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();

		int totalSearch = goodsService.goodsSearchCateCount(keyword, g_category);

		model.addAttribute("category", g_category);

		model.addAttribute("arr", goodsService.goodsSearchAll(keyword, g_category, amount, pageNum));

		model.addAttribute("pageMaker", new PageDTO(cri, totalSearch));
		model.addAttribute("key", keyword);
		return "goods/searchMoreList";

	}

}

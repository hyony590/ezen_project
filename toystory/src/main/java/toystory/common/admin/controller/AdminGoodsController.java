package toystory.common.admin.controller;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.admin.service.AdminGoodsService;
import toystory.common.goods.model.GoodsModel;
import toystory.common.goods.service.GoodsService;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Log4j
@Controller
@RequestMapping("/admin/")
@AllArgsConstructor
public class AdminGoodsController {

	private AdminGoodsService adminGoodsService;
	private GoodsService goodsService;

	// 상품 리스트, 12.15 페이징 추가
	@GetMapping("/goodslist.toy")
	public String goodsList(Model model, Criteria cri) {

		int amount = cri.getAmount();
		int pageNum = cri.getPageNum();
		int total = adminGoodsService.goodsListTotalCountAll();

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		model.addAttribute("admingoodslist", adminGoodsService.goodsAllList(amount, pageNum));

		return "admin/goods/adminGoodsList";
	}

	// 상품 등록 폼
	@GetMapping("/goodsregisterform.toy")
	public String adminGoodsRegisterForm(Model model) {
		model.addAttribute("id", adminGoodsService.goodsRegisterNumber());
		LocalDate now = LocalDate.now();
		model.addAttribute("now", now);
		return "admin/goods/adminGoodsRegisterForm";
	}

	// 상품 등록
	@PostMapping("/goodsregisterpro.toy")
	public String adminGoodsRegisterPro(GoodsModel goodsModel, HttpServletRequest request, RedirectAttributes rttr)
			throws Exception {
		adminGoodsService.goodsRegister(goodsModel, request);
		return "redirect:/admin/goodslist.toy";
	}

	// 상품 삭제 처리
	@GetMapping("/goodsdeletepro.toy")
	public String adminGoodsDelete(@RequestParam("g_id") int g_id, Model model, RedirectAttributes rttr) {
		// adminGoodsList.jsp 복수 선택 일괄 삭제 구현 예정
		adminGoodsService.goodsDelete(g_id);
		return "redirect:/admin/goodslist.toy";
	}

	// 관리자 상품 수정 폼
	@GetMapping("/goodsmodifyform.toy")
	public String adminGoodsModifyForm(@RequestParam("g_id") int g_id, Model model) {

		model.addAttribute("modify", goodsService.goodsDetail(g_id));
		Map<String, Object> map = new HashMap<>();
		map.put("f_jtkey", g_id);
		map.put("f_jtname", 'G');

		model.addAttribute("imageList", goodsService.imageList(map));

		return "admin/goods/adminGoodsModifyForm";
	}

	// 관리자 상품 수정 처리
	@PostMapping("/goodsmodifypro.toy")
	public String adminGoodsModifyPro(GoodsModel goodsModel, HttpServletRequest request, @RequestParam("g_id") int g_id,
			Model model, RedirectAttributes rttr) throws Exception {

		if (adminGoodsService.goodsModify(g_id, goodsModel, request)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/admin/goodslist.toy";
	}

	// 12.27 등록된 상품의 이미지 파일 삭제
	@GetMapping("/goodsmodifypro.toy")
	public String adminGoodsFileDelete(@RequestParam("chbox[]") int[] chArr, RedirectAttributes rttr) {
		int f_num = 0;
		for (int i = 0; i < chArr.length; i++) {
			f_num = chArr[i];
			adminGoodsService.fileDelete(f_num);
		}
		return "redirect:/admin/goodslist.toy";
	}

	// 12-7 체크박스 선택된 상품만 삭제
	@GetMapping("/goodsdeleteproarr.toy") // 12-8 url 수정
	public String deleteAll(@RequestParam("chbox[]") int[] chArr, RedirectAttributes rttr) {
		int g_id = 0;
		for (int i = 0; i < chArr.length; i++) {
			g_id = chArr[i];
			adminGoodsService.goodsDelete(g_id);
		}
		return "redirect:/admin/goodslist.toy";
	}

}
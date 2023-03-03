package toystory.common.main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.goods.service.GoodsService;

@Log4j
@Controller
@AllArgsConstructor
public class MainController {

	// GoodsController에서 mapping 선언 시, 중복으로 인한 오류 발생으로 하기와 같이 변경
	private GoodsService goodsService;

	@GetMapping("/main.toy")
	public String main(Model model, HttpServletRequest request) {
		model.addAttribute("bestProduct", goodsService.goodsBestTop());
		model.addAttribute("newProduct", goodsService.goodsNewTop());
		String savePath="/resources/assets/img/image/";
		String realPath=request.getRealPath(savePath);
		log.info("이미지 저장경로 : " + realPath);
		log.info("이미지 저장경로 : " + realPath);
		log.info("이미지 저장경로 : " + realPath);
		log.info("이미지 저장경로 : " + realPath);
		
		
		HttpSession session = request.getSession();
		Object dest = session.getAttribute("dest");
		log.info("메인에서 dest 출력" + dest);

		return "main_layout";
	}

	// 관리자 메인페이지
	@GetMapping("/admin_main.toy")
	public String admin_main() {
		return "admin_layout";
	}

}
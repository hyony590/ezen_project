package toystory.common.order.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.basket.CommandMap;
import toystory.common.basket.model.BasketModel;
import toystory.common.basket.service.BasketService;
import toystory.common.member.model.MemberModel;
import toystory.common.member.service.MemberManageService;
import toystory.common.order.model.OrderModel;
import toystory.common.order.service.OrderService;
import toystory.common.review.model.ReviewModel;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Log4j
@Controller
@AllArgsConstructor
public class OrderController {

	private OrderService orderService;
	private MemberManageService memberService;
	private BasketService basketService;

	/*
	 * @GetMapping("/order/buy.toy") public String buy(Model model) {
	 * 
	 * return "order/orderForm"; }
	 */

	//최창선 임시
	@GetMapping("/order/orderSuccessForm.toy")
	public String orderSuccess() {
		
		
		return "order/orderSuccess";
	}
	
	//최창선 : 고객 구매확정 처리
	@ResponseBody
	@PostMapping(value="/order/orderConfirm.toy", consumes="application/json;")
	public int orderConfirm(@RequestBody OrderModel orderModel, HttpServletRequest request) {
		
		String str = (String)request.getSession().getAttribute("loginNum");
		orderModel.setM_num(Integer.parseInt(str));
		
		log.info("오더모델 : " + orderModel.toString());
		log.info("오더모델 : " + orderModel.toString());
		log.info("오더모델 : " + orderModel.toString());
		log.info("오더모델 : " + orderModel.toString());
		
		return orderService.confirmOrder(orderModel);
	}
	
	/*
	 * @PostMapping("/order/orderSuccessPro.toy") public String orderSuccessPro() {
	 * 
	 * return "redirect:/myPage/orderList.toy"; }
	 */
	
	
	//최창선 회원용 마이페이지 주문내역 가져오기
	@PostMapping("/myPage/orderList.toy")
	public String myOrderList(Model model, Criteria cri, HttpServletRequest request) {
		
		cri.setAmount(10);
		
		log.info("크리 :" +  cri.toString());
		log.info("크리 :" +  cri.toString());
		log.info("크리 :" +  cri.toString());
		log.info("크리 :" +  cri.toString());
		
		
		int m_num = Integer.parseInt((String) request.getSession().getAttribute("loginNum"));
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("m_num", m_num);
		
		int totalCount = orderService.myOrderCount(map);
		PageDTO pageMaker = new PageDTO(cri, totalCount);
		
		
		List<OrderModel> orderList = orderService.myOrderList(map);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageMaker", pageMaker);
		

		return "order/orderList";
	}

	// 최창선 : 바로주문하기
	@GetMapping("/order/orderStart.toy")
	public String orderStart(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession();
		String m_num = (String) session.getAttribute("loginNum");
		MemberModel memberModel = memberService.getMemberDetail(m_num);

		log.info("회원 : " + memberModel.toString());

		List<BasketModel> tempList = basketService.getTempBasket(memberModel.getM_num());

		
		model.addAttribute("memberModel", memberModel);
		model.addAttribute("tempList", tempList);

		return "order/orderForm";
	}
	
	@ResponseBody
	@PostMapping("/order/getOrderNum.toy")
	public String getOrderNum() {
		
		return orderService.getOrderNum(); 
	}
	
	
	
	
	@RequestMapping(value="/order/orderStart", method=RequestMethod.POST)
    public ModelAndView orderStart(CommandMap commandMap,HttpServletRequest request) throws Exception{
    	
		ModelAndView mv = new ModelAndView("jsonView");
		HttpSession session = request.getSession();
		String m_num = (String)session.getAttribute("loginNum");
		String m_email = (String)session.getAttribute("loginId");
    	
		System.out.println("로그인한 사람이요 : " + session.getAttribute("loginNum"));
		
		commandMap.getMap().put("m_num", m_num);
		commandMap.getMap().put("m_email", m_email);
		System.out.println("커멘드맵 값이요 : "    +commandMap.getMap());
		
		Map<String, Object> order = orderService.loginCheck(commandMap.getMap());
		mv.addObject("order", order);
		System.out.println("뭐가나오냐:---------------" + order);
		
		commandMap.put("m_num", session.getAttribute("loginNum"));
		commandMap.put("b_num", session.getAttribute("b_num"));
		
    	List<Map<String, Object>> basket=orderService.orderStart(commandMap.getMap());
    	mv.addObject("list",basket);
    	
    	System.out.println("list에 담긴건 뭐냐 :===========" + basket);
		
    	
    	return mv;
	}

	//최창선 바로주문 주문처리 (장바구니 삭제 후 주문 삽입)
	@ResponseBody
	@PostMapping(value = "/order/orderPro.toy")
	public int orderPro(@RequestParam("b_num") String b_num, OrderModel orderModel, HttpServletRequest request) throws Exception {

		log.info("orderModel : " + orderModel.toString());
		log.info("장바구니 모델 : " + b_num);
		
		
		BasketModel model = new BasketModel();
		model.setB_num(Integer.parseInt(b_num));
		
		basketService.basketDeleteOne(model);
		return orderService.buy(orderModel);
	}
	
	@RequestMapping("/order/orderForm")
    public ModelAndView orderForm(CommandMap commandMap,HttpServletRequest request) throws Exception{
    	
		ModelAndView mv = new ModelAndView("order/basketOrderForm");
		
		
    	
    	return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/order/orderStart.toy", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ModelAndView

			orderStart(@RequestBody List<OrderModel> orderList) {

		for (int i = 0; i < orderList.size(); i++) {
			System.out.println("테스트" + orderList.get(i).toString());
		}

		ModelAndView mav = new ModelAndView("order/orderForm");
		mav.addObject("orderList", orderList);

		return mav;
	}
	
	
	
	
	@RequestMapping(value="/order/buy", method=RequestMethod.POST)
    public ModelAndView buy(@RequestParam Map<String, Object> commandMap,HttpServletRequest request) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	
    	HttpSession session = request.getSession();
    	
    	String m_email =(String) session.getAttribute("loginId");
    	
    	commandMap.put("m_email", m_email);
    	
    	
    	System.out.println("뭐가 나오니???:==============="+commandMap);
		
    	orderService.buy(commandMap);
    	
    	basketService.deleteBasket(commandMap);
    	
    	return mv;
	}
	
	/*
	 * 작성자: 강승현, 장한원 용도: 마이페이지-주문내역 확인에서의 리뷰 작성
	 */
	// 리뷰 게시글 등록 폼 띄움
	@GetMapping("/order/rregister.toy")
	public String qnaRegister(@RequestParam("o_num") int o_num, Model model) {
		model.addAttribute("o_num", o_num);
		return "order/reviewRegister";
	}
	
	// 리뷰 게시글 등록 처리
	@PostMapping("/order/reviewpro.toy")
	public String reviewRegisterPro(ReviewModel reviewModel, @RequestParam("o_num") int o_num, RedirectAttributes rttr,
			HttpServletRequest request, MultipartHttpServletRequest multirequest) throws Exception {
		// RedirectAttributes: 등록 작업이 끝난 후 다시 목록으로 이동하기 위함

		HttpSession session = request.getSession();
		int m_num = Integer.parseInt(String.valueOf(session.getAttribute("loginNum")));

		reviewModel.setM_num(m_num);
		reviewModel.setO_num(o_num);
		
		String contents = (reviewModel.getR_content().replace("\r\n", "<br>"));
		reviewModel.setR_content(contents);

		orderService.reviewRegisterPro(reviewModel, request, multirequest); // 입력처리

		rttr.addFlashAttribute("result", reviewModel.getR_num()); // 새롭게 등록된 번호를 가짐

		return "redirect:/myPage/main.toy"; // 입력 성공시 상세보기 페이지로 리다이렉트
	}

}

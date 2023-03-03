package toystory.common.basket.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.basket.CommandMap;
import toystory.common.basket.model.BasketModel;
import toystory.common.basket.service.BasketService;

@Log4j
@Controller
@AllArgsConstructor
public class BasketController {

	private BasketService basketService;



	// 바로주문 야매로 장바구니 담아두기... 최창선
	@ResponseBody
	@PostMapping(value = "/basket/addBasket.toy", consumes = "application/json")
	public int addTemp(@RequestBody BasketModel basketModel, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		String m_email = (String)session.getAttribute("loginId");
		
		basketModel.setM_email(m_email);
		
		log.info("바스켓 모델 : " + basketModel.toString());
		log.info("바스켓 모델 : " + basketModel.toString());
		log.info("바스켓 모델 : " + basketModel.toString());
		basketService.addBasket(basketModel);
		return 1;
	}

	@PostMapping(value = "/basket/deleteTemp.toy", consumes = "application/json")
	public ModelAndView deleteTemp(@RequestBody BasketModel basketModel) throws Exception {

		ModelAndView mv = new ModelAndView("jsonView");
		log.info("b_num : " + basketModel);
		log.info("b_num : " + basketModel);
		log.info("b_num : " + basketModel);
		log.info("b_num : " + basketModel);
		basketService.basketDeleteOne(basketModel);

		return mv;
	}

	/*
	 * @GetMapping("/basket/list.toy") public String basketList(Model model,
	 * HttpServletRequest request){
	 * 
	 * HttpSession session = request.getSession(); String m_num = (String)
	 * session.getAttribute("loginNum");
	 * 
	 * List<BasketModel> basketList = basketService.basketList(m_num);
	 * 
	 * model.addAttribute("basketList", basketList);
	 * 
	 * return "basket/basketList"; }
	 */

	@RequestMapping(value="/basket/list.toy")
	public ModelAndView basketList(CommandMap commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("basket/basketList");
		
		
		HttpSession session = request.getSession();
		
		String m_num = (String)session.getAttribute("loginNum");
		System.out.println("로그인한 사람이요 : " + session.getAttribute("loginNum"));
		
		
		
		commandMap.getMap().put("m_num", m_num);
		
		List<Map<String, Object>> basket = basketService.basketList(commandMap.getMap());
		
		mv.addObject("basketList", basket);
		
		return mv;
	}

	//장바구니 수량 수정           맵에 장바구니를 넣어줘야 할거같
	@RequestMapping(value="/basket/modify", method=RequestMethod.POST)
	public ModelAndView basketModify(BasketModel basketModel, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		log.info("basket/modify.toy... \n 뜬금없이 이 메소드가 실행되더라도 놀라지 마시고 \n get. post 잘못된것 아닌지 확인해보세요...");
		
		ModelAndView mv = new ModelAndView("jsonView");
		//HttpSession session = request.getSession();
		
		//String m_num = (String)session.getAttribute("loginNum");
				
		//commandMap.getMap().put("m_num", m_num);
		//commandMap.getMap().put("b_num", b_num);
		System.out.println(basketModel);
		basketService.basketModify(basketModel);
		
		return mv;
	}

	//장바구니 삭제
	@RequestMapping(value="basket/basketDeleteOne")
	public ModelAndView basketDeleteOne(BasketModel basketModel,  HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView mv = new ModelAndView("jsonView");
		
		basketService.basketDeleteOne(basketModel);
		
		return mv;		
	}
	
	
		
	//장바구니 선택주문 시작
	@RequestMapping(value="/basket/buyItemBasket", method=RequestMethod.POST)
    public ModelAndView buyItemBasket(@RequestParam Map commandMap,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		
		
		ModelAndView mv = new ModelAndView("jsonView"); 	
		HttpSession session = request.getSession();
		String m_email= (String)session.getAttribute("loginId");
		String m_num = (String)session.getAttribute("loginNum");
		
		commandMap.put("m_email", m_email);	
		commandMap.put("m_num", m_num);
		
		session.setAttribute("b_num", commandMap.get("b_num"));
		session.setAttribute("m_email", commandMap.get("m_email"));
		
		basketService.delBuyItemBasket(commandMap);
		
		System.out.println("????????????????=============================="+commandMap);
    	
    	basketService.buyItemBasket(commandMap);
    	
    	
    	
    	return mv;
    	
    	
	}
	//얘 필요 없음	
	@RequestMapping(value="/basket/delBuyItemBasket", method=RequestMethod.POST)
    public ModelAndView delBuyItemBasket(@RequestParam Map commandMap,HttpServletRequest request,HttpServletResponse response) throws Exception{
//		 public ModelAndView delBuyItemBasket(@RequestParam Map commandMap,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		ModelAndView mv = new ModelAndView("jsonView"); 	
    	
		HttpSession session = request.getSession();
		String m_email= (String)session.getAttribute("loginId");
		String m_num = (String)session.getAttribute("loginNum");
		
		String b_num = request.getParameter("b_num");
		System.out.println("b_num 받아주라 좀 ================================"+b_num);
		
		commandMap.put("m_email", m_email);	
		commandMap.put("m_num", m_num);
		
		System.out.println(commandMap+"맵 출력============================================");
		
		basketService.delBuyItemBasket(commandMap);
	
    	return mv;
	}

		
}

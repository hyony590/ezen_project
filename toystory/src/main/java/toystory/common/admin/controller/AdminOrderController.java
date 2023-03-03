package toystory.common.admin.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.admin.service.AdminOrderService;
import toystory.common.order.model.OrderModel;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Log4j
@Controller
@RequestMapping("/admin/")
@AllArgsConstructor

public class AdminOrderController {
	
	AdminOrderService orderService;

	
	//관리자용 전체 주문목록 보여주기
	@GetMapping("/orderlist.toy")
	public String adminOrderList(Model model, Criteria cri) {
		
		cri.setAmount(10);
		log.info("크리 :" +  cri.toString());
		log.info("크리 :" +  cri.toString());
		log.info("크리 :" +  cri.toString());
		log.info("크리 :" +  cri.toString());
		int totalCount = orderService.orderCount(cri);
		
		PageDTO pageMaker = new PageDTO(cri, totalCount);
		
		List<OrderModel> orderList = orderService.adminOrderList(cri);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("pageMaker", pageMaker);
		
		return "admin/order/adminOrderList";
	}
	
	
	//관리자용 주문 1개 디테일 보여주기
	@GetMapping("/orderdetail.toy")
	public String adminOrderDetail(@RequestParam("o_num") String o_num, Model model) {
		
		OrderModel orderModel = orderService.orderDetail(o_num);
		model.addAttribute("orderModel", orderModel);
		
		
		
		return "admin/order/adminOrderDetail";
	}
	
	//관리자용 주문 1개 수정 후 리스트로 redirect
	@PostMapping("/ordermodify.toy")
	public String adminOrderModifyPro(OrderModel orderModel) {
		int check = orderService.orderModify(orderModel);
		System.out.println(check + "최창선");
		return "redirect:/admin/orderlist.toy";
	}
	
}

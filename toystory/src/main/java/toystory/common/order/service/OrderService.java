package toystory.common.order.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import toystory.common.order.model.OrderModel;
import toystory.common.review.model.ReviewModel;

public interface OrderService {
	
	public int buy(OrderModel orderModel);
	
	public List<OrderModel> myOrderList(Map<String, Object> map);
	/*
	 * 작성자: 강승현, 장한원
	 */
	// 마이페이지-주문내역 확인 구매확정 버튼을 통한 리뷰 작성 폼 띄움
	public ReviewModel reviewRegister(int o_num);

	// 마이페이지-주문내역 확인 구매확정 버튼을 통한 리뷰 작성 처리
	public void reviewRegisterPro(ReviewModel reviewModel, HttpServletRequest request, MultipartHttpServletRequest multirequest) throws Exception;
	
	
	/**최창선 : 고객 구매확정 처리*/
	public int confirmOrder(OrderModel orderModel);
	
	public int myOrderCount(Map<String, Object> map);
	
	
	public int buy(Map<String,Object> map);
		
	// 로그인 체크
	public Map<String, Object> loginCheck(Map<String, Object> map) throws Exception;

	// map으로 변경 시작
	// 장바구니에서 오더 시
	public List<Map<String, Object>> orderStart(Map<String, Object> map);
	
	public String getOrderNum();
	
}

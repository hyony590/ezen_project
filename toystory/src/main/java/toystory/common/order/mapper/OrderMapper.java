//작성자 : 이은정, 김용주
//작성일 : 2022/11/25
//용도 : ordermapper

package toystory.common.order.mapper;

import java.util.List;
import java.util.Map;

import toystory.common.order.model.OrderModel;
import toystory.utils.page.Criteria;


public interface OrderMapper {
	
	/** 주문 처리  
	 * @return */
	public int buy(OrderModel orderModel);
	
	/** 내 주문 리스트   */
	public List<OrderModel> myOrderList(Map<String, Object> map);
	
	/**관리자 주문 확인   */
	public List<OrderModel> adminOrderList(Criteria cri);
	
	/** 관리자 주문 수정 폼  */
	public OrderModel adminOrderModifyForm(String oNum);
	
	/** 관리자 주문 수정 처리  */
	public int adminOrderModifyPro(OrderModel orderModel);
	
	public int updateDelivery(OrderModel orderModel);
	
	public int orderCount(Criteria cri);
	
	public int myOrderCount(Map<String, Object> map);
	
	public int getOrderNum();
}

package toystory.common.admin.service;

import java.util.List;

import toystory.common.order.model.OrderModel;
import toystory.utils.page.Criteria;

public interface AdminOrderService {
	
	public List<OrderModel> adminOrderList(Criteria cri);
	
	public OrderModel orderDetail(String o_num);
	
	public int orderModify(OrderModel orderModel);
	
	public int orderCount(Criteria cri);
	
	
	
}

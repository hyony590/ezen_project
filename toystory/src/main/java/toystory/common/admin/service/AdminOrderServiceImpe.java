package toystory.common.admin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import toystory.common.order.mapper.OrderMapper;
import toystory.common.order.model.OrderModel;
import toystory.utils.page.Criteria;

@Service
@AllArgsConstructor
public class AdminOrderServiceImpe implements AdminOrderService{

	OrderMapper orderMapper;
	
	/**모든 orderList 리턴*/
	@Override
	public List<OrderModel> adminOrderList(Criteria cri) {
		return orderMapper.adminOrderList(cri);
	}

	
	/**order 1개 리턴*/
	@Override
	public OrderModel orderDetail(String o_num) {
		
		return orderMapper.adminOrderModifyForm(o_num);
	}

	
	/**order 1개 수정*/
	@Override
	public int orderModify(OrderModel orderModel) {
		
		return orderMapper.adminOrderModifyPro(orderModel);
	}


	@Override
	public int orderCount(Criteria cri) {
		
		return orderMapper.orderCount(cri);
	}

	

}

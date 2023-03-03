package toystory.common.basket.service;

import java.util.List;
import java.util.Map;

import toystory.common.basket.model.BasketModel;
import toystory.common.order.model.OrderModel;

public interface BasketService {

	// 장바구니 리스트
	List<Map<String, Object>> basketList(Map<String, Object> map) throws Exception;

	/* public List<BasketModel> basketList(String m_num); */

	// 장바구니 수정
	void basketModify(BasketModel basketModel) throws Exception;

	// 장바구니 한개 삭제
	void basketDeleteOne(BasketModel basketModel) throws Exception;

	public int addBasket(BasketModel basketModel);

	public List<BasketModel> getTempBasket(int m_num);

	// 장바구니 선택주문 시작
	public int buyItemBasket(Map<String, Object> map) ;

	public void delBuyItemBasket(Map<String, Object> map);

	public void deleteBasket(Map<String, Object> map);

}
package toystory.common.basket.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import toystory.common.basket.AbstractDAO;
import toystory.common.basket.model.BasketModel;

@Repository("basketDAO")
public class BasketDAO extends AbstractDAO {

	// 나의 장바구니 리스트
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> basketList(Map<String, Object> map) throws Exception {
		return (List<Map<String, Object>>) selectList("basket1.basketList", map);
	}

	// 장바구니 추가
	public int addBasket(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (Integer) insert("basket1.addBasket", map);
	}

	// 장바구니 수량 바꿀때 업데이트 처리
	public void basketModify(BasketModel basketModel) throws Exception {
		update("basket1.basketModify", basketModel);
	}

	// 장바구니에서 한개 삭제
	public void basketDeleteOne(BasketModel basketModel) throws Exception {
		update("basket1.basketDeleteOne", basketModel);
	}

	// 주문 페이지 이동할때 장바구니 삭제
	public int BasketDeleteAll(Map<String, Object> map) {
		return (Integer) delete("basket1.basketDeleteAll", map);
	}
	
	//장바구니에서 주문갈때 장바구니 삭제
	public int delBuyItemBasket(Map<String, Object> map) {
		return (Integer) delete("basket1.delBuyItemBasket",map);
	}
	
	//주문 처리 후 장바구니 삭제
	public int deleteBasket(Map<String, Object> map) {
		return (Integer) delete("basket1.deleteBasket",map);
	}

	// 이거 왜하는건지 우선 모름
	public int findBasket(Map<String, Object> map) {
		return (Integer) selectOne("basket1.findBasket", map);
	}
	
	public int basketTotal(Map<String, Object> map) {
		return (Integer) selectOne("basket1.basketTotal", map);
	}

	/*
	 * // 주문처리
	 * 
	 * @SuppressWarnings("unchecked") public List<Map<String, Object>>
	 * getOrderList(Map<String, Object> map) { // TODO Auto-generated method stub
	 * return (List<Map<String, Object>>) selectList("item.getOrderList", map); }
	 * 
	 * public int setOrder(Map<String, Object> map) { return (Integer)
	 * insert("item.setOrder", map); }
	 * 
	 * @SuppressWarnings("unchecked") public List<Map<String, Object>>
	 * getItemMatch(Map<String, Object> map) { // TODO Auto-generated method stub
	 * return (List<Map<String, Object>>) selectList("item.getItemMatch", map); }
	 */

}

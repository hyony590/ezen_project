package toystory.common.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import toystory.common.basket.AbstractDAO;

@Repository("orderDAO")
public class OrderDAO extends AbstractDAO{
	
	//주문처리
//	public int buy(Map<String, Object> map) {
//		return (Integer) insert("order1.buy",map);
//	}
	
	//주문폼 
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> orderStart(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>) selectList("orderMapper1.orderStart",map);
	}
	
	//주문 시 로그인 체크
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectId(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("orderMapper1.selectId", map);
	}
	
	//주문등록
	public int buy(Map<String, Object> map) {
		return (Integer) insert("orderMapper1.buy",map);
	}
}

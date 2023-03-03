package toystory.common.basket.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import toystory.common.basket.dao.BasketDAO;
import toystory.common.basket.mapper.BasketMapper;
import toystory.common.basket.model.BasketModel;
import toystory.common.goods.mapper.GoodsMapper;
import toystory.common.goods.model.GoodsModel;

@Service
public class BasketServiceImpl implements BasketService {

	@Autowired
	private BasketMapper basketMapper;
	@Autowired
	private GoodsMapper goodsMapper;

	@Resource(name = "basketDAO")
	private BasketDAO basketDAO;

	@Override
	public List<Map<String, Object>> basketList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return basketDAO.basketList(map);
	}


	@Override
	public void basketModify(BasketModel basketModel) throws Exception {
		// TODO Auto-generated method stub
		basketDAO.basketModify(basketModel);
	}

	@Override
	public void basketDeleteOne(BasketModel basketModel) throws Exception {

		basketDAO.basketDeleteOne(basketModel);
	}


	// 바로주문처리할때 임시로 장바구니에 담아두기 : 최창선
	@Override
	public int addBasket(BasketModel basketModel) {

		GoodsModel goodsModel = goodsMapper.goodsDetail(basketModel.getG_id());

		String g_name = goodsModel.getG_name();

		basketModel.setG_name(g_name);

		return basketMapper.addBasket(basketModel);
	}

	// 바로주문시 장바구니에서 임시데이터 가져오기 : 최창선
	@Override
	public List<BasketModel> getTempBasket(int m_num) {

		return basketMapper.getTempBasket(m_num);
	}

	// 장바구니 선택주문 시작
	@Override
	public int buyItemBasket(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return basketDAO.addBasket(map);
	}

	@Override
	public void delBuyItemBasket(Map<String,Object>map){
		// TODO Auto-generated method stub
		basketDAO.delBuyItemBasket(map);
	}

	// 주문 후 장바구니 삭제
	@Override
	public void deleteBasket(Map<String, Object> map) {
		// TODO Auto-generated method stub
		basketDAO.deleteBasket(map);
	}

}

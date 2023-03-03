//작성자 : 이은정, 김용주
//작성일 : 2022/11/25
//용도 : basketmapper

package toystory.common.basket.mapper;

import java.util.List;

import toystory.common.basket.model.BasketModel;


public interface BasketMapper {
	
	/**장바구니 처리  */
	/* public int addBasket(BasketModel basketModel) throws Exception; */
	
	/**장바구니 리스트  */
	public List<BasketModel> basketList(String m_um);
	
	/**장바구니 수정처리   */
	public int basketModify(BasketModel basketModel);
	
	/**장바구니 개별 삭제   */
	public int basketDeleteOne(int b_num);
	
	/**장바구니 전체 삭제  */
	public int basketDeleteAll(int m_num);
	
	/* 카트 확인 */
	public BasketModel checkBasket(BasketModel basketModel);
	
	
	/**최창선
	 * 상품디테일에서 바로주문시 basket_t 테이블에 임시자료 저장*/
	public int addBasket(BasketModel basketModel);
	
	
	/**최창선
	 * 상품디테일에서 바로주문시 basket_t 테이블에서 임시자료 불러오기*/
	public List<BasketModel> getTempBasket(int m_num);
	

	
	
}

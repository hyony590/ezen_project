package toystory.common.admin.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import toystory.common.goods.model.GoodsModel;

public interface AdminGoodsService {

	// 관리자 - 전체 상품 리스트 출력 / 12.15 페이징(매개변수) 추가
	public List<GoodsModel> goodsAllList(int amount, int pageNum);

	public void goodsRegister(GoodsModel goodsModel, HttpServletRequest request) throws Exception;

	 public boolean goodsModify(int g_id, GoodsModel goodsModel, HttpServletRequest request) throws Exception;

	public void goodsDelete(int g_Id);

	public List<GoodsModel> goodsRegisterNumber();

	// 12.15 상품 전체 개수 계산 메소드 추가
	public int goodsListTotalCountAll();
	
	public void fileDelete(int f_num);
}
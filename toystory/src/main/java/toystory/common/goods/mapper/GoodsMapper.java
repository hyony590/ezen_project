package toystory.common.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import toystory.common.goods.model.GoodsModel;

public interface GoodsMapper {

//   public List<GoodsModel> goodsList();

	// 회원 - 카테고리별 상품 리스트 출력 / 12.15 페이징(매개변수) 추가
	public List<GoodsModel> goodsList(@Param("g_category") String g_category, @Param("amount") int amount,
			@Param("pageNum") int pageNum, @Param("sort") String sort);

	// 관리자 - 전체 상품 리스트 출력 / 12.15 페이징(매개변수) 추가
	public List<GoodsModel> goodsAllList(@Param("amount") int amount, @Param("pageNum") int pageNum);

	public GoodsModel goodsDetail(int g_id);

	public void goodsRegister(GoodsModel goodsModel);

	public List<GoodsModel> goodsRegisterNumber();

	public int goodsModify(GoodsModel goodsModel);

	public void goodsDelete(int g_Id);

	public List<GoodsModel> goodsBestTop();

	public List<GoodsModel> goodsNewTop();

//   public List<GoodsModel> goodsSearchAll(GoodsModel keyword);

	//public List<GoodsModel> sort();

	public int goodsListTotalCount(GoodsModel g_category);

	public List<GoodsModel> goodsSearchAll( @Param("keyword")String keyword, @Param("g_category")String g_category, 
			@Param("amount") int amount, @Param("pageNum") int pageNum);

	// 카테고리별 상품 전체 개수 구하는 메소드
	public int goodsListTotalCount(String g_category);

	// 12.15 게시글 전체 개수 계산 메소드 추가
	public int goodsListTotalCountAll();
	
	//12.20 카테고리별 검색 개수 계산 메소드 추가
	public int goodsSearchCateCount(@Param("keyword")String keyword, @Param("g_category")String g_category);

}
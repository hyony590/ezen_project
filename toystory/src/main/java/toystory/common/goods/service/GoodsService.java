package toystory.common.goods.service;

import java.util.List;
import java.util.Map;

import toystory.common.goods.model.GoodsModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;
import toystory.utils.file.AttachFileModel;

public interface GoodsService {

//  public List<GoodsModel> goodsList();

	public List<AttachFileModel> imageList(Map<String, Object> map);

	//카테고리별 상품 리스트 출력 / 12.15 페이징(매개변수) 추가
	public List<GoodsModel> goodsList(String g_category, int amount, int pageNum, String sort);

	public GoodsModel goodsDetail(int g_id);

	public List<GoodsModel> goodsBestTop();

	public List<GoodsModel> goodsNewTop();

//  public List<GoodsModel> goodsSearchAll(GoodsModel keyword);

	//public List<GoodsModel> sort();

	public int goodsListTotalCount(String g_category);

	public List<GoodsModel> goodsSearchAll(String keyword, String g_category, int amount, int pageNum);
	
	//추가
		public int goodsSearchCateCount(String keyword, String g_category);

	/*
	 * 작성자: 강승현, 장한원 용도: 상품 상세보기에서 보이는 리뷰/문의 관련
	 */
	// 상품 상세보기에서 리뷰 리스트 띄우기
	public List<ReviewModel> selectReview(int g_id, int amount, int pageNum);

	// 상품 상세보기에서 문의 리스트 띄우기
	public List<QnaModel> selectQna(int g_id, int Qamount, int QpageNum);

	// 상품 상세보기에서 문의 작성폼에 값 넘겨줌
	public QnaModel qnaRegister(int g_id);

	// 상품 상세보기에서 문의 작성 처리
	public void qnaRegisterPro(QnaModel qnaModel);

	//상품 상세보기에서 페이징을 위한 리뷰 게시물 총합
	public int goodsReviewTotal(int g_id);

	//상품 상세보기에서 페이징을 위한 문의 게시물 총합
	public int goodsQnaTotal(int g_id);

}


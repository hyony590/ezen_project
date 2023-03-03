package toystory.common.goods.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import toystory.common.file.mapper.FileMapper;
import toystory.common.god.mapper.GodMapper;
import toystory.common.goods.mapper.GoodsMapper;
import toystory.common.goods.model.GoodsModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;
import toystory.utils.file.AttachFileModel;

@Service
@AllArgsConstructor
public class GoodsServiceImpl implements GoodsService {

	private GoodsMapper goodsMapper;
	private GodMapper godMapper;
	private FileMapper fileMapper;

//  @Override
//  public List<GoodsModel> goodsList() {
//     return goodsMapper.goodsList();
//  }

	// 카테고리별 상품 리스트 출력 / 12.15 페이징(매개변수) 추가
	@Override
	public List<GoodsModel> goodsList(String g_category, int amount, int pageNum, String sort) {
		return goodsMapper.goodsList(g_category, amount, pageNum, sort);
	}

	@Override
	public GoodsModel goodsDetail(int g_id) {
		return goodsMapper.goodsDetail(g_id);
	}

	// 최창선 굳즈 상세 이미지 리스트 가져가기~
	public List<AttachFileModel> imageList(Map<String, Object> map) {
		return fileMapper.imageList(map);
	}

	// 상품 Best3 띄우는 메소드
	@Override
	public List<GoodsModel> goodsBestTop() {
		return goodsMapper.goodsBestTop();
	}

	// 상품 New3 띄우는 메소드
	@Override
	public List<GoodsModel> goodsNewTop() {
		return goodsMapper.goodsNewTop();
	}

	// 상품 정렬
	/*
	 * @Override public List<GoodsModel> sort() { return goodsMapper.sort(); }
	 */

	// 카테고리별 상품 전체 개수 구하는 메소드
	@Override
	public int goodsListTotalCount(String g_category) {
		return goodsMapper.goodsListTotalCount(g_category);
	}

	@Override
	public List<GoodsModel> goodsSearchAll(String keyword, String g_category, int amount, int pageNum) {
		return goodsMapper.goodsSearchAll(keyword,g_category, amount, pageNum);

	}
	
	@Override //12.20 추가
	public int goodsSearchCateCount(String keyword, String g_category) {
		
			return goodsMapper.goodsSearchCateCount(keyword, g_category);	
	}

	/*
	 * 작성자: 강승현, 장한원 용도: 상품 상세보기에서 보이는 리뷰/문의 관련
	 */
	// 상품 상세보기에서 리뷰 리스트 띄움
	// 상품 상세보기에서 리뷰 리스트 띄움
		@Override
		public List<ReviewModel> selectReview(int g_id, int amount, int pageNum) {
			return godMapper.selectReview(g_id, amount, pageNum);
		}

		// 상품 상세보기에서 문의 리스트 띄움
		@Override
		public List<QnaModel> selectQna(int g_id, int Qamount, int QpageNum) {
			return godMapper.selectQna(g_id, Qamount, QpageNum);
		}

		@Override
		public int goodsReviewTotal(int g_id) {
			// TODO Auto-generated method stub
			return godMapper.goodsReviewTotal(g_id);
		}

		@Override
		public int goodsQnaTotal(int g_id) {
			// TODO Auto-generated method stub
			return godMapper.goodsQnaTotal(g_id);
		}

		// 상품 상세보기에서 문의 작성 처리
		@Override
		public void qnaRegisterPro(QnaModel qnaModel) {
			godMapper.qnaRegisterPro(qnaModel);
		}
		
		// 상품 상세보기에서 문의 작성폼에 값 넘겨줌
		@Override
		public QnaModel qnaRegister(int g_id) {
			return godMapper.qnaRegister(g_id);
		}

}
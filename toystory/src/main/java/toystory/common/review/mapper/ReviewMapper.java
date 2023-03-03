/* 작성자: 강승현
   작성일: 22/11/25
   작성용도: 리뷰 게시판 관련 메소드들을 정의한 mapper
 */

package toystory.common.review.mapper;

import toystory.common.god.mapper.GodMapper;
import toystory.common.review.model.ReviewModel;

public interface ReviewMapper {
	
	public int reviewRegister(ReviewModel vo);
	
	public GodMapper selectReview(int gId);
	
}

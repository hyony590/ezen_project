/* 작성자: 강승현
   작성일: 22/11/25
   작성용도: 문의사항 관련 메소드들을 정의한 mapper
 */

package toystory.common.qna.mapper;

import toystory.common.god.mapper.GodMapper;
import toystory.common.qna.model.QnaModel;

public interface QnaMapper {
	
	public int qnaRegister(QnaModel vo);
	
	public GodMapper selectQna(int gId);
	
}

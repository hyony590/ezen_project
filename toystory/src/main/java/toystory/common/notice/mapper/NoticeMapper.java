/* 작성자: 강승현
   작성일: 22/11/25
   작성용도: 공지, 이벤트 게시판 관련 메소드들을 정의한 mapper
 */

package toystory.common.notice.mapper;

import java.util.List;

import toystory.common.god.mapper.GodMapper;
import toystory.common.notice.model.NoticeModel;

public interface NoticeMapper {

	public int noticeRegister(GodMapper vo);

	public int upNoticeHitCount(int nNum);

	public List<NoticeModel> selectNotice();

	public int noticeDelete(int nNum);

	public int noticeModify(int nNum);

}

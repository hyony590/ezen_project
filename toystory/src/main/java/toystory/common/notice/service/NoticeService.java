/* 작성자: 강승현
 * 작성일: 22/11/29
 * 용도: 공지,이벤트게시판 서비스 인터페이스
 */

package toystory.common.notice.service;

import java.util.List;

import toystory.common.god.model.GodModel;
import toystory.common.notice.model.NoticeModel;

public interface NoticeService {

	// public void noticeRegister(GodModel godModel) throws Exception;

	// public void upNoticeHitCount(int nNum) throws Exception;

	// 작성자 : 이효원, 남재욱 - 12.15 페이징(매개변수) 추가
	public List<NoticeModel> selectNotice(int amount, int pageNum);

	// 작성자 : 이효원, 남재욱 - 12.15 게시글 전체 개수 계산 메소드 추가
	public int noticeListTotalCount();


	public NoticeModel noticeDetail(int n_num);

	public void upNoticeHitCount(int n_num, int n_count);

	// public int noticeDelete(int nNum) throws Exception;

	// public int noticeModify(int nNum) throws Exception;
}
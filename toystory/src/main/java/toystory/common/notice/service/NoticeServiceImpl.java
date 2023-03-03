/* 작성자: 강승현
 * 작성일: 22/11/29
 * 용도: 공지,이벤트게시판 ServiceImplements
 */
package toystory.common.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.god.mapper.GodMapper;
import toystory.common.notice.mapper.NoticeMapper;
import toystory.common.notice.model.NoticeModel;

@Log4j
@Service
@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService {
   
   private NoticeMapper noticeMapper;
   private GodMapper godMapper;
   
   // 작성자 : 이효원, 남재욱 - 12.15 페이징(매개변수) 추가
   @Override
   public List<NoticeModel> selectNotice(int amount, int pageNum) {
      // TODO Auto-generated method stub
      return godMapper.selectNotice(amount, pageNum);
   }


   @Override
   public NoticeModel noticeDetail(int n_num) {
      // TODO Auto-generated method stub
      return godMapper.noticeDetail(n_num);
   }

   @Override
   public void upNoticeHitCount(int n_num, int n_count) {
      
       godMapper.upNoticeHitCount(n_num, n_count);
   }
   // 작성자 : 이효원, 남재욱 - 12.15 게시글 전체 개수 계산 메소드 추가
  	@Override
  	public int noticeListTotalCount() {
  		return godMapper.noticeListTotalCount();
  	}

   


   
   
   
   
   

//   @Override
//   public void noticeRegister(GodModel godModel) throws Exception {
//      
//      log.info("register......" + godModel);
//      
//      noticeMapper.noticeRegister(godMapper);
//      
//   }

   /*
    * @Override public void upNoticeHitCount(int nNum) throws Exception { // TODO
    * Auto-generated method stub
    * 
    * }
    * 
    * 
    * 
    * @Override public int noticeDelete(int nNum) throws Exception { return nNum;
    * // TODO Auto-generated method stub
    * 
    * }
    * 
    * @Override public int noticeModify(int nNum) throws Exception { // TODO
    * Auto-generated method stub return nNum; }
    */

   

   

}
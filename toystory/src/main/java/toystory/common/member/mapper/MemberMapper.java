package toystory.common.member.mapper;


import java.util.List;

import toystory.common.member.model.MemberModel;
import toystory.utils.page.Criteria;

public interface MemberMapper {

   /**이용자 회원가입시 memberModel 받아서 insert*/
   public void insertMember(MemberModel memberModel);
   
   /**아이디 중복검사*/
   public int idCheck(String email);
   
   public MemberModel findAccount(MemberModel memberModel);
   
   
   //로그인 확인
   public MemberModel loginCheck(MemberModel memberModel);
   

   /**핸드폰 중복검사*/
   public int mobileCheck(String mobile);
   
   /**email 조건으로 이용자정보 1개 select*/
   public MemberModel memberDetail(String m_num);
   
   /**이용자 정보 수정 처리 update
 * @return */
   public int memberModify(MemberModel memberModel);
   
   /**이용자 탈퇴시 사용 update*/
   public int deleteMember(String email);
   
   /**비회원 제외한 전체 이용자 리스트 select*/
   public List<MemberModel> selectMemberList (Criteria cri);
   
   
   /**adult_check Y로 업데이트*/
   public int adultCheck(String loginNum);
   
   public int allMemberCount(Criteria cri);
   
   public int adminMemberModifyPro(MemberModel memberModel);
   
   
}


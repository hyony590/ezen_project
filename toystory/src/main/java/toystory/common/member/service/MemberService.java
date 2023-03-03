package toystory.common.member.service;

import java.sql.Date;
import java.util.List;

import toystory.common.member.model.MemberModel;
import toystory.utils.page.Criteria;

public interface MemberService {

	public void insertMember(MemberModel memberModel);
	
	public MemberModel loginCheck(MemberModel memberModel);
	
	public MemberModel findAccount(MemberModel memberModel);
	
	public int adultCheck(Date m_birth, String loginNum);
	
	public List<MemberModel> adminMemberList(Criteria cri);
	
	public int idCheck(String email);
	
	public int mobileCheck(String mobile);
	
	public int totalMemberCount(Criteria cri);
	
}

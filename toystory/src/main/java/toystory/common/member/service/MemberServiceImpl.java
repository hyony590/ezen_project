package toystory.common.member.service;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.member.mapper.MemberMapper;
import toystory.common.member.model.MemberModel;
import toystory.utils.page.Criteria;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{

	private MemberMapper memberMapper;
	
	@Override
	public void insertMember(MemberModel memberModel) {
		memberMapper.insertMember(memberModel);
		
		
	}

	@Override
	public MemberModel loginCheck(MemberModel memberModel) {
		MemberModel resultModel = memberMapper.loginCheck(memberModel);
		

		return resultModel;
		
	}

	@Override
	public MemberModel findAccount(MemberModel memberModel) {

		MemberModel resultModel = memberMapper.findAccount(memberModel);
		
		return resultModel;
	}

	
	/** -1: 미성년, 0:비회원성인, 1: 회원 성인, 성인여부 Y로 변경됨, -100: 오류, 나이 계산 안됨, -200: update 1개 이상인데
	 * 후순위로 트렌젝션 rollback 필요*/
	@Override
	public int adultCheck(Date m_birth, String loginNum) {
		
		Calendar now = Calendar.getInstance();
		int currentYear = now.get(Calendar.YEAR);
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		String StringBirthYear = format.format(m_birth);
		int birthYear = Integer.parseInt(StringBirthYear);
		int age = currentYear - birthYear + 1;
		
		
		if(age < 20) {
			//성인 아님
			return -1;
			
		}else if(age >= 20) {
			if(loginNum == null || loginNum.isBlank()) {
				return 0;
				//비회원 성인
			}else {
				int check = memberMapper.adultCheck(loginNum);
				//성인이면 m_adult Y로 업데이트, 결과값 1 아니면 문제있음...
				if(check != 1) {
					return -200;
				}
				
				return check;
			}
		}else {
			return -100;
			//오류 코드
		}
		
	}

	@Override
	public List<MemberModel> adminMemberList(Criteria cri) {

		
		List<MemberModel> memberList = new ArrayList<>();
		
		memberList = memberMapper.selectMemberList(cri);
		return memberList;
	}

	
	//아이디 중복 체크
	@Override
	public int idCheck(String email) {
		
		return memberMapper.idCheck(email);
		
	}

	@Override
	public int mobileCheck(String mobile) {

		
		return memberMapper.mobileCheck(mobile);
	}
	
	@Override
	public int totalMemberCount(Criteria cri) {
		return memberMapper.allMemberCount(cri);
	}
	
	

	

}

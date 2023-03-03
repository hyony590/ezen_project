package toystory.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;
import toystory.common.member.mapper.MemberMapper;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src\\main\\webapp\\WEB-INF\\spring\\root-context.xml")
@Log4j
public class MemberMapperTests {
	
	private MemberMapper mapper;
	
	
	
	@Test
	public void testSelect() {
		int model = mapper.idCheck("1");
		log.info(model + "ssssssssssssssssss");
	}

}

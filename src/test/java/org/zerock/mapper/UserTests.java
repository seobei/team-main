package org.zerock.mapper;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.AuthVO;
import org.zerock.domain.UserVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		{"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
			"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class UserTests {

	
	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	@Test
	public void test() {
		assertNotNull(mapper);
		
		assertNotNull(encoder);
	}
	
	
	//데이터 추가 
	// expected = Exception.class ?????
	//실패해도 초록불? 
	//@Test(expected = Exception.class)
	@Test
	public void testInsert2() {
		UserVO vo1 = new UserVO();
		vo1.setUserid("member");
		vo1.setUserpw(encoder.encode("member")); // encode
		vo1.setUserName("멤");
		vo1.setUserPhone("01034567892");
		vo1.setUserEmail("so122@abc.com");
		
		mapper.insert(vo1);
	}
	
	//데이터조회  
	@Test
	public void testread() {
		UserVO vo = mapper.read("admin");
		assertEquals("어드민", vo.getUserName());
	}
	
	//권한 넣기 ! 
	@Test
	public void testInsertAuth() {
		AuthVO vo1 = new AuthVO();
		vo1.setAuth("ROLE_MEMBER");
		vo1.setUserid("member");
		mapper.insertAuth(vo1);
		
		vo1.setAuth("ROLE_MEMBER");
		vo1.setUserid("admin");
		mapper.insertAuth(vo1);
		
		vo1.setAuth("ROLE_ADMIN");
		vo1.setUserid("admin");
		mapper.insertAuth(vo1);
	}

}

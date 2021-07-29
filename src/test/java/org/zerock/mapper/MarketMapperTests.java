package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.MarketVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		{"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
		 "file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class MarketMapperTests {

	@Setter(onMethod_ = @Autowired)
	private MarketMapper mapper;
	
	/* 상품 조회 페이지 */
	@Test
	public void getdetail() {
		
		int mno = 150;
		
		MarketVO result = mapper.getdetail(mno);
		
		log.info("상품 조회 데이터 : " + result);
		
		
	}

}

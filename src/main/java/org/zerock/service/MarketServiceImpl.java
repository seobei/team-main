package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.Criteria;
import org.zerock.domain.MarketVO;
import org.zerock.mapper.MarketMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MarketServiceImpl implements MarketService {
	
	@Setter (onMethod_ = @Autowired)
	private MarketMapper mapper;
	
	@Override
	public boolean insert(MarketVO vo) {
		int cnt = mapper.insert(vo);
		log.info("hello");
		return cnt == 1;
	}

	@Override
	public MarketVO getdetail(int mno) {
		return mapper.getdetail(mno);
	}

	@Override
	public List<MarketVO> getList(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		//게시글 총 갯수 구하는 매퍼  
		return mapper.getTotalCount(cri); 
	}

}
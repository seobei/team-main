package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.UserVO;
import org.zerock.domain.MarketVO;
import org.zerock.domain.Market_fileVO;

public interface Market_fileMapper {
	
	public int insert(Market_fileVO mfvo);
	
	public List<String> getByMno(int mno);
	
	public int deleteBYMno(int mno);
	
	public int update(MarketVO mvo);

}

package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.MarketVO;

public interface MarketService {
	
	//데이터 추가 
	boolean insert(MarketVO vo);
	
	
	//데이터 가져오기 
	MarketVO getdetail(int mno);
	
	//데이터 수정 
//	boolean modify(UserVO vo);
//	boolean modifyPassword(UserVO vo, String oldPassword);
//	boolean modifyPassword(UserVO vo);
	
	//데이터 삭제 
//	boolean remove(UserVO vo);
//	boolean remove(UserVO vo, String inputPassword);
	
	// 리스트
	public List<MarketVO> getList(Criteria cri);

	// 총 페이지
	public int getTotal(Criteria cri);
	
	
}
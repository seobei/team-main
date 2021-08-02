package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.MarketVO;

public interface MarketMapper {

	// 상품 등록
	public int insert(MarketVO mvo);
	
	public int insertSelectKey(MarketVO mvo); 
	
	// 데이터 조회
	public MarketVO read(int mno);
		
	// 데이터 수정 
	public int update(MarketVO mvo);
		
	// 데이터 삭제
	public int delete(int mno);
	
//	@Select("SELECT * FROM tbl_board") 
// 쿼리가 여러 줄이 될 경우, 관리하기가 어려우니
// 따로 관리할 수 있는 파일을 만들어 둘 것
	
	// 데이터 리스트
	public List<MarketVO> getList();
		
	// 페이징 : 게시글 총 갯수
	public int getTotalCount(Criteria cri);
	
	// 페이징 리스트
	// Criteria = int amount , int pageNum
	public List<MarketVO> getListWithPaging(Criteria cri);
		
}
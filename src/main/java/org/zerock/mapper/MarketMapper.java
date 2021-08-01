package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.MarketVO;
import org.zerock.domain.WishlistVO;

public interface MarketMapper {

	// 상품 등록
	public int insert(MarketVO mvo);
	
	public int insertSelectKey(MarketVO mvo); 
	
	// 찜상품 등록
	public int insertWish(WishlistVO wvo);
	

	// 데이터조회하기 
	public MarketVO getdetail(int mno);
	
	// 생각을해본다
	//데이터 수정하기 
//	public int update(MarketVO vo);
	
	//테이터 삭제
//	public int remove(MarketVO vo);
//	public int removeWish(MarketVO vo);
	
	
//	@Select("SELECT * FROM tbl_board") 
// 쿼리가 여러 줄이 될 경우, 관리하기가 어려우니
// 따로 관리할 수 있는 파일을 만들어 둘 것
	public List<MarketVO> getList();
		
	// Criteria = int amount , int pageNum
	public List<MarketVO> getListWithPaging(Criteria cri);
		
	// 페이징 : 게시글 총 갯수
	public int getTotalCount(Criteria cri);
}
package org.zerock.domain;

import lombok.Data;

@Data
public class WishlistVO {
	
	
	private String mwriter;
	private int mno;
	// DB에 찜 개수 카운트 추가함(이름 뭐라할 지 몰라서 heart 기본값 0)
	private int heart;
}
package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MarketVO {

	private int mno;
	private String mwriter;
	private String mtitle;
	private int mprice;
	private String mdetail;
	private Date mregdate;
	private String maddress;
	
	
}
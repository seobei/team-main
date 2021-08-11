package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Order_infoVO {
	
	private long orderno;
	private String userid;
	private String orderRec;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private String orderphone;
	private long amount;
	private Date orderdate;

}

package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OtoAnswerVO {
	
	private int aono;
	private int qono;
	private String content;
	private String userid;
	private Date regdate;
}

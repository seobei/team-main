package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OtoVO {
	private int qono; 
    private String otitle;
    private String userid;
    private String odetail;
    private Date oregdate;
}

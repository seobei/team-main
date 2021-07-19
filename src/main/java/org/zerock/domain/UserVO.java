package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {

	private String userid;
	private String userpw;
	private String userName;
	private int userphone;
	private String userem;
	private String useradd;
	private Date regdate;
	private Date updateDate;
	private boolean enabled;
}

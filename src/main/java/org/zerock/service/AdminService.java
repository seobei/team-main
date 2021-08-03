package org.zerock.service;

import java.util.List;

import org.zerock.domain.UserVO;

public interface AdminService {
	
	boolean getUserinsert(UserVO user);
	boolean getCompinsert(UserVO comp);
	void Userupdate(UserVO vo);
	void Compupdate(UserVO vo);
	void Userdelete(UserVO vo);
	void Compdelete(UserVO vo);
	
	List<UserVO> getUserlist();
	List<UserVO> getComplist();
}

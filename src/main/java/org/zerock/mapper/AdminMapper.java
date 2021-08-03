package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.AuthVO;
import org.zerock.domain.UserVO;

public interface AdminMapper {
	
	public List<UserVO> getUserlist();	
	public int getUserinsert(UserVO user);
	public int getUserinsertAuth(AuthVO userauth);
	public void Userupdate(UserVO vo);
	public void Userdelete(UserVO vo);
	
	
	public List<UserVO> getComplist();
	public int getCompinsert(UserVO comp);
	public int getCompinsertAuth(AuthVO compauth);
	public void Compupdate(UserVO vo);
	public void Compdelete(UserVO vo);
}

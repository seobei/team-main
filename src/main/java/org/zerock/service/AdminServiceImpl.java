package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.domain.AuthVO;
import org.zerock.domain.UserVO;
import org.zerock.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	//일반회원 리스트조회
	@Override
	public List<UserVO> getUserlist(){
		return mapper.getUserlist();
	}
	
	//일반회원 추가
	@Override
	public boolean getUserinsert(UserVO user) {
		
		// 패스워드 암호화
		user.setUserpw(encoder.encode(user.getUserpw()));
		int cnt = mapper.getUserinsert(user);

		// 권한 입력
		AuthVO avo = new AuthVO();
		avo.setUserid(user.getUserid());
		avo.setAuth("ROLE_USER");
		mapper.getUserinsertAuth(avo);

		return cnt == 1;
	}
	
	//일반회원 정보수정
	@Override
	public void Userupdate(UserVO vo) {
		mapper.Userupdate(vo);
	}
	
	//일반회원 회원탈퇴
	@Override
	public void Userdelete(UserVO vo) {
		mapper.Userdelete(vo);
	}
	
	//업체회원 리스트조회
	@Override
	public List<UserVO> getComplist(){
		return mapper.getComplist();
	}
	
	//업체회원 추가 
	@Override
	public boolean getCompinsert(UserVO comp) {
		
		
		// 패스워드 암호화
		comp.setUserpw(encoder.encode(comp.getUserpw()));
		int cnt = mapper.getCompinsert(comp);

		// 권한 입력
		AuthVO avo = new AuthVO();
		avo.setUserid(comp.getUserid());
		avo.setAuth("ROLE_BUSINESS");
		mapper.getCompinsertAuth(avo);

		return cnt == 1;
	}
	
	//업체회원 정보수정
	@Override
	public void Compupdate(UserVO vo) {
		mapper.Compupdate(vo);
	}
	
	//업체회원 회원탈퇴
	@Override
	public void Compdelete(UserVO vo) {
		mapper.Compdelete(vo);
	}
}

package org.zerock.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.MessageVO;
import org.zerock.domain.UserVO;
import org.zerock.mapper.MessageMapper;

import lombok.Setter;

@Service
public class MessageServiceImpl implements MessageService {

    @Setter(onMethod_ = @Autowired)
    private MessageMapper mapper;

    @Override
    public boolean mesinsert(MessageVO vo) {
        
    	int cnt = mapper.mesinsert(vo);
        
        return cnt == 1;
    }

	

	@Override
	public List<MessageVO> getListSend(MessageVO vo) {
		return mapper.getListSend(vo);
	}



	@Override
	public List<MessageVO> getListReceive(MessageVO vo) {
		return mapper.getListReceive(vo);
	}
	
	/*
	 * @Override public MessageVO read(String name) {
	 * 
	 * return mapper.read(name); }
	 */

}
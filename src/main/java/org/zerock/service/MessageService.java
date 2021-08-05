package org.zerock.service;

import java.util.List;

import org.zerock.domain.MessageVO;


public interface MessageService {
    public boolean mesinsert(MessageVO vo);
    public List<MessageVO> getListSend(MessageVO vo, Integer page);
	public List<MessageVO> getListReceive(MessageVO vo, Integer page);
	
	public void mesdelete(MessageVO vo);
	public List<MessageVO> getSearchMessageList(String searchValue);
	
	
	int getTotalListSend(MessageVO vo);
	int getTotalListReceive(MessageVO vo);


}
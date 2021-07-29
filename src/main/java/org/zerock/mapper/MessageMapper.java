package org.zerock.mapper;

import java.util.List;
import org.zerock.domain.MessageVO;
import org.zerock.domain.UserVO;

public interface MessageMapper {
	
    public int mesinsert(MessageVO vo);
    public List<MessageVO> getListSend(MessageVO vo);
    public List<MessageVO> getListReceive(MessageVO vo);
//    public MessageVO read(String writer);

    
}
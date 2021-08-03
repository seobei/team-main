package org.zerock.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MessageVO;
import org.zerock.domain.UserVO;
import org.zerock.service.MessageService;
import org.zerock.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/message")
public class MessageController {
	
	@Setter(onMethod_ = @Autowired)
	private UserService service;
	
	@Setter(onMethod_ = @Autowired)
	private MessageService messageservice;
	
	
	@GetMapping("/mgsend")
	@PreAuthorize("isAuthenticated()")
	public void listsend(Principal principal, MessageVO vo, Model model) {
	log.info("mgsend");
	vo.setWriter(principal.getName());
	List<MessageVO> list = messageservice.getListSend(vo);
	model.addAttribute("listsend", list);
	
	log.info("mgsendprincipal method");
    log.info(principal.getName());
    UserVO uservo = service.read(principal.getName());
	model.addAttribute("uservo", uservo);
    }
    
    @PostMapping("/mgsend")       
    public String listsendPost(MessageVO vo, RedirectAttributes rttr) {
        log.info("listsendPost method");
        boolean success = messageservice.mesinsert(vo);
        if (success) {
        	rttr.addFlashAttribute("message", "메시지가 발송 되었습니다. ");           	
		} else {
      	   rttr.addFlashAttribute("message", "수신자가 존재하지 않습니다. ");
        }
        return "redirect:/message/mgsend";           
    }
    
    @GetMapping("/mgreceive")
	@PreAuthorize("isAuthenticated()")
	public void listrecevie(Principal principal, MessageVO vo, Model model) {
	log.info("mgsend");
	vo.setWriter(principal.getName());
	List<MessageVO> list = messageservice.getListReceive(vo);
	model.addAttribute("listReceive", list);

	log.info("mgsendprincipal method");
    log.info(principal.getName());
    UserVO uservo = service.read(principal.getName());
	model.addAttribute("uservo", uservo);
    }
    
    @PostMapping("/mgreceive")
    public String listreceviePost(MessageVO vo, RedirectAttributes rttr) {
        log.info("listreceviePost method");
        boolean success = messageservice.mesinsert(vo);
        if (success) {
        	rttr.addFlashAttribute("message", "메시지가 발송 되었습니다. ");           	
		} else {
			rttr.addFlashAttribute("message", "수신자가 존재하지 않습니다. ");
        }
       // 이부분이다 설명을 듣고 싶으면 mgreceive.jsp로 가라
        return "redirect:/message/mgreceive";           
    }
}

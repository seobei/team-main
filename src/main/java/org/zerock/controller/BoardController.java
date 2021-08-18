package org.zerock.controller;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")

public class BoardController {
	
        @Setter(onMethod_=@Autowired)
        private UserService userservice;

        @Setter(onMethod_=@Autowired)
        private MessageService messageservice;

        @GetMapping("/usedBoard")
        @PreAuthorize("isAuthenticated()")
        public void usedBoard(Principal principal, Model model) {
            log.info("usedBoardGet method");
            log.info(principal.getName());
            UserVO uservo = userservice.read(principal.getName());
    		model.addAttribute("uservo", uservo);

        }
        @PostMapping("/usedBoard")
        @PreAuthorize("isAuthenticated()")
        public String usedBoardPost(MessageVO vo, RedirectAttributes rttr) {
            log.info("usedBoardPost method");

            boolean success = messageservice.mesinsert(vo);
            
            if (success) {
            	rttr.addFlashAttribute("message", "메시지가 발송 되었습니다. ");
            	
    		}
           
                return "redirect:/board/usedBoard";
           
        }
        
}
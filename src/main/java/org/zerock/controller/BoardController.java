package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.MarketVO;
import org.zerock.domain.PageDTO;
import org.zerock.service.MarketService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")
@AllArgsConstructor
public class BoardController {
	
	@Setter (onMethod_ = @Autowired)
	private MarketService service;
	

        @GetMapping("/market")
        public void market(@ModelAttribute("cri") Criteria cri, Model model) {
            log.info("market method");
       		int total = service.getTotal(cri);    
       		
    		List<MarketVO> list = service.getList(cri);

    		model.addAttribute("list", list);
    		model.addAttribute("pageMaker", new PageDTO(cri, total));
    		
        }     
        

    	@GetMapping("/write")
    	public void write(@ModelAttribute("cri") Criteria cri) {
    		
    	}
        
        @PostMapping("/write")
        public String write(MarketVO mvo, 
        		@RequestParam("market_file") MultipartFile[] market_file , RedirectAttributes rttr) {
        	
        	service.write(mvo, market_file);
    		
        	rttr.addFlashAttribute("result", mvo.getMno());


        	return "redirect:/board/market"; 
    		} 		
    	
        
              
		@GetMapping({"/getdetail", "/modify"})
		public void get(@RequestParam("mno") int mno, @ModelAttribute("cri") Criteria cri, Model model) {
            log.info("board/detail method");

            MarketVO mvo = service.read(mno);
            
            model.addAttribute("market", mvo);
            
        }
		
		
		@PostMapping("/modify")
//		@PreAuthorize("principal.username == #board.writer") // 720 쪽
//		@PreAuthorize("authication.name == #board.writer") // spring.io
		public String modify(MarketVO mvo, Criteria cri, 
				@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {

			boolean success = service.modify(mvo, file);
			
			if (success) {
				rttr.addFlashAttribute("result", "success");
				rttr.addFlashAttribute("messageTitle", "수정 성공");
				rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
			}
			
			rttr.addAttribute("pageNum", cri.getPageNum());
			rttr.addAttribute("amount", cri.getAmount());
//			rttr.addAttribute("type", cri.getType());
//			rttr.addAttribute("keyword", cri.getKeyword());
			
			return "redirect:/board/market";
		}
		
		
        
}

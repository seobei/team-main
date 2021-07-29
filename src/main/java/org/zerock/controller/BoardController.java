package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.Criteria;
import org.zerock.domain.MarketVO;
import org.zerock.domain.PageDTO;
import org.zerock.service.MarketService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board")

public class BoardController {
	
	@Setter (onMethod_ = @Autowired)
	private MarketService service;
	

        @GetMapping("/market")
        public void market(@ModelAttribute("cri") Criteria cri, Model model) {
            log.info("market method");
       		int total = service.getTotal(cri);    
       		
    		// service getList() 실행 결과를
    		List<MarketVO> list = service.getList(cri);
    		// model에 attribute로 넣고
    		model.addAttribute("list", list);
    		model.addAttribute("pageMaker", new PageDTO(cri, total));
    		
    		// view로 포워드            

        }
        
        
    
		/*
		 * @PostMapping("/usedBoard") public String usedBoardPost(BoardVO vo,
		 * RedirectAttributes rttr) { log.info("usedBoardPost method");
		 * 
		 * boolean ok = boardservice.insert(vo);
		 * 
		 * if (ok) { return "redirect:/board/usedBoard"; } else { return
		 * "redirect:/board/usedBoard?error"; } }
		 */
        
    	// cri 파라미터 값을 넣어 페이지에 대한 값을 입력해주기
    	@GetMapping("/write")
    	public void register(@ModelAttribute("cri") Criteria cri) {
    		// forward /WEB-INF/views/board/register.jsp
    	}
        
        
        
        @PostMapping("/write")
    	public String write(MarketVO market, RedirectAttributes rttr) {
    		
    		
    		// title, content, writer

			/*
			 * // redirect목적지로 정보 전달 rttr.addFlashAttribute("result", market.getMno());
			 * rttr.addFlashAttribute("messageTitle", "등록 성공");
			 * rttr.addFlashAttribute("messageBody", market.getMno() + "번 게시물이 등록 되었습니다.");
			 */
        	
        	// service에게 등록업무 시키고
    		boolean ok = service.insert(market); 
    		
    		if (ok) {
    			return "redirect:/board/market"; 
    		} else {
    			return "redirect:/board/market?error";
    		} 		
    	}
        
              
        @GetMapping("/detail")
        public void getdetail(@RequestParam("mno") int mno, Model model) {
            log.info("board/detail method");

            // getdetail 메소드 실행하라고 시킴
            MarketVO vo = service.getdetail(mno);
            
            // 가져온 결과 값을 모델에 담아서 응답
            model.addAttribute("market", vo);
            
            // forward 생략 가능
        }
        
}

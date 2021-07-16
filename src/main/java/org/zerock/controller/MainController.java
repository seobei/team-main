package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/gohome")

//질문 : view -> gohome 폴더? /main 루트 ,@RequestMapping 검색해보기 
public class MainController {

	@RequestMapping("/main")
	public void main() {
		log.info("main method");
	}
}

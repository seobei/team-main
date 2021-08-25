package org.zerock.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.CBoardVO;
import org.zerock.domain.MarketVO;
import org.zerock.domain.NoticeVO;
import org.zerock.domain.SProductVO;
import org.zerock.domain.UserVO;
import org.zerock.service.CBoardService;
import org.zerock.service.CsService;
import org.zerock.service.MarketService;
import org.zerock.service.SProductService;
import org.zerock.service.UserService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/main")

//질문 : view -> main 폴더? /home 루트 ,@RequestMapping 검색해보기 
public class MainController {
	

	@Setter(onMethod_ = @Autowired)
	private UserService service;
	
	@Setter(onMethod_ = @Autowired)
    private CBoardService cboardservice;	
	
	@Setter(onMethod_ = @Autowired)
	private MarketService marketservice;
	
	@Setter(onMethod_ = @Autowired)
	private CsService csservice;
	
	@Setter(onMethod_ = @Autowired)
	private SProductService sproductservice;
	
	//메인 홈 
	@RequestMapping("/home")
	public void main(Model model) {
		List<CBoardVO> cboardlist = cboardservice.getCbMainList();
		List<MarketVO> marketlist = marketservice.getMarketMainList();
		List<NoticeVO> noticelist = csservice.getNoticeMainList();
		List<SProductVO> storelist = sproductservice.getsproductMainList(); 
		
		model.addAttribute("cboardList", cboardlist);
		model.addAttribute("marketlist", marketlist);
		model.addAttribute("noticelist", noticelist);
		model.addAttribute("storelist", storelist);
		
		log.info("home method");
		
	}
	
	
	//로그인 
	@RequestMapping("/login")
	public void login() {
		log.info("login method");
	}
	
	
	//약관동의  
	@RequestMapping("/tos")
	public void tos() {
		log.info(" Terms of service method");
	}

	//회원가입 
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public void signup() {
		log.info(" singup method");
	}
	
	//회원가입 버튼 클릭시 -> 회원가입정보저장 되는 코드 
	@PostMapping("/signup")
	public String signupPost(UserVO vo, RedirectAttributes rttr) {
		log.info(" singupPost method");

		boolean ok = service.insert(vo);

		if (ok) {
			return "redirect:/main/login";
		} else {
			return "redirect:/main/signup?error";
		}
	}
	
	//아이디 중복 확인
	@GetMapping("/dup")
	@ResponseBody
	public ResponseEntity<String> duplicate(String id) {
		log.info("duplicate method");

		// 서비스 일 시키고
		UserVO vo = service.read(id);

		if (vo == null) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<> ("exist", HttpStatus.OK);
		}

	}
	
	//기업용 회원가입B
	@RequestMapping(value = "/signupB", method = RequestMethod.GET)
	public void signupB() {
		log.info(" singupBG method");
	}
	
	//기업용 회원가입B
	@RequestMapping(value = "/signupB", method = RequestMethod.POST)
	public String signupB(UserVO vo, RedirectAttributes rttr) {
		log.info(" singupBP method");

		boolean ok = service.insertB(vo);

		if (ok) {
			return "redirect:/main/login";
		} else {
			return "redirect:/main/signupB?error";
		}
	}
	
    //아이디 찾기 페이지 이동
	@RequestMapping(value = "/findId", method = RequestMethod.GET)
	public String findIdView() {
		return "main/findId";
	}


    //아이디 찾기 실행 log.info(principal.getName());
	@RequestMapping(value="/findId", method=RequestMethod.POST)
	public String findIdAction(Principal principal, UserVO vo, Model model) {

		UserVO user1 = service.findId(vo);


		if(user1 == null) { 
			model.addAttribute("check", 1);
		} else { 
			model.addAttribute("check", 0);
			model.addAttribute("id", user1.getUserid());
		}

		return "main/findId";
	}

	//비밀번호 찾기 페이지 이동
	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public String findPwView() throws Exception {
		return "main/findPw";
	}

	@RequestMapping(value = "/findPw", method = RequestMethod.POST)
	public String findPasswordAction(Principal principal, UserVO vo, Model model) throws Exception {

		UserVO user2 = service.findPw(vo);

		log.info(vo);
		log.info(user2);

		// 가입된 아이디가 없으면
		if(user2 == null) {
			model.addAttribute("check", 1);
		}


		// 가입된 이메일이 아니면 
		else if(!vo.getUserEmail().equals(user2.getUserEmail())) {
		  model.addAttribute("check", 2); }

		// 임시 비밀번호 생성
		else {

			model.addAttribute("check", 0);
			String pw = "";
			for (int i = 0; i < 8; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			vo.setUserpw(pw);


		// 비밀번호 변경
			service.updatePw(vo);

			vo.setUserpw(pw);
		// 비밀번호 변경 메일 발송
			service.sendEmail(vo, "findpassword");	
		}
		return "main/findPw";	
	}

	
}
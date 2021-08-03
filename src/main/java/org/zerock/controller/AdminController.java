package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.UserVO;
import org.zerock.service.AdminService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
	
	@Setter(onMethod_ = @Autowired)
	private AdminService service;
	
	//관리자페이지 홈 
	@GetMapping("/home")
	public String home(Model model, UserVO vo, RedirectAttributes rttr) {
		
		// 기본회원 조회
		log.info("기본회원 조회");
		
		List<UserVO> Userlist = service.getUserlist();
		model.addAttribute("Userlist", Userlist);

		return "/admin/home";
			
	}
	
	//일반회원 회원가입
	@PostMapping("/home")
	public String signupPost(UserVO vo, RedirectAttributes rttr) {
		log.info("회원가입완료");

		boolean ok = service.getUserinsert(vo);

		if (ok) {
			return "redirect:/admin/home";
		} else {
			return "redirect:/admin/home?error";
		}
	}
	
	//기본회원 수정하기
	@PostMapping("/update")
	public String update(UserVO vo) {
		
		service.Userupdate(vo);
		
		return "redirect:/admin/home";
	}
	
	//기본회원 회원탈퇴
	@PostMapping("/delete")
	public String delete(UserVO vo) {
		
		service.Userdelete(vo);
		
		return "redirect:/admin/home";
	}
	 
	@GetMapping("/complist")
	public String complist(Model model, UserVO vo, RedirectAttributes rttr) {
		
		// 업체회원 조회
		log.info("업체 리스트");
		
		List<UserVO> Complist = service.getComplist();
		model.addAttribute("Complist", Complist);
		
		return "/admin/complist";
		
	}
	
	//업체회원 회원가입
	@PostMapping("/complist")
	public String complistpost(UserVO vo, RedirectAttributes rttr) {
		log.info("회원가입완료");

		boolean ok = service.getCompinsert(vo);

		if (ok) {
			return "redirect:/admin/complist";
		} else {
			return "redirect:/admin/complist?error";
		}
	}
	
	//업체회원 수정하기
	@PostMapping("/compupdate")
	public String compupdate(UserVO vo) {
			
		service.Compupdate(vo);
			
		return "redirect:/admin/complist";
	}
	
	//기본회원 회원탈퇴
	@PostMapping("/compdelete")
	public String compdelete(UserVO vo) {
		
		service.Compdelete(vo);
		
		return "redirect:/admin/complist";
	}
	
}

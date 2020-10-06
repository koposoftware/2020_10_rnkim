package kr.ac.kopo.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.ac.kopo.member.service.MemberService;
import kr.ac.kopo.member.vo.MemberVO;

//@Controller
public class MemberController2 {

	@Autowired 
	private MemberService memberService;
	
//	@RequestMapping(value="/login", method = RequestMethod.GET)
	@GetMapping("/login")
	public String loginForm() {
		
		return "login/login";
	}
	
//	@RequestMapping(value="/login", method = RequestMethod.POST)
	@PostMapping("/login")
	public String login(MemberVO member, HttpSession session) {
		MemberVO userVO = memberService.login(member);
		
		// 로그인 실패 
		if(userVO == null) {
			return "redirect:/login";
		} 
		
		// 로그인 성공 
		session.setAttribute("userVO", userVO);
		
		
		return "redirect:/";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("userVO");
		return "redirect:/";
	}
}

package kr.ac.kopo.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import kr.ac.kopo.member.service.MemberService;
import kr.ac.kopo.member.vo.MemberVO;

@SessionAttributes("userVO")
@Controller
public class MemberController {

	@Autowired 
	private MemberService memberService;
	
//	@RequestMapping(value="/login", method = RequestMethod.GET)
	@GetMapping("/login")
	public String loginForm() {
		
		return "login/login";
	}
	
//	@RequestMapping(value="/login", method = RequestMethod.POST)
	@PostMapping("/login")
	public ModelAndView login(MemberVO member, HttpSession session) {
		MemberVO userVO = memberService.login(member);
		ModelAndView mav = new ModelAndView();
		
		// 로그인 실패 O
		if(userVO == null) {
			mav.setViewName("redirect:/login");
		} 
		else {
			// 로그인 성공 
			if(session.getAttribute("dest") != null) {
				mav.setViewName("redirect:/" + session.getAttribute("dest"));				
				session.removeAttribute("dest");
			} else {
				mav.setViewName("redirect:/");		
			}
			mav.addObject("userVO", userVO);			
		}
		
		return mav;
	}
	
	@RequestMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
}

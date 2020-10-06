package kr.co.mlec.form;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/form")
@Controller
public class MemberController {

//	위에 클래스에서 /form 으로 시작하는것으로 두고, 메소드에서 form 밑에 joinForm.do, join.do 로 지정 
	@RequestMapping("/joinForm.do")
	public String joinForm() {
		return "form/joinForm";
	}
	
	// request 객체가 필요하므로 디스패처 서블릿에서 MemberController의 join()을 호출할때 request 객체를 달라고 요구 
	@RequestMapping("/join.do")
	public String join(@ModelAttribute("member") MemberVO member) {
		
		return "form/memberInfo";
	}
	
}

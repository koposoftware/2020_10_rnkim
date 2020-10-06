package aop.java;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Service;

@Service
@Aspect
public class Action {

	@Before("execution(* work())")
	public void gotoOffice() {
		System.out.println("출근합니다....");
	}
	
	@After("execution(* aop.java.*.work())")
	public void getoffOffice() {
		System.out.println("퇴근합니다....");
	}
}

package aop.java;

import org.springframework.stereotype.Component;

@Component
public class Manager implements Employee {

	@Override
	public void work() {
		System.out.println("사원관리와 운영을 합니다...");
	}

	
}

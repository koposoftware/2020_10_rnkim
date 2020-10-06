package aop.java;

import org.springframework.stereotype.Component;

import aop.xml.Employee;

@Component
public class Designer implements Employee {

	@Override
	public void work() {
		System.out.println("디자인을 합니다.");
	}

}

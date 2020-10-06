package di.test03;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class UserMain {

	public static void main(String[] args) {
		
		// 스프링 방식 
		ApplicationContext context = new GenericXmlApplicationContext("ditest03/beanContainer.xml");
		
		MyCalculator my = (MyCalculator)context.getBean("myCalculator");

		my.add();
		my.sub();
		my.mul();
		my.div();
		
		
		
		// 기존의 자바방식
		/*
		Calculator c = new Calculator();
		MyCalculator my = new MyCalculator(c);
		
		my.setFirstNum(15);
		my.setSecondNum(4);
		
		my.add();
		my.sub();
		my.mul();
		my.div();
		*/
	}
}

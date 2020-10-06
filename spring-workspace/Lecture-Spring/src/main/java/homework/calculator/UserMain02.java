package homework.calculator;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class UserMain02 {

	public static void main(String[] args) {
		
		ApplicationContext context = new GenericXmlApplicationContext("ditest01/beanContainer2.xml");
		
		MyCalculator my = (MyCalculator)context.getBean("myCal");
		
		my.add();
		my.sub();
		my.mul();
		my.div();
		
	}
}

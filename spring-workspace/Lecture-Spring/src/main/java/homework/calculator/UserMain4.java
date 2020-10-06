package homework.calculator;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class UserMain4 {

	public static void main(String[] args) {
		
		ApplicationContext context = new GenericXmlApplicationContext("ditest01/beanContainer4.xml");
		
		MyCalculator my = (MyCalculator)context.getBean("myCal");
		
		my.add();
		my.sub();
		my.mul();
		my.div();
		
	}
}

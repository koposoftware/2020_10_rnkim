package aop.anno;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

/*
 * Spring AOP 특징
 * 1. runtime 기반
 * 2. proxy 기반
 * 3. 인터페이스 기반 
 */
public class EmpMain {

	public static void main(String[] args) {
		
		ApplicationContext context = new GenericXmlApplicationContext("aop-anno.xml");
	
		Employee e = context.getBean("programmer", Employee.class);
		e.work();
	}
}

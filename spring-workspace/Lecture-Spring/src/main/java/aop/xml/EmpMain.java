package aop.xml;

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
		
		ApplicationContext context = new GenericXmlApplicationContext("aop-xml.xml");
		// 프록시는 개별 클래스가 아니라 인터페이스의 형으로 받아줘야한다. 인터페이스 기반의 메소드 호출만 채갈 수 있기때문. 코드 주입을 프록시가 하게된다. 
		Employee  e = context.getBean("programmer", Employee.class);
		e.work();
		
		e = context.getBean("designer", Employee.class);
		e.work();
		
		e = context.getBean("manager", Employee.class);
		e.work();
		
	}
}

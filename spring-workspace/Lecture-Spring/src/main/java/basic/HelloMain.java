package basic;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class HelloMain {
	
	public static void main(String[] args) {
		
		// classPath에서부터 읽어옴. src/main/resources 부터. 
		//ApplicationContext context = new ClassPathXmlApplicationContext("beanContainer.xml");
		
		// FileSystemXmlApplicationContext : 파일의 절대경로에서 xml을 가져옴 
		//ApplicationContext context = new FileSystemXmlApplicationContext("src/main/resources/beanContainer.xml");
		
		ApplicationContext context = new GenericXmlApplicationContext("classpath:beanContainer.xml");
		
		HelloSingle obj3 = context.getBean("hs", HelloSingle.class);
		HelloSingle obj4 = (HelloSingle)context.getBean("hs2");
		obj3.prnMsg();
		System.out.println(obj3);
		System.out.println(obj4);
		
		// id가 hello인 객체를 가져옴 
		Hello obj = (Hello)context.getBean("hello");
		obj.prnMsg();
		
		Hello obj2 = (Hello)context.getBean("hello2");
		obj2.prnMsg();
		
		System.out.println(obj);
		System.out.println(obj2);
	}
}

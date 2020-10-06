package homework.shape;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class Client {

	public static void main(String[] args) {
		
		// annotaion으로 짜기 1 
		ApplicationContext container = new GenericXmlApplicationContext("homework/shape.xml");
		
		MyShape ms = container.getBean("myShape", MyShape.class);
		
		ms.getArea();
		
		// xml로 짜기
//		ApplicationContext container = new GenericXmlApplicationContext("homework/shape.xml");
//		
//		MyShape ms = container.getBean("myShape", MyShape.class);
//		
//		ms.getArea();
		
		
		// 자바로 짜기 
//		MyShape ms = new MyShape();
//		Circle c = new Circle();
//		
//		ms.setShape(c);
//		ms.setRadius(10);
//		ms.getArea();
	}
}

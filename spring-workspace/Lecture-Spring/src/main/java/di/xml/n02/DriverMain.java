package di.xml.n02;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
/*
 * XML을 이용한 Spring 생성자 주입방식 
 */
public class DriverMain {

	public static void main(String[] args) {
		
		ApplicationContext context = new GenericXmlApplicationContext("di-xml02.xml");
		
		//Car car = (Car)context.getBean("car");
		//car.prnTireBrand();
		
		/* 이렇게 했던 생성자 주입 방식을 xml을 이용해 Spring으로 하고싶다 
		Tire tire = new HankookTire();
		Car car = new Car(tire);
		car.prnTireBrand();
		*/
	}
}

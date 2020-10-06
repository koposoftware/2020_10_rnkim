package di.collection;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

public class ListMain {

	public static void main(String[] args) {
		
		// spring
		ApplicationContext container = new GenericXmlApplicationContext("di-collection01.xml");
		
//		ListAddress list = container.getBean("list", ListAddress.class);
		ListAddress list = container.getBean("list02", ListAddress.class);
		
		for(String addr : list.getAddress()) {
			System.out.println(addr);
		}
		
		// 자바 
//		List<String> address = new ArrayList<String>();
//		address.add("서울");
//		address.add("부산");
//		address.add("광주");
//		
//		// 생성자주입 
//		ListAddress list = new ListAddress(address);
//		// 세터주입 
//		list.setAddress(address);
		
	}
}

package di.java;

import org.springframework.stereotype.Component;

@Component
public class KumhoTire implements Tire {

	public String getBrand() {
		return "금호타이어";
	}
}

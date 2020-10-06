package di.java;

import org.springframework.stereotype.Component;

@Component("hankook")
public class HankookTire implements Tire {

	public HankookTire() {
		System.out.println("HankookTire() 호출...");
	}
	public String getBrand() {

		return "한국타이어";
	}
}

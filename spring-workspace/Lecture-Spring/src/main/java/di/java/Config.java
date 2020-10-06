package di.java;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@ComponentScan(basePackages = {"di.java"})
@Configuration
public class Config {

	/*
//	@Bean(name="car")
	@Bean
	public Car car() {
		return new Car();
	}
	@Bean
	public Tire hankookTire() {
		return new HankookTire();// 메소드 이름은 중요치 않고, 얘를 컨테이너에 올린다.
	}

	@Bean(name="kumho")
	public Tire kumhoTire() {
		return new KumhoTire();
	}
	
	*/
}

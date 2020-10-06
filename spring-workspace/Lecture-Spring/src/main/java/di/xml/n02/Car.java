package di.xml.n02;

public class Car {

	private Tire tire;		// 의존관계 발생 
	
	public Car() {
		System.out.println("Car() 생성자 호출...");
	}

	public Car(Tire tire) {
		System.out.println("Car(Tire) 생성자 호출...");
		this.tire = tire;
	}
	
	public Car(Tire tire01, Tire tire02) {
		System.out.println("Car(Tire, Tire) 생성자 호출...");
		System.out.println(tire01.getBrand() + " : " + tire02.getBrand());
	}
	
	public Car(Tire tire, String msg) {
		System.out.println("Car(Tire, String) 생성자 호출...");
		System.out.println("msg : " + msg);
	}
	public void prnTireBrand() {
		System.out.println("장착된 타이어 : " + tire.getBrand());
	}
}

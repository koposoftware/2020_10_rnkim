package di.xml.n01;

public class Car {

	private Tire tire;		// 의존관계 발생 
	
	// 속성 주입 / setter 주입 (Setter Injection)
	public void setTire(Tire tire) {
		this.tire = tire;
	}
	
	public void prnTireBrand() {
		System.out.println("장착된 타이어 : " + tire.getBrand());
	}
}

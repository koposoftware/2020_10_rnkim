package homework.shape;

public class Circle extends Shape {
	
	@Override
	public void calculate() {
		System.out.println("원의 넓이 : " + getRadius() * getRadius() * Math.PI );
	}

	
}

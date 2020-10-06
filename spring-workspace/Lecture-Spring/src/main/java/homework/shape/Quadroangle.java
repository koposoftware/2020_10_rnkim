package homework.shape;

public class Quadroangle extends Shape {

	@Override
	public void calculate() {

		System.out.println("사각형의 넓이 : " + getWidth() * getHeight());
	}

	
}

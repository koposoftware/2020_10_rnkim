package homework.shape;

public class Triangle extends Shape {

	@Override
	public void calculate() {
		System.out.println("삼각형의 넓이 : " + getWidth() * getHeight() * 0.5);
	}

	
}

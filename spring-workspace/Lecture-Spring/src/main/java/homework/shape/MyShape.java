package homework.shape;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

public class MyShape {

	private Shape shape;


	public Shape getShape() {
		return shape;
	}

	@Autowired
	@Qualifier("triangle")
	public void setShape(Shape shape) {
		this.shape = shape;
	}
	
	public void getArea() {
		shape.calculate();
	}
	
	@Autowired
	public void setWidth(@Value("10") int width) {
		shape.setWidth(width);
	}
	@Autowired
	public void setHeight(@Value("10") int height) {
		shape.setHeight(height);
	}
	
	@Autowired
	public void setRadius(@Value("10") int radius) {
		shape.setRadius(radius);
	}
}

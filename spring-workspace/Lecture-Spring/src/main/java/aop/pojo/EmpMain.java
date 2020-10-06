package aop.pojo;

public class EmpMain {

	public static void main(String[] args) {
		Employee e = new Programmer();
		e.work();
		
		Employee e2 = new Designer();
		e.work();
	}
}

package aop.pojo;

public class Programmer implements Employee {

	@Override
	public void work() {
		Action.gotoOffice();
		System.out.println("개발을 합니다.");
		Action.getoffOffice();
	}

}

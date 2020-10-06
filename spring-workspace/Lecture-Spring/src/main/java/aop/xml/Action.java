package aop.xml;

// 공통코드는 기능클래스이기때문에 객체가 여러개일 필요 없기 때문에 static 메소드로. 
public class Action {

	public void gotoOffice() {
		System.out.println("출근합니다....");
	}
	
	public void getoffOffice() {
		System.out.println("퇴근합니다....");
	}
}

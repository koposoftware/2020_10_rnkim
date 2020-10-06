package basic;

public class HelloSingle {

	private static HelloSingle instance = null;
	private String msg = "안녕 난 싱글턴이야...";
	
	// 외부에서 new 할 수 없으므로 하나만 만들어 싱글턴 패턴으로 계속 쓰려함 
	private HelloSingle() {
		System.out.println("HelloSingle 객체 로딩...");
	}
	
	public static HelloSingle getInstance() {
		if(instance == null) 
			instance = new HelloSingle();
		return instance;
	}
	
	public void prnMsg() {
		System.out.println("msg : " + msg);
	}
}

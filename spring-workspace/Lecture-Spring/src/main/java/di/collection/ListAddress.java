package di.collection;

import java.util.List;

public class ListAddress {

	private List<String> address;

	public ListAddress() {};
	
	public ListAddress(List<String> address) {
		super();
		this.address = address;
	}

	public List<String> getAddress() {
		return address;
	}

	public void setAddress(List<String> address) {
		this.address = address;
	}
	
	
}

package wing;

class SimpleException extends Exception {
}

public class InheritingExceptions {
	public void f()// throws SimpleException 
	{
		System.err.println("f()");
		int i=0;
		int t=1/i;
	//	throw new SimpleException();
	}
	public void g() throws SimpleException {
		System.err.println("g()");
//		throw new SimpleException();
	}
	
	public static void main(String[] args) {
		InheritingExceptions sed = new InheritingExceptions();
		try {
			sed.f();
			sed.g();
		} catch (SimpleException e) {
			e.printStackTrace();
		}
		System.out.println("end");
	}

}

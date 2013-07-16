package lab02;

public class CalcBean {
	String arg1,arg2,method;
	public String getArg1() {
		return arg1;
	}

	public void setArg1(String arg1) {
		this.arg1 = arg1;
	}

	public String getArg2() {
		return arg2;
	}

	public void setArg2(String arg2) {
		this.arg2 = arg2;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public CalcBean() {
	}

	public String calc() {
		double a=Double.parseDouble(arg1),b=Double.parseDouble(arg2);
		if(method.equals("+"))return String.valueOf(a+b);
		else if(method.equals("-"))return String.valueOf(a-b);
		else if(method.equals("*"))return String.valueOf(a*b);
		else return String.valueOf(a/b);
	}
}

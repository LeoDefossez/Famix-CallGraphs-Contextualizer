package example3;

import example3ExternalDepencies.B3;

public class A3 {
    
    public static void main(String[] args) {
        B3 b = new B3();
        
        b.method(new A3());
    }
    
    public String toString() {
    	try{
            Runtime.getRuntime().exec("");

        } catch(Exception e){}
    	return super.toString();
    }
    

} 

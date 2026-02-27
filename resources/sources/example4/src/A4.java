package example4;

import example4External.B4;

public class A4{
    
    public static void main(String[] args) {
        B4 b = new B4(new A4());
        
        b.toString();
    }
    
    public String toString() {
    	try{
            Runtime.getRuntime().exec("");

        } catch(Exception e){}
    	return super.toString();
    }
    

} 

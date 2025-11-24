public class Main{
    public static void main(String[] args) {
        Drink d1 = new Tea("jasmine",76.5,true);
        Drink d2 = new Coffee("Latte",76.5,true);
        
        Cup c1 = new Cup("Red",false,d1);
        Cup c2 = new Cup("Green",true,d2);

        c1.destroyHandle();
        c2.destroyHandle();
        c2.destroyHandle();

        c1.sip();
        c2.sip();
        c1.sip();
        
        System.out.println(Cup.cupCount);
    }    
}
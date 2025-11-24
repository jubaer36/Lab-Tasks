public class SmartWatch extends Device {

    SmartWatch(String name , Double price , boolean powerStatus){
        
        super(name, price, powerStatus);
        
    }
    
    void check_Vitals(){
        System.out.println("Checking vitals");
    }
    @Override
    void power_On(){
        if(!powerOn){
            System.out.println("SmartWatch Turning on");
        powerOn = true;
        }
        else{
            System.out.println("SmartWatch already on");
        }
        

    }
    @Override
    void power_Off(){
        if(powerOn){
            System.out.println("SmartWatch Turning off");
        powerOn = false;
        }
        else{
            System.out.println("SmartWatch already off");
        }
    }
}

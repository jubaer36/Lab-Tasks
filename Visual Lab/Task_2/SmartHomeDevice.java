public class SmartHomeDevice extends Device {

    SmartHomeDevice(String name , Double price , boolean powerStatus){
        
        super(name, price, powerStatus);
        
    }
    void check_Vitals(){
        System.out.println("Checking vitals");
    }
    @Override
    void power_On(){
        if(!powerOn){
            System.out.println("SmartHomeDevice Turning on");
        powerOn = true;
        }
        else{
            System.out.println("SmartHomeDevice already on");
        }
        

    }
    @Override
    void power_Off(){
        if(powerOn){
            System.out.println("SmartHomeDevice Turning off");
        powerOn = false;
        }
        else{
            System.out.println("SmartHomeDevice already off");
        }
    }
    void listDevices(){
        System.out.println("Listing all devices");
    }
}

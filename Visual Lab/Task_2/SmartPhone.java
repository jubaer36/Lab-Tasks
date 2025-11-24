public class SmartPhone extends Device {
    String phoneNumber;
    SmartPhone(String name , Double price , boolean powerStatus , String phoneNumber){
        super(name, price, powerStatus);
        this.phoneNumber = phoneNumber;
    }
    void call(String otherPhoneNumber){
        System.out.println("Calling phone number: "+phoneNumber);

    }
    @Override
    void power_On(){
        if(!powerOn){
            System.out.println("SmartPhone Turning on");
        powerOn = true;
        }
        else{
            System.out.println("Smartphone already on");
        }
        

    }
    @Override
    void power_Off(){
        if(powerOn){
            System.out.println("Smartphone Turning off");
        powerOn = false;
        }
        else{
            System.out.println("Smartphone already off");
        }
    }
}

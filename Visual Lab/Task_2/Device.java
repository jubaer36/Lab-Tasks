public class Device {
    String name;
    Double price;
    String modelNumber;
    static int count = 0;
    boolean powerOn;

    Device(String name, Double price, boolean powerStatus){
        this.name = name;
        this.price = price;
        this.powerOn = powerStatus;
        count++;
        this.modelNumber = name + "-" + count ;
    }
    void print_Details(){
        System.out.println("Name : "+name);
        System.out.println("ModelNumber : "+modelNumber);
        System.out.println("Price : "+price);
        // System.out.println("Power Status: "+((int)powerStatus));

    }
    void power_On(){
        if(!powerOn){
            System.out.println("Turning on");
        powerOn = true;
        }
        else{
            System.out.println("Power already on");
        }
        

    }
    void power_Off(){
        if(powerOn){
            System.out.println("Turning off");
        powerOn = false;
        }
        else{
            System.out.println("Power already off");
        }
    }

}

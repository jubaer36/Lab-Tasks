/**
 * Main
 */
public class Lab02_2B_210041226 {

    public static void main(String[] args) {
        Device d1 = new SmartPhone("Nokia", 2000.0, true, "01298765");
        d1.print_Details();
        d1.power_Off();
        d1.power_Off();
        d1.power_On();
        ((SmartPhone)d1).call("0211010");

        Device d2 = new SmartWatch("Apple Watch", 599.0, false);
        d2.print_Details();
        d2.power_On();
        d2.power_On();
        ((SmartWatch)d2).check_Vitals();

        Device d3 = new SmartHomeDevice("Google Home", 1599.0, false);
        d3.print_Details();
        d3.power_On();
        ((SmartHomeDevice)(d3)).listDevices();


        
    }
}
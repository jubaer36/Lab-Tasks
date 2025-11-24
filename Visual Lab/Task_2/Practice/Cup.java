public class Cup {
    String color;
    double volume;
    String material;
    boolean hasHandle;
    Drink beverage;
    static int cupCount = 0;

    Cup(String color, boolean hasHandle ,Drink beverage){
        this.color = color;
        this.hasHandle = hasHandle;
        this.beverage = beverage;
        cupCount++;
    }

    void destroyHandle(){
        if(hasHandle){
            System.out.println("Handle Gone!");
            hasHandle = false;
        }
        else{
            System.out.println("Handle is already destroyed");
        }
    }
    void sip(){
        System.out.println(beverage.getName());
    }
}

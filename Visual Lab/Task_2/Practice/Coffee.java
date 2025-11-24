public class Coffee extends Drink {
    boolean hasSugar;

    Coffee(String name,double temp,boolean hasSugar ){
        super(name, temp);
        this.hasSugar = hasSugar;
    }
    @Override
    String getName(){
        return "I am drinking a Coffee";
    }
}

public class Tea extends Drink {
    boolean hasSugar;
    Tea(String name,double temp,boolean hasSugar){
        super(name,temp);
        this.hasSugar = hasSugar;
    }
    @Override
    String getName(){
        return "I am drinking a Tea";
    }
}

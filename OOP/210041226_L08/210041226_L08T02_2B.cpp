
#include <iostream>
#include <string>
using namespace std;
class Animal{
private:
    string habitat_area;
    string sound;
    bool can_fly;
    bool can_swim;
public:
    Animal(string habitat , string _sound , bool canFly , bool canSwim):habitat_area(habitat), sound(_sound), can_fly(canFly),can_swim(canSwim){
    }
    Animal(){}
    bool if_can_swim(){
        return can_swim;
    }
    void set_can_swim(bool a){
        can_swim = a;
    }
    void set_can_fly(bool a){
        can_fly = a;
    }
    bool if_can_fly(){
        return can_fly;
    }
    string get_habitat_area(){
        return habitat_area;
    }
    void set_habitat_area(string habitat){
        habitat_area = habitat;
    }
    string get_sound(){
        return sound;
    }
    void set_sound(string sound){
        this->sound = sound;
    }
    void vocalize(){
        cout << "sound";
    }
    void print(){
        cout << "Habitat : " << habitat_area  << endl;
        cout << "Sound : " << sound  << endl;
        if(can_fly) cout << "Can Fly "  << endl;
        else cout << "Can not Fly" << endl;
        if(can_swim) cout << "Can Swim "  << endl;
        else cout << "Can not Swim" << endl;
    }
    ~Animal(){
    }

};

class Cow : private Animal{
public:
    Cow(){}
    Cow(string habitat , string _sound , bool canFly , bool canSwim):Animal(habitat , _sound , canFly , canSwim){}

    void vocalize(){
        Animal::vocalize();
        cout << " : moo" << endl;
    }
    void print(){
        Animal::print();
    }

};

class Chicken : public Animal{
public:
    Chicken(){}
    Chicken(string habitat , string _sound , bool canFly , bool canSwim):Animal(habitat , _sound , canFly , canSwim){}
    void vocalize(){
        Animal::vocalize();
        cout << " : buck buck" << endl;
    }
    void print(){
        Animal::print();
    }
};
class   Cat: public Animal{
public:
    Cat(){}
    Cat(string habitat , string _sound , bool canFly , bool canSwim):Animal(habitat , _sound , canFly , canSwim){}
    void vocalize(){
        Animal::vocalize();
        cout << " : meow" << endl;
    }
    void print(){
        Animal::print();
    }
};
int main(){
    cout << "Cow" << endl;
    Cow c("Land","Moo" , false , false);
    c.print();
    c.vocalize();
    cout << endl;
    cout << "Chicken" << endl;
    Chicken chick("Land","Buck Buck" , true , false);
    chick.print();
    chick.vocalize();
    cout << endl;
    cout << "Cat" << endl;

    Cat cat("Land","Meow" , false , true);
    cat.print();
    cat.vocalize();
    cout << endl;

}

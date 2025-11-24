#include <iostream>
#include <string>

using namespace std;

class Weight{
private:
    int pound;
    double ounce;
    double kilogram;
public:
    static double kgToPound;
    static double kgToOunce;
    Weight(){}
    void set_weight( int pound , int ounce){
        this->pound = pound;
        this->ounce = ounce;
    }
    Weight(double kg){
        this->kilogram = kg;
        this->ounce = kg*kgToOunce;
        this->pound = kg*kgToPound;
        this->ounce = this->ounce - this->pound*16;
    }
    Weight(int pound , double ounce){
        this->pound = pound;
        this->ounce = ounce;
    }
    void show_weight(){
        cout <<" Pound: "<<this->pound <<"     Ounce: " <<this->ounce <<"   Kilogram: " << this->kilogram<<endl;
    }
    double operator ()(){
        this->kilogram = this->pound * 0.453592 + this->ounce * .028;
        return this->kilogram;
    }

};
double Weight::kgToPound = 2.20462;
double Weight::kgToOunce = 35.274;

int main(){
    Weight w1;
    w1.set_weight(43,64);
    Weight w2(354 ,32);
    Weight w3(5666 , 43);
    w3();
    w1.show_weight();
    w2.show_weight();
    w3.show_weight();

}

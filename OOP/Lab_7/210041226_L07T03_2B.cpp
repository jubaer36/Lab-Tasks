
#include <iostream>
#include <string>
using namespace std;


class CurrencyBDT
{
private:
    int taka;
    int paisa;
public:
    CurrencyBDT(){}
    CurrencyBDT(int taka , int paisa){
        this->taka = taka;
        this->paisa = paisa;
    }
    void set_value(int taka , int paisa){
        this->taka = taka;
        this->paisa = paisa;
    }
    show_val(){
        cout << "BDT: ";
        cout << this->taka << ' ' << this->paisa << endl;
    }
    float convert_to_USD();
    float convert_to_Euro();

};

class CurrencyDollar
{
private:
    int dollar;
    int cents;
public:
    void set_value(){
        this->dollar = dollar;
        this->cents = cents;
    }
    CurrencyDollar(){}
    CurrencyDollar(int dollar, int cents)
    {
        this->dollar = dollar;
        this->cents = cents;
    }
    show_val(){
        cout << "USD: ";
        cout << this->dollar << ' ' << this->cents << endl;
    }

};
class CurrencyEuro
{
private:
    int euros;
    int cents;
public:
    CurrencyEuro(){}
    CurrencyEuro(int euros, int cents)
    {
        this->euros = euros;
        this->cents = cents;
    }
    void set_value(){
        this->euros = euros;
        this->cents = cents;
    }
    show_val(){
        cout << "Euro: ";
        cout << this->euros << ' ' << this->cents<< endl;
    }

};

float CurrencyBDT::convert_to_Euro(){
    float x , y;
    x = this->taka*0.0085;
    y = (this->paisa/100)*0.0085;
    cout <<"Euro: "<<x+y << endl;
    return x+y;


}
float CurrencyBDT::convert_to_USD(){
    float x , y;
    x = (float)this->taka*0.0091;
    y = ((float)this->paisa/100)*0.0091;
    cout <<"USD: "<<x+y << endl;
    return x+y;
}

int main()
{
    CurrencyBDT t1(4,3);
    t1.show_val();
    t1.convert_to_Euro();
    t1.convert_to_USD();



}

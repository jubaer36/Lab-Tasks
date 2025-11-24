
#include<iostream>
#include<string>
using namespace std;

class Medicine{
private:
    string name , generic_name;
    float unit_price , discountPercent , selling_price , initial_price;
public:
    static int total_quantity;
    static int total_price;
    Medicine(){
        total_quantity++;
    }
    Medicine(string name , string generic_name , float unit_price){
        this->name = name;
        this->generic_name = generic_name;
        this->unit_price = unit_price;
        this->initial_price = unit_price;
        total_quantity++;
        total_price+=unit_price;
    }
    double updatedPrice(int percent){
        this->unit_price -= unit_price*(percent)/100;
        return unit_price;
    }
    double getSellingPrice(int nos){
        selling_price = nos*unit_price;
        total_quantity -= nos;
        return selling_price;

    }
    double readAdjustedPrice(){
        return (total_price - selling_price)/total_quantity;
    }
    void resetPrice(){
        this->unit_price = initial_price;

    }
    ~Medicine(){
        cout << "Medicine name: " << this->name << endl;
        cout << "Medicine generic name: " << this->generic_name << endl;
        cout << "Medicine selling price: " << this->unit_price << endl;
        cout << "Medicine initial price: " << this->initial_price << endl;
        cout << "Total Medicines: " << total_quantity << endl;
        cout << "Total Medicines price: " << total_price << endl;
        cout << endl;
    }
};

int Medicine::total_price = 0;
int Medicine::total_quantity = 0;

int main(){
    Medicine m1("Flexo " , "Fenadin", 10);
    m1.updatedPrice(21);
    cout <<"Adjusted Price: " << m1.readAdjustedPrice() << endl;
    Medicine m2("Losectil " , "Fein", 20);
    m2.updatedPrice(41);
    m2.resetPrice();
    Medicine m3("Bari" , "Fenad", 50);
    cout <<"Adjusted Price: " << m3.readAdjustedPrice() << endl;

}

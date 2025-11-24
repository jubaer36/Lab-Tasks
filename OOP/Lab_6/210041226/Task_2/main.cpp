#include <iostream>
#include <string>
#include <Medicine.h>
using namespace std;


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

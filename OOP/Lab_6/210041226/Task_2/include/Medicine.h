#ifndef MEDICINE_H
#define MEDICINE_H
#include <iostream>
#include <string>
using namespace std;

class Medicine
{
    public:
        Medicine();
        ~Medicine();
        Medicine(string name , string generic_name , float unit_price);
        double updatedPrice(int percent);
        double getSellingPrice(int nos);
        double readAdjustedPrice();
        void resetPrice();

        static int total_quantity;
        static int total_price;


    private:
        string name;
        string generic_name;
        float unit_price;
        float discountPercent;
        float selling_price;
        float initial_price;
};

#endif // MEDICINE_H

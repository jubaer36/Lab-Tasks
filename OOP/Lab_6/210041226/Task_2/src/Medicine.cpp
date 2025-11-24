#include "Medicine.h"
#include <iostream>
#include <string>
using namespace std;
Medicine::Medicine()
{
    total_quantity++;
}
Medicine::    Medicine(string name, string generic_name, float unit_price)
{
    this->name = name;
    this->generic_name = generic_name;
    this->unit_price = unit_price;
    this->initial_price = unit_price;
    total_quantity++;
    total_price+=unit_price;
}
double Medicine:: updatedPrice(int percent)
{
    this->unit_price -= unit_price*(percent)/100;
    return unit_price;
}
double Medicine::getSellingPrice(int nos)
{
    selling_price = nos*unit_price;
    total_quantity -= nos;
    return selling_price;

}
double Medicine::readAdjustedPrice()
{
    return (total_price - selling_price)/total_quantity;
}
void Medicine::resetPrice()
{
    this->unit_price = initial_price;

}
Medicine::~Medicine()
{
    cout << "Medicine name: " << this->name << endl;
    cout << "Medicine generic name: " << this->generic_name << endl;
    cout << "Medicine selling price: " << this->unit_price << endl;
    cout << "Medicine initial price: " << this->initial_price << endl;
    cout << "Total Medicines: " << total_quantity << endl;
    cout << "Total Medicines price: " << total_price << endl;
    cout << endl;
}

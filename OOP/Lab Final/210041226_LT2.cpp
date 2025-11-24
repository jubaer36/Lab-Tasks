#include <iostream>
#include <algorithm>
using namespace std;
class Furniture
{
private:
    string model_no;
    string material;
    int unit_price;
    int quantity;
    string type;

public:
    static int total_furniture;
    Furniture()
    {
        total_furniture++;
    };
    class QuantityException
    {
    };
    class PriceException
    {
    };
    class ExceededQuantityException
    {
    };
    Furniture(string ModelNo, string Material, int UnitPrice, int Quantity, string type = "Fur")
    {
        model_no = ModelNo;
        material = Material;
        if (Quantity > 50)
        {
            throw ExceededQuantityException();
        }
        if (Quantity < 0)
        {
            throw QuantityException();
        }

        quantity = Quantity;

        if (UnitPrice < 0)
        {
            throw PriceException();
        }

        unit_price = UnitPrice;

        type = "";
        total_furniture++;
    }
    string getType()
    {
        return type;
    }

    ~Furniture()
    {
        total_furniture--;
    };
};

class Table : public Furniture
{
private:
    string purpose_for_use;

public:
    Table() {}
    Table(string ModelNo, string Material, int UnitPrice, int Quantity, string Purpose, string Type = "Table") : Furniture(ModelNo, Material, UnitPrice, Quantity, Type), purpose_for_use(Purpose) {}
    ~Table() {}
};

class Chair : public Furniture
{
private:
    int number_of_legs;

public:
    Chair() {}
    Chair(string ModelNo, string Material, int UnitPrice, int Quantity, int NumberOfLegs, string Type = "Chair") : Furniture(ModelNo, Material, UnitPrice, Quantity, Type), number_of_legs(NumberOfLegs) {}
    ~Chair() {}
};
class Bed : public Furniture
{
public:
    Bed() {}
    Bed(string ModelNo, string Material, int UnitPrice, int Quantity, string Type = "Bed") : Furniture(ModelNo, Material, UnitPrice, Quantity, Type) {}
    ~Bed() {}
};
class DiningTable : public Table
{
private:
    int seating_capacity;

public:
    DiningTable() {}
    DiningTable(string ModelNo, string Material, int UnitPrice, int Quantity, string Purpose) : Table(ModelNo, Material, UnitPrice, Quantity, Purpose) {}
    ~DiningTable() {}
};

int Furniture::total_furniture = 0;
int main()
{

    try
    {
        Chair c1("32" ,"Wood" , 32,-5,4);

        Furniture f1("43", "Wood", 5, -2);
        Furniture f3("43" , "Wood", 5 , 2 );
    }
    catch (Furniture::ExceededQuantityException)
    {
        cerr << "Exceeded Quantity" << endl;
    }
    catch (Furniture::PriceException)
    {
        cerr << "Invalid Price" << endl;
    }
    catch (Furniture::QuantityException)
    {
        cerr << "Invalid Quantity" << endl;
    }
}
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
    int type;

public:
    static int total_furniture;
    static int total(){return total_furniture;}
    Furniture(int Type)
    {
        type = Type;
        total_furniture++;
        // cout << "Furniture Constructed" << total_furniture<< endl;
    };
    Furniture(string ModelNo, string Material, int UnitPrice, int Quantity , int Type)
    {
        model_no = ModelNo;
        material = Material;
        unit_price = UnitPrice;
        quantity = Quantity;
        type = Type;
        total_furniture++;
        
    }
    int getType(){
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
    Table(int Type = 1) : Furniture(Type){}

    Table(string ModelNo, string Material, int UnitPrice, int Quantity, string Purpose , int Type = 1) : Furniture(ModelNo, Material, UnitPrice, Quantity , Type), purpose_for_use(Purpose) {}
    ~Table() {}
};

class Chair : public Furniture
{
private:
    int number_of_legs;

public:
    Chair(int Type = 3) : Furniture(Type){}
    Chair(string ModelNo, string Material, int UnitPrice, int Quantity, int NumberOfLegs , int Type = 3) : Furniture(ModelNo, Material, UnitPrice, Quantity , Type), number_of_legs(NumberOfLegs) {}
    ~Chair() {}
};
class Bed : public Furniture
{
public:
    Bed(int Type = 2) : Furniture(Type){}
    Bed(string ModelNo, string Material, int UnitPrice, int Quantity , int Type = 2) : Furniture(ModelNo, Material, UnitPrice, Quantity , Type) {}
    ~Bed() {}
};
class DiningTable : public Table
{
private:
    int seating_capacity;

public:
    DiningTable(int Type = 1) : Table(Type){}
    DiningTable(string ModelNo, string Material, int UnitPrice, int Quantity, string Purpose) : Table(ModelNo, Material, UnitPrice, Quantity, Purpose) {}
    ~DiningTable() {}
};


void sortFurniture(Furniture* *arr){
    
    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 9; j++)
        {
            if(arr[j]->getType()>arr[j+1]->getType()){
                swap(arr[j],arr[j+1]);
                

            }
        }
        
    }
    

}
int Furniture::total_furniture = 0;
int main()
{
    
    Furniture* arr[10];
    Chair c1;
    // cout <<c1.getType();
    arr[0] = new Chair;
    arr[1] = new Table;
    arr[2] = new Table;
    arr[3] = new Table;
    arr[4] = new Chair;
    arr[5] = new Bed;
    arr[6] = new Table;
    arr[7] = new Bed;
    arr[8] = new DiningTable;
    arr[9] = new Chair;
    sortFurniture(arr);
    for (int i = 0; i < 10; i++)
    {
        if(arr[i]->getType()== 1){
            cout << "Table" << endl;
        }
        else if(arr[i]->getType()== 2){
            cout << "Bed" << endl;
        }
        else cout << "Chair" << endl;
    }
    
    
}
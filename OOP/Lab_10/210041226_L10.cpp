
#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
using namespace std;

class Product{

protected:
    int ID;
    string title;
    string author_or_director;
    static int total_products;
public:
    Product(string _title , string _authorName , int id):title(_title),author_or_director(_authorName),ID(id){
        total_products++;
    }
    virtual void displayInfo() const = 0;
    static int getTotalProducts(){
        return total_products;
    }
    bool operator<(Product& other)const{
        return ID < other.ID;
    }
    bool operator>(Product& other)const{
        return ID > other.ID;
    }
    string getTitle()const{
        return title;
    }


};

class Book:public Product{
public:
    Book(string _title , string _authorName , int id):Product(_title , _authorName , id){}
    void displayInfo() const override{
        cout << "Product: Book" << endl;
        cout << "ID: " << ID << endl;
        cout << "Title : " << title << endl;
        cout << "Author : " << author_or_director << endl;

    }

};

class DVD:public Product{
public:
    DVD(string _title , string _authorName , int id):Product(_title , _authorName , id){}
    void displayInfo() const override{
        cout << "Product: DVD" << endl;
        cout << "ID: " << ID << endl;
        cout << "Title : " << title << endl;
        cout << "Director : " << author_or_director << endl;
        }
};
int Product::total_products = 0;

int main(){
    Product* products[5];
    products[0] = new Book("Book 1" , "Author 1", 12);
    products[1] = new DVD("DVD 1" , "Director 1", 65);
    products[2] = new Book("Book 2" , "Author 2", 23);
    products[3] = new DVD("DVD 2" , "Director 2", 45);
    products[4] = new DVD("DVD 3" , "Director 3", 34);



    for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4 - i; j++) {
        if (*products[j] > *products[j + 1]) {
            swap(products[j], products[j + 1]);
        }
    }
}

    for (int i = 0; i < 5; i++)
    {
        products[i]->displayInfo();
        if(i < 5 && products[i] < products[i+1]){
            cout << products[i]->getTitle() << " < " << products[i+1]->getTitle() << endl;
        }
        cout << endl;
    }




    cout << "Total Products: " << Product::getTotalProducts();

}

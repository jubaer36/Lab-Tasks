#include <fstream>
#include <iostream>
#include <typeinfo>
#include <stdio.h>
#include <bits/stdc++.h>
using namespace std;

const int LEN = 32;
const int MAXEM = 100;

enum product_type{
    tbook,
    tDVD
};
class Product{
    protected:
        int ID;
        char title[LEN];
        char author_or_director[LEN];
        static int total_product;
        static Product *products[];
    public:
        virtual void getdata(){
            cin.ignore(10,'\n');
            cout << "   Enter title: ";
            cin >> title;
            cout << "   Enter ID: ";
            cin >> ID;
            cout << "   Enter Author/Producer: ";
            cin >> author_or_director;
        }    
        virtual void putdata()
        {
            cout << "\n   Title: " << title;
            cout << "\n   ID: " << ID;
            cout << "\n   Author: " << author_or_director;
        }
        virtual product_type get_type();
        static void add();
        static void display();
        static void read();
        static void write();

};
int Product::total_product;
Product* Product::products[MAXEM];
class Book : public Product{
    public:
        void getdata(){
            Product::getdata();
        }
        void putdata(){
            Product::putdata();
        }
};
class DVD : public Product{
    public:
        void getdata(){
            Product::getdata();
        }
        void putdata(){
            Product::putdata();
        }
};
void Product::add(){
    char ch;
    cout<< "'b' to add a book"
            "\n'c' to add a CD/DVD"
            "\nEnter your choice:";
    cin>>ch;
    switch (ch)
    {
    case 'b':
        products[total_product] = new Book;
        break;
    case 'c':
        products[total_product] = new DVD;
        break;
    default:
        cout << "\nUnknown employee type\n";
        break;
    }      
    products[total_product++]->getdata();  
}
product_type Product::get_type(){
    if(typeid(*this) == typeid(Book))
        return tbook;
    else if(typeid(*this) == typeid(DVD))
        return tDVD;
    else{
        cerr << "\nWrong Product type";
        exit(1);
    }  
    return tbook;  
}
void Product::display(){
    for(int i=0;i<total_product;i++){
        cout<<(i+1);
        switch (products[i]->get_type())
        {
        case tbook:
            cout << ". Type: Book";
            break;
        case tDVD:
            cout << ". Type: DVD"; 
            break;
        default:
            cout << "Type unknown";
            break;
        }
        products[i]->putdata();
        cout<<endl;
    }    
}
void Product::write(){
    int size;
    cout<< "Writing "<<total_product<<" products.\n";
    ofstream ouf;
    product_type ptype;
    ouf.open("PRODUCTS.DAT", ios::trunc|ios::binary);
    if(!ouf){
        cout<<"\nCannot open file.";
        return;
    }
    for(int i=0 ; i<total_product ; i++){
        ptype = products[i]->get_type();
        ouf.write((char*)&ptype,sizeof(ptype));
        switch(ptype){
            case tbook:
                size=sizeof(Book);
                break;
            case tDVD:
                size=sizeof(DVD);
                break;    
        }  
        ouf.write( (char*)(products[i]),size);  
        if(!ouf)
         { cout << "\nCan't write to file\n"; return; }
      
    }
}
void Product::read(){
    int size;
    product_type ptype;
    ifstream inf;
    inf.open("PRODUCTS.DAT",ios::binary);
    if(!inf)
      { cout << "\nCan't open file\n"; return; }
    total_product = 0;
    while(true){
        inf.read((char*)&ptype, sizeof(ptype));
        if(inf.eof())
            break;
        if(!inf){
            cout << "\nCan't read type from file\n"; return;
        }    
        switch(ptype){
            case tbook:
                products[total_product] = new Book;
                size = sizeof(Book);
                break;
            case tDVD:
                products[total_product] = new DVD;
                size = sizeof(DVD);
                break; 
            default: cout << "\nUnknown type in file\n"; return;       
        }    
        inf.read( (char*)products[total_product],size);
        if(!inf)                //error but not eof
         { cout << "\nCan't read data from file\n"; return; }

        total_product++;
    } 
    cout << "Reading " << total_product << " products\n"; 
}
int main(){
    //Product prod;
    char ch;
    
    while(true)
      {
      cout << "'a' -- add data for an employee"
             "\n'd' -- display data for all employees"
              "\n'w' -- write all employee data to file"
              "\n'r' -- read all employee data from file"
              "\n'x' -- exit"
              "\nEnter selection: ";
      cin >> ch;
      switch(ch)
         {
         case 'a':            //add an employee to list
            Product::add(); break;
        case 'd':            //display all employees
            Product::display(); break; 
         case 'w':            //write employees to file
             Product::write(); break;
         case 'r':            //read all employees from file
             Product::read();  break;
         case 'x': exit(0);   //exit program
         default: cout << "\nUnknown command";
         }  //end switch
      }  
    
    return 0;
}

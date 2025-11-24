#include <bits/stdc++.h>
using namespace std;
const int maxProducts = 10;
enum ProductType
{
    tBook,
    tDVD
};
class Product
{   
    private:
    
protected:
    int ID;
    string title;
    string author_or_director;
    
    

public:
    static int total_products;
    static Product *products[];
    Product(string _title, string _authorName, int id) : title(_title), author_or_director(_authorName), ID(id)
    {}
    Product() {}
    virtual ProductType get_type()
    {
        if (typeid(*this) == typeid(tBook))
            return tBook;
        else if (typeid(*this) == typeid(tDVD))
            return tDVD;
        else return tDVD;
    }
    static void write();
    static void read();
    void setInfo(string tl,string athr, int id){
        title = tl;
        author_or_director = athr;
        ID = id;
    }

    virtual void displayInfo() const = 0;
    static int getTotalProducts()
    {
        return total_products;
    }
    bool operator<(Product &other) const
    {
        return ID < other.ID;
    }
    bool operator>(Product &other) const
    {
        return ID > other.ID;
    }
    string getTitle() const
    {
        return title;
    }

    
    
    static void display(){
        for (int i = 0; i < total_products; i++)
        {
            products[i]->displayInfo();
        }
        
    }

    static void add();
    
    
};

class Book : public Product
{
public:
    Book(string _title, string _authorName, int id) : Product(_title, _authorName, id) {}
    Book() {}
    void displayInfo() const override
    {
        cout << "Product: Book" << endl;
        cout << "ID: " << ID << endl;
        cout << "Title : " << title << endl;
        cout << "Author : " << author_or_director << endl;
    }
};

class DVD : public Product
{
public:
    DVD(string _title, string _authorName, int id) : Product(_title, _authorName, id) {}
    DVD(){}
    void displayInfo() const override
    {
        cout << "Product: DVD" << endl;
        cout << "ID: " << ID << endl;
        cout << "Title : " << title << endl;
        cout << "Director : " << author_or_director << endl;
    }
};

void Product::write()
    {
        int size;
        
        ofstream of;       // open ofstream in binary
        ProductType ptype; // type of each employee object

        of.open("Products.DAT", ios::trunc | ios::binary);
        if (!of)
        {
            cout << "\nCan't open file\n";
            return;
        }
        for (int j = 0; j < total_products; j++) // for every employee object
        {                                        // get its type
            ptype = products[j]->get_type();
            // write type to file

            of.write((char *)&ptype, sizeof(ptype));
            switch (ptype) // find its size
            {
            case tBook:
                size = sizeof(tBook);
                break;
            case tDVD:
                size = sizeof(tDVD);
                break;
            }
            of.write((char *)(products[j]), size);
            if (!of)
            {
                cout << "\nCan't write to file\n";
                return;
            }
        }
        cout << "Writing "<< total_products <<" Products.\n";
    }

    void Product::read()
    {
        int size;          // size of employee object
        ProductType ptype; // type of employee
        ifstream inf;      // open ifstream in binary
        inf.open("Products.DAT", ios::binary);
        if (!inf)
        {
            cout << "\nCan't open file\n";
            return;
        }
        int n = 0;
        while (true)
        {
            inf.read((char *)&ptype, sizeof(ptype));
            if (inf.eof()) // quit loop on eof
                break;
            if (!inf) // error reading type
            {
                cout << "\nCan't read type from file\n";
                return;
            }
            switch (ptype)
            {           // make new product
            case tBook: // of correct type
                products[n] = new Book;
                size = sizeof(tBook);
                break;
            case tDVD:
                products[n] = new DVD;
                size = sizeof(tDVD);
                break;
            default:
                cout << "\nUnknown type in file\n";
                return;
            } // read data from file into it
            inf.read((char *)products[n], size);
            if (!inf) // error but not eof
            {
                cout << "\nCan't read data from file\n";
                return;
            }
            n++; // count employee
        }        // end while
        cout << "Reading "<<n<<" products\n";
    }

void Product::add()
    {
        char ch;
        string ttl , dir;
        int num;
        cout << "'b' to add a book"
                "\n'd' to add a DVD"
                "\nEnter selection: ";
        cin >> ch;
        switch (ch)
        { // create specified employee type
        case 'b':
            products[total_products] = new Book;
            break;
        case 'd':
            products[total_products] = new DVD;
            break;
        default:
            cout << "\nUnknown product type\n";
            break;
        }
        cout << "\nTitle: ";
        cin >> ttl;
        cout <<"\nDirector/Author: ";
        cin >> dir;
        cout << "\nSerial Number: ";
        cin >> num;
        products[total_products++]->setInfo(ttl,dir,num);
    }

Product *Product::products[maxProducts];
int Product::total_products = 0;

int main()
{
    // for (int i = 0; i < 1; i++)
    // {
    //     Product::add();
        
    // }
    Product::read();
    Product::display();
    //Product::write();
    
    
    
    
}
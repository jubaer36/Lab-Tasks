#include <iostream>
#include "Book.h"
#include "Member.h"
using namespace std;


class Library{
private:
    string name;
    string location;
    string working_hours;


public:
    Book* Books[10];
    Member* Members[5];
    Library(string nm , string lc , string wh): name(nm), location(lc) , working_hours(wh){}
    void add_books(Book bk){
        Books[total_books] = new Book(bk.Gettitle() , bk.Getauthor() , bk.Getpublication_date() , bk.GetISBN_edition());
        total_books++;
    }
    void add_members(Member m){
        Members[total_members] = new Member(m.Getname() , m.Getpostal_mail(), m.Getemail(), m.Getphone_number(),m.Getmembership_status());
        total_members++;
    }
    string get_name(){return name;}
    string get_location(){return location;}
    string  get_working_hours(){return working_hours;}
    void set_name(string nm){name = nm;}
    void set_locatin(string lc){location = lc;}
    void set_working_hours(string wh){working_hours = wh;}
    static int total_books;
    static int total_members;

};

 int Library::total_books = 0;
 int Library::total_members = 0;
int main()
{
    Library L("Library 1" , "Gazipur ", "6-10");

    Member m("Member1","Postal Mail" , "member@email" , "954984", true);
    L.add_members(m);
    Book b("Book1" , "Author1" , "2048","isbn1");
    L.add_books(b);
    cout << "Library Info" << endl;
    cout << "Library Name: " << L.get_name() << endl;
    cout << "Library Location: " << L.get_location() << endl;
    cout << "Library working Hours: " << L.get_working_hours() << endl;
    cout << "Book Details: " << endl;
    cout << "Book title : " << L.Books[0]->Gettitle() << endl;
    cout << "Book Author : " << L.Books[0]->Getauthor() << endl;
    cout << "Book Pub Date : " << L.Books[0]->Getpublication_date() << endl;

    cout << "Member Info: " << endl;
    cout << "Member Name: " << L.Members[0]->Getname() << endl;
    cout << "Member Postal Mail: " << L.Members[0]->Getpostal_mail() << endl;
    cout << "Member EMail: " << L.Members[0]->Getemail() << endl;
    cout << "Member Phone Number: " << L.Members[0]->Getphone_number() << endl;
    return 0;
}

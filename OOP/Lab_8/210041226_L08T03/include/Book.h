#ifndef BOOK_H
#define BOOK_H

#include <iostream>
#include <string>
using namespace std;
class Book
{
    public:
        Book();
        Book(string tl , string at , string pb , string isbn_edition):title(tl) , author(at) , publication_date(pb), ISBN_edition(isbn_edition){}
        virtual ~Book();

        string Gettitle() { return title; }
        void Settitle(string val) { title = val; }
        string Getauthor() { return author; }
        void Setauthor(string val) { author = val; }
        string Getpublication_date() { return publication_date; }
        void Setpublication_date(string val) { publication_date = val; }
        string GetISBN_edition() { return ISBN_edition; }
        void SetISBN_edition(string val) { ISBN_edition = val; }


    private:
        string title;
        string author;
        string publication_date;
        string ISBN_edition;
};

#endif // BOOK_H

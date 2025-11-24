#ifndef MEMBER_H
#define MEMBER_H

#include <iostream>
#include <string>
using namespace std;
class Member
{
    public:
        Member();
        Member(string n , string pm , string em , string pn, bool member): name(n) , postal_mail(pm) , phone_number(pn) , membership_status(member){
        }
        virtual ~Member();

        string Getname() { return name; }
        void Setname(string val) { name = val; }
        string Getpostal_mail() { return postal_mail; }
        void Setpostal_mail(string val) { postal_mail = val; }
        string Getemail() { return email; }
        void Setemail(string val) { email = val; }
        bool Getmembership_status() { return membership_status; }
        void Setmembership_status(bool val) { membership_status = val; }
        string Getphone_number() { return phone_number; }
        void Setphone_number(string val) { phone_number = val; }

    protected:

    private:
        string name;
        string postal_mail;
        string email;
        bool membership_status;
        string phone_number;
};

#endif // MEMBER_H

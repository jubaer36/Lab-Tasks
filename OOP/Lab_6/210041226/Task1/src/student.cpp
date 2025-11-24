#include "student.h"
#include <string>
#include <iostream>
student::student()
{
    //ctor
}
student::student(string firstName,string lastName, string studentID,int birthYear)
{
    SetfirstName(firstName);
    SetlastName(lastName);
    SetstudentID(studentID);
    SetbirthYear(birthYear);
}


student::~student()
{
    totalStudents--;
    cout << "Name: " << firstName << " " << lastName << endl;
    cout << "ID: " << studentID << endl;
    cout <<"Course: " << course << endl;
    if(will_graduate()) cout << "This student will graduate" << endl;
    else cout <<  "This student will not graduate" << endl;
    if(apply_for_scholarship()) cout << "This student will apply for scholarship" << endl;
    else cout <<  "This student will not apply for scholarship" << endl;
    if(participate_in_internship()) cout << "This student will participate in internship" << endl;
    else cout <<  "This student will not participate in internship" << endl;
    cout << "Current student count " << totalStudents << endl;
}


string student::GetfirstName()
{
    return firstName;
}
void student::SetfirstName(string val)
{
    firstName = val;
}
string student::GetlastName()
{
    return lastName;
}
void student::SetlastName(string val)
{
    lastName = val;
}
string student::GetstudentID()
{
    return studentID;
}
void student::SetstudentID(string val)
{
    studentID = val;
}
int student::GetbirthYear()
{
    return birthYear;
}
void student::SetbirthYear(int val)
{
    birthYear = val;
}
int student::Getage()
{
    return age;
}
void student::Setage(int val)
{
    age = val;
}
string student::Getcourse()
{
    return course;
}
void student::Setcoure(string val)
{
    course = val;
}

float student::GetobtainedMark()
{
    return obtainedMark;
}
void student::SetobtainedMark(float val)
{
    obtainedMark = val;
}
float student::Getgpa()
{
    return gpa;
}
void student::Setgpa(float val)
{
    gpa = val;
}


string student::generateEmail()
{
    email = firstName+lastName+"iut@dhaka.edu";
    return email;
}

void student::calculate_gpa()
{
    if(obtainedMark > 80) gpa =  4.00;
    else if(obtainedMark > 74 && obtainedMark < 80)gpa = 3.75;
    else if(obtainedMark > 69 && obtainedMark < 75)gpa =  3.50;
    else if(obtainedMark > 64 && obtainedMark < 70)gpa =  3.25;
    else if(obtainedMark > 59 && obtainedMark < 65)gpa = 3.00;
    else if(obtainedMark > 54 && obtainedMark < 60)gpa = 2.75;
    else if(obtainedMark > 49 && obtainedMark < 55)gpa = 2.50;
    else gpa =  0;
}

bool student::will_graduate()
{
    if(gpa)return true;
    else return false;
}
bool student::apply_for_scholarship()
{
    if(gpa>3.8)return true;
    return false;
}
bool student::participate_in_internship()
{
    if(gpa>3)return true;
    return false;
}

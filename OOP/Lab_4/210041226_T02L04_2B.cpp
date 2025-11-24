#include<iostream>
#include<string>
using namespace std;

class Student{
private:
    string firstName;
    string lastName;
    string studentID;
    string email;
    int birthYear;
    int age;
    string course;
    float obtainedMark;
    float gpa;


public:
    static int totalStudents;
    Student(string firstName ,string lastName , string studentID ,int birthYear){
        this->firstName = firstName;
        this->lastName = lastName;
        this->studentID = studentID;
        this->birthYear = birthYear;
        this->age = 2023 - birthYear;
    }
    void enrollingCourse(string courseName){
        course = courseName;
    }
    string generateEmail(){
        email = firstName+lastName+"iut@dhaka.edu";
        return email;
    }
    void set_obtainedMarks(float marks){
        obtainedMark = marks;

    }
    void calculate_gpa(){
        if(obtainedMark > 80) gpa =  4.00;
        else if(obtainedMark > 74 && obtainedMark < 80)gpa = 3.75;
        else if(obtainedMark > 69 && obtainedMark < 75)gpa =  3.50;
        else if(obtainedMark > 64 && obtainedMark < 70)gpa =  3.25;
        else if(obtainedMark > 59 && obtainedMark < 65)gpa = 3.00;
        else if(obtainedMark > 54 && obtainedMark < 60)gpa = 2.75;
        else if(obtainedMark > 49 && obtainedMark < 55)gpa = 2.50;
        else gpa =  0;
    }
    float display_gpa(){
        return gpa;
    }
    bool will_graduate(){
        if(gpa)return true;
        else return false;
    }
    bool apply_for_scholarship(){
        if(gpa>3.8)return true;
        return false;
    }
    bool participate_in_internship(){
        if(gpa>3)return true;
        return false;
    }
    void printAcademicRecord(){
        cout << "Name: " << firstName << " " << lastName << endl;

        cout << "ID: " << studentID << endl;
        cout <<"Course: " << course << endl;
        if(will_graduate()) cout << "This student will graduate" << endl;
        else cout <<  "This student will not graduate" << endl;
        if(apply_for_scholarship()) cout << "This student will apply for scholarship" << endl;
        else cout <<  "This student will not apply for scholarship" << endl;
        if(participate_in_internship()) cout << "This student will participate in internship" << endl;
        else cout <<  "This student will not participate in internship" << endl;
    }


    ~Student(){
        totalStudents--;
        cout << "Current student count " << totalStudents << endl;
        cout << "Destructing object" << endl;
    }

};



int Student::totalStudents = 50;
int main(){
    Student student1("A" , " Khan" ,"2167343", 1999);
    student1.enrollingCourse("CSE 4301");
    student1.set_obtainedMarks(75);
    student1.generateEmail();
    student1.calculate_gpa();
    cout << "Total Students: " << student1.totalStudents << endl;
    student1.printAcademicRecord();
}

#ifndef STUDENT_H
#define STUDENT_H
#include <string>
#include <iostream>

using namespace std;
class student
{
    public:
        static int totalStudents;
        student();
        student(string firstName,string lastName,string id,int birthYear);
        ~student();

        string GetfirstName();
        void SetfirstName(string val);
        string GetlastName();
        void SetlastName(string val);
        string GetstudentID();
        void SetstudentID(string val);
        int GetbirthYear();
        void SetbirthYear(int val);
        int Getage();
        void Setage(int val);
        string Getcourse();
        void Setcoure(string val);
        void enrollingCourse(string courseName);
        float GetobtainedMark();
        void SetobtainedMark(float val);
        float Getgpa();
        void Setgpa(float val);

        string generateEmail();
        bool will_graduate();
        bool apply_for_scholarship();
        bool participate_in_internship();
        void calculate_gpa();

    private:
        string firstName;
        string lastName;
        string studentID;
        int birthYear;
        int age;
        string course;
        float obtainedMark;
        float gpa;
        string email;
};

#endif // STUDENT_H

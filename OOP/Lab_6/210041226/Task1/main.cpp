#include <iostream>
#include <string>
#include <student.h>
using namespace std;
int student::totalStudents = 30;
int main()
{
    student temp_student;
    for(int i = 0 ; i < 1 ; i++)
    {
        cout << "Name: ";
        string val1, val2;
        int val;
        float mark;
        cin >> val1 >> val2;
        temp_student.SetfirstName(val1);
        temp_student.SetlastName(val2);
        cout << endl;
        cout << "ID : ";
        cin >> val1;
        temp_student.SetstudentID(val1);
        cout << endl;
        cout << "Birth year: " ;
        cin >> val ;
        temp_student.SetbirthYear(val);
        cout << endl;
        cout << "Course : " ;
        cin >> val1;
        temp_student.Setcoure(val1);
        cout << "Marks : ";
        cin >> mark;
        temp_student.SetobtainedMark(mark);
        temp_student.calculate_gpa();
        temp_student.generateEmail();
        temp_student.generateEmail();
        temp_student.Setcoure(val1);


    }

}


#include<iostream>
#include<string>

using namespace std;


class Student
{
private:
    string name;
    float grade;
public:
    string get_name()
    {
        return name;
    }
    void set_name(string name)
    {
        this->name = name;
    }
    float get_grade()
    {
        return grade;
    }
    void set_grade(float grade)
    {
        this->grade = grade;
    }
};

class StudentCollection
{
private:
    Student studentCollection[10];
public:
    Student& operator [](int n){
        if(n < 0 || n > 9){
            cout << "Out of Bounds " << endl;
            exit(1);
        }
        return studentCollection[n];
    }
    Student& operator [](string key){
        for(int i = 0 ; i < 10 ; i++){
            if(studentCollection[i].get_name() == key){
                return studentCollection[i];
            }
        }
        exit(1);
    }

    Student& addStudent(string name , float grade){
        for(int i = 0 ; i < 10 ; i++){
            if(studentCollection[i].get_name()==""){
                studentCollection[i].set_name(name);
                studentCollection[i].set_grade(grade);
                return studentCollection[i];

            }
        }
        exit(1);
    }
};

int main(){
    StudentCollection students;
    Student s;
    s.set_grade(7);
    s.set_name("gdf");
    students.addStudent("Nirjon",2.5);
    students[0].set_name("NOO");
    for(int i = 0 ; i < 3 ; i++){
        string str ;
        float val;
        cin >> str >> val;
        students[i].set_name(str);
        students[i].set_grade(val);
    }

    students.addStudent("Nin",2.5);
    students[2] = s;
    for(int i = 0 ; i < 4 ; i++){
        cout << students[i].get_name() << ' ' << students[i].get_grade() << endl;
    }


}

#ifndef TwoDimensionalShape_H
#define TwoDimensionalShape_H
#include <iostream>
#include <cmath>
using namespace std;

class TwoDimensionalShape
{
    public:
        TwoDimensionalShape();
        TwoDimensionalShape(float a , float b):length(a),breadth(b){}
        ~TwoDimensionalShape();

        float Getlength() { return length; }
        void Setlength(float val) { length = val; }
        float Getbreadth() { return breadth; }
        void Setbreadth(float val) { breadth = val; }
        virtual float Getperimeter() {
            perimeter = Getlength() + Getbreadth();
            return perimeter;
            }
        void Setperimeter(float val) { perimeter = val; }
        virtual float Getarea() {
            area = Getlength()*Getbreadth();
            return area;
             }
        void Setarea(float val) { area = val; }

        virtual void shapedetails(){
            cout << "Number of Sides:" << 2 << endl;
            cout << "Type: ";
            cout <<"Two Dimensional " << endl;
            cout << "Area: " << Getarea() << endl;
            cout << "Perimeter = " << Getperimeter() << endl;
            cout << "Color: " << "None" << endl;

        }



    private:
        float length;
        float breadth;
        float perimeter;
        float area;

};

#endif // TwoDimensionalShape_H

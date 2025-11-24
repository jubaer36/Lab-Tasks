#ifndef RECTANGLE_H
#define RECTANGLE_H

#include "TwoDimensionalShape.h"
#include <iostream>
using namespace std;


class Rectangle : public TwoDimensionalShape
{
public:
    Rectangle() {}
    Rectangle(float a, float  b , string colr = "Green"):TwoDimensionalShape(a,b),color(colr){}
    ~Rectangle() {}
    float Getarea()
    {
        TwoDimensionalShape::Getarea();
    }
    float Getperimeter()
    {


        TwoDimensionalShape::Getperimeter();

    }
    void shapedetails()override{
            cout << "Number of Sides:" << 4 << endl;
            cout << "Type: ";
            cout << "Rectangle" << endl;
            cout << "Area: " << Getarea() << endl;
            cout << "Perimeter = " << Getperimeter() << endl;
            cout << "Color: " << Getcolor() << endl;

        }
    string Getcolor(){
            return color;
        }
        void Setcolor(string val)
        {

            color = val;
        }
private:
    string color;
};

#endif // RECTANGLE_H

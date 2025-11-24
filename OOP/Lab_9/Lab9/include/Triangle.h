#ifndef TRIANGLE_H
#define TRIANGLE_H

#include <iostream>
#include "TwoDimensionalShape.h"
using namespace std;

class Triangle : public TwoDimensionalShape
{
    public:
        Triangle(float a ,float b ,float c , string col = "Lavender"):TwoDimensionalShape(a , b) , third_side(c),color(col){
    }
        Triangle(){}
        float Getarea()override{
        float s = Getperimeter()/2;
        float a , b , c;
        a = TwoDimensionalShape::Getlength();
        b = TwoDimensionalShape::Getbreadth();
        c = third_side;
        float ar = sqrt((s-a)*(s-b)*(s-c)*s);
        TwoDimensionalShape::Setarea(ar);
        return ar;
    }
    float Getperimeter()override{

        float p = TwoDimensionalShape::Getlength() + TwoDimensionalShape::Getbreadth() + third_side;
        TwoDimensionalShape::Setperimeter(p);
        return p;
    }
    string Getcolor(){
            return color;
        }
        void Setcolor(string val)
        {

            color = val;
        }
        void shapedetails()override{
            cout << "Number of Sides:" << 3 << endl;
            cout << "Type: ";
            cout << "Triangle" << endl;
            cout << "Area: " << Getarea() << endl;
            cout << "Perimeter = " << Getperimeter() << endl;
            cout << "Color: " << Getcolor() << endl;

        }

    private:
        float third_side;
        string color;
};

#endif // TRIANGLE_H

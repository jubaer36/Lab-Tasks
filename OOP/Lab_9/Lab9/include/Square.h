#ifndef SQUARE_H
#define SQUARE_H

#include "TwoDimensionalShape.h"
#include <iostream>
using namespace std;

class Square : public TwoDimensionalShape
{

public:
    Square(){}
    Square(float a , string colr = "Red"):TwoDimensionalShape(a,a),color(colr){}
    void Setarea(float a){
        TwoDimensionalShape::Setarea(a);
    }
    void Setperimeter(float val){
        TwoDimensionalShape::Setperimeter(val);
    }
    float Getarea(){
        TwoDimensionalShape::Getarea();
    }
    float Getperimeter(){
        TwoDimensionalShape::Getperimeter();
    }
    void shapedetails()override{
            cout << "Number of Sides:" << 4 << endl;
            cout << "Type: ";
            cout <<"Square " << endl;
            cout << "Area: " << TwoDimensionalShape::Getarea() << endl;
            cout << "Perimeter = " << TwoDimensionalShape::Getperimeter() << endl;
            cout << "Color: " << Getcolor() << endl;

        }
    string Getcolor(){
            return color;
        }
        void Setcolor(string val)
        {

            color = val;
        }
    ~Square(){}

protected:

private:
    string color;
};

#endif // SQUARE_H

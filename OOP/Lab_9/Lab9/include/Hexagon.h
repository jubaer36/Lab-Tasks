#ifndef HEXAGON_H
#define HEXAGON_H

#include "TwoDimensionalShape.h"

#include <iostream>
using namespace std;
class Hexagon : public TwoDimensionalShape
{
     private:
        string color;
    public:

        Hexagon(float a, string colr = "White"):TwoDimensionalShape(a,a),color(colr){}
        ~Hexagon(){}
        float Getarea()override{
            TwoDimensionalShape::Setarea( (3*sqrt(3)*TwoDimensionalShape::Getlength()*TwoDimensionalShape::Getlength()/2));
            return TwoDimensionalShape::Getarea();
        }

        float Getperimeter()override{
            TwoDimensionalShape:Setperimeter(6*TwoDimensionalShape::Getlength());
            return TwoDimensionalShape::Getperimeter();
        }
        void shapedetails()override{
            cout << "Number of Sides:" << 6 << endl;
            cout << "Type: ";
            cout << "Hexagon" << endl;
            cout << "Area: " << Getarea()<< endl;
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





};

#endif // HEXAGON_H

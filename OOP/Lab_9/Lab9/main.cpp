#include <iostream>
#include "TwoDimensionalShape.h"
#include "Square.h"
#include "Rectangle.h"
#include "Hexagon.h"
#include "Triangle.h"
using namespace std;
int main()
{
    TwoDimensionalShape *shapes[8];
    Rectangle r1(5,6);
    Rectangle r2(4,6);
    Square sq2(5);
    Square sq1(3);
    Hexagon h1(5);
    Hexagon h2(4);
    Triangle t1(3,4,5);
    Triangle t2(6,4,5);
    shapes[0] = &r1;
    shapes[1] = &r2;
    shapes[2] = &t1;
    shapes[3] = &t2;
    shapes[4] = &h1;
    shapes[5] = &h2;
    shapes[6] = &sq1;
    shapes[7] = &sq2;



    for(int i = 0 ; i < 8 ; i++){
        for(int j = i; j < 7 ; j++){
            if(shapes[j]->Getarea()<shapes[j+1]->Getarea()){
                swap(shapes[j],shapes[j+1]);
            }
        }
    }
    cout << endl;
    for(int i = 0 ; i < 8 ; i++){
        shapes[i]->shapedetails();
    }



}

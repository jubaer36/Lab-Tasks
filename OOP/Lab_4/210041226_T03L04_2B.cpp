#include <iostream>
#include <string>
#include <cmath>
using namespace std;

class Rectangle{
private:
    float length;
    float width;
    float perimeter;
    float diagonal;
    float angle;


public:
    Rectangle(){
        length = 1;
        width = 1;
    }
    Rectangle(float length , float width){
        this->length = length;
        this->width = width;
    }
    float calculate_perimeter(){
        perimeter = 2*(length+width);
        return perimeter;
    }
    float calculate_diagonal(){
        diagonal = sqrt((length*length)+(width*width));
    }
    float calculateAngleWithLength(){
        angle = atan(width/length);
        return angle;
    }
    void set_dimensions(float newLength , float newWidth){
        if(newLength>=1 &&  newLength<20)length = newLength;
        else length = 0;
        if(newWidth>=1 &&  newWidth<20)width = newWidth;
        else width  = 0;
    }
    float get_width(){
        return width ;
    }
    float get_length(){
        return length;
    }

    ~Rectangle(){
    }
};

int main(){
    Rectangle rectangle1;
    rectangle1.set_dimensions(10,5);
    cout <<"Length: "<<rectangle1.get_length() << "  Width: " << rectangle1.get_width() << endl;

    cout << "Perimeter: " << rectangle1.calculate_perimeter()<<endl;
    cout << "Diagonal: " <<rectangle1.calculate_diagonal()<<endl;
    cout << "Angle: " <<rectangle1.calculateAngleWithLength()<<endl;


}

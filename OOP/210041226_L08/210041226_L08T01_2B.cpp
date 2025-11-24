
#include <iostream>
#include <string>
#include <cmath>
using namespace std;

class TwoDimensional{
private:
    float length;
    float width;
    float perimeter;
    float area;
public:
    TwoDimensional(float l , float w ): length(l) , width(w) ,perimeter(0) , area(0){
    }
    void whoami(){
        cout << "I am a two Dimensional Space" << endl;
    }
    float get_length(){
        return length;
    }
    float get_width(){
        return width;
    }
    void set_perimeter(float p){
        perimeter = p;
    }
    void set_area(float a){
        area = a;
    }


};

class ThreeDimensional{
private:
    float length;
    float width;
    float height;
    float volume;
    float surface_area;
public:
    ThreeDimensional(float a , float b , float c):length(a) , width(b) , height(c) , volume(0) , surface_area(0){
    }
    float get_length(){
        return length;
    }
    float get_width(){
        return width;
    }
    float get_height(){
        return height;
    }
    void set_volume(float v){
        volume = v;
    }
    void set_surface_area(float s){
        surface_area = s;
    }
    void whoami(){
        cout << "I am a two Dimensional Space" << endl;
    }

};

class Cube:public ThreeDimensional{
public:
    Cube(float a):ThreeDimensional( a , a , a){}
    float get_volume(){
        float v = ThreeDimensional::get_length()*ThreeDimensional::get_length()*ThreeDimensional::get_length();
        ThreeDimensional::set_volume(v);
        return v;
    }
    float get_surface_area(){
        float s =  ThreeDimensional::get_length()*ThreeDimensional::get_length() * 6;
        ThreeDimensional::set_surface_area(s);
        return s;
    }
    void whoami(){
        cout << "I am a cube" << endl;
        ThreeDimensional::whoami();
    }
};
class Sphere:public ThreeDimensional{
public:
    Sphere(float a):ThreeDimensional( 3.1416 , a , a){}
    float get_volume(){
        float v = ThreeDimensional::get_width()*ThreeDimensional::get_height()*ThreeDimensional::get_width()*ThreeDimensional::get_length();
        ThreeDimensional::set_volume(v);
        return v;
    }
    float get_surface_area(){
        float s =  ThreeDimensional::get_length()*ThreeDimensional::get_width() *ThreeDimensional::get_width() * 4;
        ThreeDimensional::set_surface_area(s);
        return s;
    }
    void whoami(){
        cout << "I am a sphere" << endl;
        ThreeDimensional::whoami();
    }
};
class Cylinder:public ThreeDimensional{
public:
    float get_volume(){
        float v = ThreeDimensional::get_width()*ThreeDimensional::get_height()*ThreeDimensional::get_width()*ThreeDimensional::get_length();
        ThreeDimensional::set_volume(v);
        return v;
    }
    float get_surface_area(){
        float s =  ThreeDimensional::get_length()*ThreeDimensional::get_width() *ThreeDimensional::get_width() * 4;
        ThreeDimensional::set_surface_area(s);
        return s;
    }
    void whoami(){
        cout << "I am a Cylinder" << endl;
        ThreeDimensional::whoami();
    }
};

class Triangle:public TwoDimensional{
private:
    float third_side;
public:
    Triangle(float a ,float b ,float c):TwoDimensional(a , b) , third_side(c){
    }
    float get_area(){
        float s = get_perimeter()/2;
        float a , b , c;
        a = TwoDimensional::get_length();
        b = TwoDimensional::get_width();
        c = third_side;
        float ar = sqrt((s-a)*(s-b)*(s-c)*s);
        TwoDimensional::set_area(ar);
        return ar;
    }
    float get_perimeter(){

        float p = TwoDimensional::get_length() + TwoDimensional::get_width() + third_side;
        TwoDimensional::set_perimeter(p);
        return p;
    }
    void whoami(){
        cout << "I am a Triangle" << endl;
        TwoDimensional::whoami();
    }
};

class Circle:public TwoDimensional{
private:
public:
    Circle(float r):TwoDimensional( 3.1416 , r){
    }
    float get_area(){


        float ar = TwoDimensional::get_width()*TwoDimensional::get_width()*TwoDimensional::get_length();
        TwoDimensional::set_area(ar);
        return ar;
    }
    float get_perimeter(){

        float p = TwoDimensional::get_length() * TwoDimensional::get_width() * 2;
        TwoDimensional::set_perimeter(p);
        return p;
    }
    void whoami(){
        cout << "I am a Circle" << endl;
        TwoDimensional::whoami();
    }
};

class Rectangle:public TwoDimensional{
private:
public:
    Rectangle(float a , float b):TwoDimensional( a , b){
    }
    float get_area(){


        float ar = TwoDimensional::get_width()*TwoDimensional::get_length();
        TwoDimensional::set_area(ar);
        return ar;
    }
    float get_perimeter(){

        float p = (TwoDimensional::get_length() + TwoDimensional::get_width() )* 2;
        TwoDimensional::set_perimeter(p);
        return p;
    }
    void whoami(){
        cout << "I am a Rectangle" << endl;
        TwoDimensional::whoami();
    }
};

class Square:public TwoDimensional{
private:
public:
    Square(float a):TwoDimensional( a , a){
    }
    float get_area(){


        float ar = TwoDimensional::get_width()*TwoDimensional::get_length();
        TwoDimensional::set_area(ar);
        return ar;
    }
    float get_perimeter(){

        float p = (TwoDimensional::get_length() + TwoDimensional::get_width() )* 2;
        TwoDimensional::set_perimeter(p);
        return p;
    }
    void whoami(){
        cout << "I am a Square" << endl;
        TwoDimensional::whoami();
    }
};

int main(){
    Cube c(8);
    c.whoami();
    cout <<"Volume: " << c.get_volume() << endl;
    cout <<"Surface Area: "<< c.get_surface_area() << endl;
    cout << endl;

    Sphere s(5);
    s.whoami();
    cout <<"Volume: " << s.get_volume() << endl;
    cout <<"Surface Area: "<< s.get_surface_area() << endl;
    cout << endl;

    Square sq(54);
    sq.whoami();
    cout <<"Area: "<<sq.get_area() << endl;
    cout << "Perimeter: " << sq.get_perimeter() << endl;
    cout << endl;
    Triangle t(5,12,13);
    t.whoami();
    cout <<"Area: "<<t.get_area() << endl;
    cout << "Perimeter: " << t.get_perimeter() << endl;
    cout << endl;
    Circle cr(4);
    cr.whoami();
    cout <<"Area: "<<cr.get_area() << endl;
    cout << "Perimeter: " << cr.get_perimeter() << endl;
    cout << endl;
}

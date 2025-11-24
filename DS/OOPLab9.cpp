#include <iostream>
#include <cmath>
using namespace std;



class TwoDimensionalShape
{
public:
    TwoDimensionalShape() {}
    TwoDimensionalShape(float a, float b) : length(a), breadth(b) {}
    ~TwoDimensionalShape() {}

    float Getlength() { return length; }
    void Setlength(float val) { length = val; }
    float Getbreadth() { return breadth; }
    void Setbreadth(float val) { breadth = val; }
    virtual float Getperimeter()
    {
        perimeter = Getlength() + Getbreadth();
        return perimeter;
    }
    void Setperimeter(float val) { perimeter = val; }
    virtual float Getarea()
    {
        area = Getlength() * Getbreadth();
        return area;
    }
    void Setarea(float val) { area = val; }

    virtual void shapedetails()
    {
        cout << "Number of Sides:" << 2 << endl;
        cout << "Type: ";
        cout << "Two Dimensional " << endl;
        cout << "Area: " << Getarea() << endl;
        cout << "Perimeter = " << Getperimeter() << endl;
        cout << "Color: "
             << "None" << endl;
    }

private:
    float length;
    float breadth;
    float perimeter;
    float area;
};

class Hexagon : public TwoDimensionalShape
{
private:
    string color;

public:
    Hexagon(float a, string colr = "White") : TwoDimensionalShape(a, a), color(colr) {}
    ~Hexagon() {}
    float Getarea() override
    {
        TwoDimensionalShape::Setarea((3 * sqrt(3) * TwoDimensionalShape::Getlength() * TwoDimensionalShape::Getlength() / 2));
        return TwoDimensionalShape::Getarea();
    }

    float Getperimeter() override
    {
    TwoDimensionalShape:
        Setperimeter(6 * TwoDimensionalShape::Getlength());
        return TwoDimensionalShape::Getperimeter();
    }
    void shapedetails() override
    {
        cout << "Number of Sides:" << 6 << endl;
        cout << "Type: ";
        cout << "Hexagon" << endl;
        cout << "Area: " << Getarea() << endl;
        cout << "Perimeter = " << Getperimeter() << endl;
        cout << "Color: " << Getcolor() << endl;
    }
    string Getcolor()
    {
        return color;
    }
    void Setcolor(string val)
    {

        color = val;
    }
};
class Rectangle : public TwoDimensionalShape
{
public:
    Rectangle() {}
    Rectangle(float a, float b, string colr = "Green") : TwoDimensionalShape(a, b), color(colr) {}
    ~Rectangle() {}
    float Getarea()
    {
        TwoDimensionalShape::Getarea();
    }
    float Getperimeter()
    {

        TwoDimensionalShape::Getperimeter();
    }
    void shapedetails() override
    {
        cout << "Number of Sides:" << 4 << endl;
        cout << "Type: ";
        cout << "Rectangle" << endl;
        cout << "Area: " << Getarea() << endl;
        cout << "Perimeter = " << Getperimeter() << endl;
        cout << "Color: " << Getcolor() << endl;
    }
    string Getcolor()
    {
        return color;
    }
    void Setcolor(string val)
    {

        color = val;
    }

private:
    string color;
};

class Square : public TwoDimensionalShape
{

public:
    Square() {}
    Square(float a, string colr = "Red") : TwoDimensionalShape(a, a), color(colr) {}
    void Setarea(float a)
    {
        TwoDimensionalShape::Setarea(a);
    }
    void Setperimeter(float val)
    {
        TwoDimensionalShape::Setperimeter(val);
    }
    float Getarea()
    {
        TwoDimensionalShape::Getarea();
    }
    float Getperimeter()
    {
        TwoDimensionalShape::Getperimeter();
    }
    void shapedetails() override
    {
        cout << "Number of Sides:" << 4 << endl;
        cout << "Type: ";
        cout << "Square " << endl;
        cout << "Area: " << TwoDimensionalShape::Getarea() << endl;
        cout << "Perimeter = " << TwoDimensionalShape::Getperimeter() << endl;
        cout << "Color: " << Getcolor() << endl;
    }
    string Getcolor()
    {
        return color;
    }
    void Setcolor(string val)
    {

        color = val;
    }
    ~Square() {}

protected:
private:
    string color;
};

class Triangle : public TwoDimensionalShape
{
public:
    Triangle(float a, float b, float c, string col = "Lavender") : TwoDimensionalShape(a, b), third_side(c), color(col)
    {
    }
    Triangle() {}
    float Getarea() override
    {
        float s = Getperimeter() / 2;
        float a, b, c;
        a = TwoDimensionalShape::Getlength();
        b = TwoDimensionalShape::Getbreadth();
        c = third_side;
        float ar = sqrt((s - a) * (s - b) * (s - c) * s);
        TwoDimensionalShape::Setarea(ar);
        return ar;
    }
    float Getperimeter() override
    {

        float p = TwoDimensionalShape::Getlength() + TwoDimensionalShape::Getbreadth() + third_side;
        TwoDimensionalShape::Setperimeter(p);
        return p;
    }
    string Getcolor()
    {
        return color;
    }
    void Setcolor(string val)
    {

        color = val;
    }
    void shapedetails() override
    {
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

int main()
{
    TwoDimensionalShape *shapes[8];
    Rectangle r1(5, 6);
    Rectangle r2(4, 6);
    Square sq2(5);
    Square sq1(3);
    Hexagon h1(5);
    Hexagon h2(4);
    Triangle t1(3, 4, 5);
    Triangle t2(6, 4, 5);
    shapes[0] = &r1;
    shapes[1] = &r2;
    shapes[2] = &t1;
    shapes[3] = &t2;
    shapes[4] = &h1;
    shapes[5] = &h2;
    shapes[6] = &sq1;
    shapes[7] = &sq2;

    for (int i = 0; i < 8; i++)
    {
        for (int j = i; j < 7; j++)
        {
            if (shapes[j]->Getarea() < shapes[j + 1]->Getarea())
            {
                swap(shapes[j], shapes[j + 1]);
            }
        }
    }
    cout << endl;
    for (int i = 0; i < 8; i++)
    {
        shapes[i]->shapedetails();
    }
}
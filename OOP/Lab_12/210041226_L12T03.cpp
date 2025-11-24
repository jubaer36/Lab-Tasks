#include <iostream>
#include <string>

#include <cmath>

using namespace std;

template <class T>
class MathOperation
{
public:
    class Exception
    {
    };
    class Exception2{

    };
    T divide(T x, T y)
    {   
        if (y == 0)
            throw Exception();
        return x / y;
        
    }
    T squareRoot(T x){
        if(x < 0) throw Exception2();
        return sqrt(x);
    }
};

int main()

{
    MathOperation<int> m1;
    try
    {

        cout <<"Division Result: "<<m1.divide(5, 3) << endl;
        cout << "Dividing "<<m1.divide(5, 0) << endl;

    }
    catch (MathOperation<int>::Exception)
    {
        cout << "Division by zero is not allowed" << endl;
    }
    try
    {
        cout << "Square Root: " << m1.squareRoot(6) << endl;
        cout << "Square Root: " << m1.squareRoot(-7) << endl;
    }
    catch(MathOperation<int>::Exception2)
    {
        cout << "Square Root of negative numbers not allowed" << endl;
    }
    
}
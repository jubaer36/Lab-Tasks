#include <iostream>
#include <string>

#include <cmath>

using namespace std;

template <class T>
class MathOperation{
public:
    T add(T x , T y){
        return x+y;
    }
    T divide(T x , T y){
        return x/y;
    }
    T squareRoot(T x){
        return sqrt(x);
    }

};


int main(){
    MathOperation<int>m1;
    MathOperation<float>m2;
    cout << "Adding two integers: " <<m1.add(3,4) << endl;
    cout << "Dividing two integers: " <<m1.divide(6,4) << endl;
    cout << "Adding two float: " <<m2.add(3.5,4.6) << endl;
    cout << "Dividing two float: " <<m2.divide(3.5,4.6) << endl;
    cout << "Square root(integer): " << m1.squareRoot(4) << endl;
    cout << "Square root(float): " << m2.squareRoot(5.6) << endl;

}
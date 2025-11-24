#include <iostream>
#include <string>
#include <cmath>
using namespace std;

template<class T>
T* multiplyArrays(T* t1, T* t2 ,T* res, int sz){
    for (int i = 0; i < sz ; i++)
    {
        res[i]=(t1[i]*t2[i]);
    }
    return res;
    
}

int main(){
    int arr1[5] = {1,2,3,4,5};
    int arr2[5] = {1,1,1,1,1};
    int *result = new int[5];
    result = multiplyArrays(arr1,arr2 ,result, 5);
    cout << "Integer array Multiplication: "<<endl;
    for (int i = 0; i < 5; i++)
    {
        cout << result[i] << ' ' ;
    }
    cout << endl;
    
    double arr3[5] = {1,2,3,4,5};
    double arr4[5] = {.5,.5,.5,.5,.5};
    double *res = new double[5];
    
    res = multiplyArrays(arr3,arr4,res,5);
    cout << "Double array Multiplication: " << endl;
    for (int i = 0; i < 5; i++)
    {
        cout << res[i] << ' ' ;
    }
    cout << endl;

}
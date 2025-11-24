#include <iostream>
#include <stack>

using namespace std;

int main(){
    int n , j = 0;
    bool sorted = true;
    cin >> n;
    int arr[n+1] , arr2[n+1];
    stack<int>stk;
    for (int i = 1; i <= n; i++)
    {
            cin >> arr[i];
    }
    for (int i = 1; i < n; i++)
    {
        if (arr[i] > arr[i+1])
        {
            stk.push(arr[i]);
        }
        else{
            arr2[j] = arr[i];
    
            j++;
        }
        
    }
    
    arr2[j] = arr[n];
    j++;
    for (int i = 0; i < j - 1 ; i++)
    {   
        if (arr2[i] > arr2[i+1])
        {
            sorted = false;
            break;
        }
        
        
    }
  
    while (!stk.empty())
    {
        
        stk.pop();
    }
    if (sorted)
    {
        cout << "Yes" << endl;
    }
    else cout << "No" << endl;
    
    
    
    
    
    
    
}
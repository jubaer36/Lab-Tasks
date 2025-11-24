#include<iostream>
#include<string>
#include<stack>

using namespace std;

int main(){
    stack<char>stk;
    string str;
    cin >> str;
    for (int i = 0; i < str.length(); i++)
    {
        if (!stk.empty())
        {
            if (stk.top() != str[i])
            {
                stk.push(str[i]);
                
            }
            else stk.pop();
            
        }
        else 
            stk.push(str[i]);
        
        
    }
    
    str = "";
    if (stk.empty())cout << "Null" << endl;
    else{
        while (!stk.empty())
        {
            str+=stk.top();
            stk.pop();
        }
        for (int i = str.length()-1; i >= 0 ; i--)
        {
            cout << str[i] ;
        }
        cout << endl;
        
    }
    
    
}
#include <iostream>
#include <string>
#include <stack>
using namespace std;
int checkError(string str, stack<char> &stk);
int main()
{
    stack<char> stk;
    int count;
    string str;
    cin >> str;
    count = checkError(str, stk);
    count += stk.size();
    cout << str.length() - count << endl;
}

int checkError(string str, stack<char> &stk)
{   
    int count = 0;
    for (int i = 0; i < str.length(); i++)
    {
        
        if (str[i] == '(')
        {
            stk.push(')');
        }
        else 
        {
            if (stk.empty() || stk.top() != str[i])
            {
                count++;
            }
            if(!stk.empty())stk.pop();
        }
        
    }
    return count;
}
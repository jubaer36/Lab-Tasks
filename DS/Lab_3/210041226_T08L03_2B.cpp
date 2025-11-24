#include <iostream>
#include <string>
#include <stack>
using namespace std;
bool checkError(string str, stack<char> &stk);
int main()
{
    stack<char> stk;
    bool errorFound = false;
    string str;
    int n;
    cin >> n;
    cin.ignore();
    for (int i = 0; i < n; i++)
    {

        getline(cin, str);
        if (!errorFound)
        {
            errorFound = checkError(str, stk);
        }
    }
    if (!stk.empty())
    {
        errorFound = true;
    }
    if (errorFound)
    {
        cout << "Error" << endl;
    }
    else
        cout << "No Errors" << endl;
}

bool checkError(string str, stack<char> &stk)
{
    for (int i = 0; i < str.length(); i++)
    {
        if (str[i] == '[')
        {
            stk.push(']');
        }
        else if (str[i] == '{')
        {
            stk.push('}');
        }
        else if (str[i] == '(')
        {
            stk.push(')');
        }
        else if (str[i] == ']' || str[i] == '}' || str[i] == ')')
        {
            if (stk.empty() || stk.top() != str[i])
            {
                return true;
            }

            stk.pop();
        }
        else
            continue;
    }
    return false;
}
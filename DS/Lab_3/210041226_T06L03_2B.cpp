#include <iostream>
#include <string>
#include <stack>
using namespace std;

int main()
{
    int t;
    cin >> t;
    cin.ignore();
    while (t--)
    {
        stack<char> stk;
        bool proper = true;
        string str;
        getline(cin, str);
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
            else if (str[i] == ']')
            {
                if (stk.empty() || stk.top() != str[i]  )
                {
                    proper = false;
                    break;
                }

                stk.pop();
            }
            else if (str[i] == '}')
            {
                if (stk.empty() || stk.top() != str[i])
                {
                    proper = false;
                    break;
                }

                stk.pop();
            }
            else if (str[i] == ')')
            {
                if (stk.empty() || stk.top() != str[i])
                {
                    proper = false;
                    break;
                }

                stk.pop();
            }

        }
        if (!stk.empty())
        {
            proper = false;
        }
        if (proper)
        {
            cout << "Yes" << endl;
        }
        else
            cout << "No" << endl;
    }
}

#include <iostream>
#include <string>
#include <stack>

using namespace std;
float operate(char ch, float a, float b);

int main()
{
    int t;
    cin >> t;
    cin.ignore();
    while (t--)
    {
        string exprsn;
        stack<float> stk;
        float x, y, val;
        getline(cin, exprsn);
        for (int i = 0; i < exprsn.length(); i++)
        {
            if (exprsn[i] == '*' || exprsn[i] == '+' || exprsn[i] == '-' || exprsn[i] == '/')
            {
                x = stk.top();
                stk.pop();
                y = stk.top();
                stk.pop();
                stk.push(operate(exprsn[i], y, x));
            }
            else
            {
                while (i < exprsn.length() && (exprsn[i] >= '0' && exprsn[i] <= '9'))
                {
                    val = exprsn[i] - '0';
                    stk.push(val);

                    i++;
                }
                i--;
            }
        }
        cout << stk.top() << endl;
    }
}

float operate(char ch, float a, float b)
{
    switch (ch)
    {
    case '+':
        return a + b;
    case '-':
        return a - b;
    case '*':
        return a * b;
    case '/':
        return a / b;
    }
    return 0;
}
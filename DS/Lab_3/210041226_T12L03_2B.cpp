#include <iostream>
#include <string>
#include <stack>
using namespace std;
int checkError(string str, stack<char> &stk);
int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        int n, count;
        cin >> n;
        string str;
        cin >> str;
        stack<char> stk;
        count = checkError(str, stk);
        cout << (n-count)/2 << endl;
    }
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

            if (!stk.empty() && stk.top() == str[i])
            {
                count += 2;
                stk.pop();
            }
        }
    }

    return  count;
}
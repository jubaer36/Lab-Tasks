#include <iostream>
#include <stack>

using namespace std;

int main()
{
    int n, q, val, x, count = 0;
    cin >> n >> q;
    stack<int> stk1, stk2;
    for (int i = 0; i < n; i++)
    {
        cin >> val;
        stk1.push(val);
    }
    while (!stk1.empty())
    {
        stk2.push(stk1.top());
        stk1.pop();
    }
    cout << endl;
    for (int i = 0; i < q; i++)
    {
        x = -1;
        count = 0;
        cin >> val;
        while (!stk2.empty())
        {
            cout << stk2.top() << ' ';
            if (stk2.top() == val && x == -1)
                x = val;
            else
            {

                stk1.push(stk2.top());
                if (x != -1)
                    count++;
            }
            stk2.pop();
        }
        // cout << n - count << ' ';
        cout << endl;

        while (!stk1.empty())
        {
            stk2.push(stk1.top());
            stk1.pop();
        }
        stk2.push(x);
    }
}
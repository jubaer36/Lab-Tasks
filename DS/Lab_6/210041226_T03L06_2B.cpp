#include <iostream>
#include <stack>
#include <queue>
#include <deque>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{

    int val, x, y;
    priority_queue<int, vector<int>> p;
    while (cin >> val && val != -1)
    {
        p.push(val);
    }

    while (p.size() > 1)
    {
        x = p.top();
        p.pop();
        y = p.top();
        p.pop();
        if (x != y)
        {
            y = abs(y - x);
            p.push(y);
        }
    }
    if(p.size()<1)cout << 0 << endl;
    else cout << p.top() << endl;

    return 0;
}
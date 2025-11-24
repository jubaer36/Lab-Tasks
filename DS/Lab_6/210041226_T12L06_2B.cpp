#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{

    int n, val;
    while (cin >> n && n != 0)
    {
        vector<int> v;
        for (int i = 0; i < n; i++)
        {
            cin >> val;
            v.push_back(val);
        }
        priority_queue<int, vector<int>, greater<int>> p(v.begin(), v.end());
        int x = 0 , y = 0 ,total = 0;
        while (p.size()>1)
        {
            x = p.top();
            p.pop();
            y  = p.top();
            p.pop();
            p.push(x+y);
            total+=x+y;
        }
        
        cout << total <<endl;
        
    }

    return 0;
}
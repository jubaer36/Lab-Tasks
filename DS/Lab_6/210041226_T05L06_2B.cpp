#include <iostream>
#include <vector>

#include <queue>
#include <unordered_map>
#include <algorithm>
using namespace std;

int main()
{
    int val, k;
    vector<int> v;
    priority_queue<pair<int, int>> p;
    unordered_map<int, int> m;
    while (1)
    {
        cin >> val;
        if (val == -1)
        {
            break;
        }
        m[val]++;
    }
    cin >> k;

    for (auto it : m)
    {
        p.push(make_pair(it.second , it.first));
    }

    

    while (k--)
    {
        v.push_back(p.top().second);
        p.pop();
    }

    for (auto i: v)
    {
        cout << i << " ";
    }

    cout << endl;
}

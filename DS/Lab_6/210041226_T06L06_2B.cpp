#include <iostream>
#include <utility>
#include <queue>
#include <vector>
#include <unordered_map>
#include <algorithm>
using namespace std;





int main()
{
    string str;
    cin >> str;

    unordered_map<char, int> m;
    for (auto ch : str)
    {
        m[ch]++;
    }
    

    priority_queue<pair<int, char>> p;
    for (auto it : m)
    {
        p.push(make_pair(it.second , it.first));
    }
    string res;
    pair<int, char> pr;
    while (!p.empty())
    {
        pr = p.top();
        p.pop();
        while (pr.first--)
        {
            res += pr.second;
        }
        
        
    }

    cout << res << endl;
    return 0;
}

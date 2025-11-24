#include <iostream>
#include <stack>
#include<vector>
#include<algorithm>
using namespace std;

int main()
{
    vector<int>v,v2;
    int val;
    cin >> val;
    while (val != -1)
    {
        v.push_back(val);
        cin>>val;
    }

    stack<int> stk;
    for (int j = v.size() - 1; j >= 0; j--)
    {
        while (1)
        {
            if (!stk.empty() && stk.top() <= v[j])
                stk.pop();
            else
                break;
        }

        if(!stk.empty())
        v2.push_back(stk.top());

        else
        v2.push_back(-1);

        stk.push(v[j]);
    }
    reverse(v2.begin(),v2.end());

    for(auto it:v2) cout<<it<<" ";
}

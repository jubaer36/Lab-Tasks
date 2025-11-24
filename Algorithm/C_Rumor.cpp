#include <bits/stdc++.h>
using namespace std;
#define ll long long
#define INT_MAX 100001
vector<vector<int>> persons(INT_MAX);
vector<bool> visited(INT_MAX, false);
vector<ll> bribed;
vector<ll> friends;

ll dfs(int node, ll &minSum)
{

    minSum = min(friends[node - 1], minSum);
    // cout << "Min Sum = " << minSum << "    Friends[node - 1] = " << friends[node - 1] << "   Node: " << node << endl;
    visited[node] = true;
    for (auto it : persons[node])
    {
        if (!visited[it])
        {

            dfs(it, minSum);
        }
    }
    return minSum;
}

int main()
{
    ll n, m, a, b, sum = 0, minSum = LONG_LONG_MAX;
    cin >> n >> m;
    for (int i = 0; i < n; i++)
    {
        cin >> a;
        friends.push_back(a);
    }

    for (int i = 0; i < m; i++)
    {
        cin >> a >> b;
        persons[a].push_back(b);
        persons[b].push_back(a);
    }
    for (int i = 1; i <= n; i++)
    {
        if (!visited[i])
        {
            // cout << "Not Visited bribe value for " << i << ": " << friends[i - 1] << ' ' << "Sum : " << sum << endl;
            minSum = LONG_LONG_MAX;
            sum += dfs(i, minSum);
        }
    }

    // cout << bribed.size() - 1 << endl;
    cout << sum << endl;
    return 0;
}
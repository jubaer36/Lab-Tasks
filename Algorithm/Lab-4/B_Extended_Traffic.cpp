#include <bits/stdc++.h>
using namespace std;
#define ll long long

vector<bool> visited(100001);
vector<ll> junction(100001, LONG_LONG_MAX);
vector<pair<ll, ll>> adj[100001];
priority_queue<pair<ll, ll>, vector<pair<ll, ll>>, greater<pair<ll, ll>>> q;

ll busyness(ll a, ll b);

void dijkstra()
{
    q.push(make_pair(0, 1));
    junction[1] = 0;
    while (!q.empty())
    {
        pair<ll, ll> node = q.top();
        ll cost = node.first;
        ll label = node.second;
        q.pop();
        if (visited[label])
            continue;
        visited[label] = true;
        ll sz = adj[label].size();
        for (int i = 0; i < sz; i++)
        {
            pair<ll, ll> nextnode = adj[label].at(i);
            ll edge_weight = nextnode.first;
            ll newlabel = nextnode.second;
            if (!visited[newlabel])
            {
                ll newcost = cost + edge_weight;
                if (newcost <= junction[newlabel])
                {
                    junction[newlabel] = newcost;
                    q.push(make_pair(newcost, newlabel));
                }
            }
        }
    }
}

int main()
{
    int t, testCase = 1;
    cin >> t;
    while (t--)
    {
        int n, m, a, b;
        cin >> n;
        for (int i = 0; i < n; i++)
        {
            cin >> junction[i + 1];
        }
        cin >> m;
        for (int i = 0; i < m; i++)
        {
            cin >> a >> b;
            adj[a].push_back(make_pair(busyness(a, b), b));
        }

        dijkstra();
        cin >> a;
        cout << "Case " << testCase << ": " << endl;
        for (int i = 0; i < a; i++)
        {
            cin >> b;
            if (junction[b] < 3 || !visited[b])
            {
                cout << "?" << endl;
            }
            else
                cout << junction[b] << endl;
        }

        visited.clear();
        visited.resize(100001);
        junction.clear();
        junction.resize(100001, LONG_LONG_MAX);
        while (!q.empty())
            q.pop();
        for (int i = 0; i < 100001; i++)
        {
            adj[i].clear();
        }

        testCase++;
    }
}

ll busyness(ll a, ll b)
{
    return (abs((junction[a] - junction[b]) * (junction[a] - junction[b]) * (junction[a] - junction[b])));
}

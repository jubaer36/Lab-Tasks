#include <bits/stdc++.h>
using namespace std;
#define ll long long

vector<bool> visited(100001);
vector<ll> dist(100001, LONG_LONG_MAX);
vector<pair<ll, ll>> adj[100001];
priority_queue<pair<ll, ll>, vector<pair<ll, ll>>, greater<pair<ll, ll>>> q;
void dijkstra()
{

    q.push(make_pair(0, 1));
    dist[1] = 0;
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
            // cout << "Edge weight: " <<edge_weight <<"   newlabel: "<<newlabel << endl;
            if (!visited[newlabel])
            {
                ll newcost = cost + edge_weight;
                if (newcost <= dist[newlabel])
                {
                    // cout << "new cost: " << newcost <<"   dist[newlabel] = "<< dist[newlabel] << endl;
                    dist[newlabel] = newcost;
                    // cout <<"after update dist[newlabel] : " << dist[newlabel] <<endl;
                    q.push(make_pair(newcost, newlabel));
                }
            }
        }
    }
}

int main()
{

    int n, m, a, b, c;
    cin >> n >> m;

    for (int i = 0; i < m; i++)
    {
        cin >> a >> b >> c;
        adj[a].push_back(make_pair(c, b));
    }
    // for (int i = 1; i <= n; i++)
    // {
    //     cout <<"i = " << i << endl;
    //     for (auto [v, w] : adj[i])
    //     {
    //         cout <<i <<' '<<v << ' ' << w;
    //         cout << endl;
    //     }
    //     cout << endl;
    // }

    dijkstra();
    for (int i = 1; i <= n; i++)
    {
        cout << dist[i] << ' ';
    }
    cout << endl;
}
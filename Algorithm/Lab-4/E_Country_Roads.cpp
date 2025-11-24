#include <bits/stdc++.h>
using namespace std;
#define ll long long
#define MAX 20005

typedef pair<ll, ll> pr;

void dijkstra(ll src, vector<vector<pr>> &adj, vector<ll> &dist, vector<bool> &visited)
{
    dist[src] = 0;
    priority_queue<pr, vector<pr>, greater<pr>> Q;
    Q.push(make_pair(dist[src], src));

    while (!Q.empty())
    {
        pr node = Q.top();
        ll cost = node.first;
        ll label = node.second;
        Q.pop();
        if (visited[label])
            continue;
        visited[label] = true;

        for (auto edge : adj[label])
        {

            ll edge_weight = edge.first;
            ll newlabel = edge.second;

            if (!visited[newlabel])
            {
                ll newcost = max(cost, edge_weight);
                if (newcost <= dist[newlabel])
                {
                    dist[newlabel] = newcost;
                    Q.push(make_pair(newcost, newlabel));
                }
            }
        }
    }
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    int t;
    cin >> t;
    for (int testCase = 1; testCase <= t; testCase++)
    {
        vector<vector<pr>> adj(MAX);
        vector<ll> dist(MAX, LLONG_MAX);
        vector<bool> visited(MAX, false);
        for (int i = 0; i < MAX; i++)
        {
            dist[i] = LLONG_MAX;
            visited[i] = false;
        }

        for (int i = 1; i < MAX; i++)
        {
            adj[i].clear();
        }
        ll n, m, u, v, w;
        cin >> n >> m;
        for (int i = 0; i < m; i++)
        {
            cin >> u >> v >> w;

            adj[u].push_back(make_pair(w, v));
            adj[v].push_back(make_pair(w, u));
        }
        ll mm;
        cin >> mm;
        dijkstra(mm, adj, dist, visited);
        cout << "Case " << testCase << ":" << endl;
        for (int i = 0; i < n; i++)
        {
            if (dist[i] == LLONG_MAX)
            {
                cout << "Impossible" << endl;
            }
            else
                cout << dist[i] << endl;
        }
    }
}
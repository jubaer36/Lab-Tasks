#pragma GCC optimize("Ofast")
#pragma GCC target("avx,avx2,fma")
#include <bits/stdc++.h>

typedef long long ll;
typedef unsigned long long ull;
typedef long double ld;

#define pb push_back
#define pob pop_back
#define pf push_front
#define pof pop_front
#define mp make_pair

using namespace std;

typedef pair<int, int> pii;

void dijkstra(int source, vector<int> &dist, vector<vector<pii>> &graph)
{
    priority_queue<pii, vector<pii>, greater<pii>> pq;

    dist[source] = 0;
    pq.push({0, source});

    while (!pq.empty())
    {
        int u = pq.top().second;
        int d = pq.top().first;
        pq.pop();

        if (d > dist[u])
            continue;

        for (auto edge : graph[u])
        {
            int v = edge.first;
            int w = edge.second;
            int max_road_cost = max(dist[u], w);
            if (max_road_cost < dist[v])
            {
                dist[v] = max_road_cost;
                pq.push({dist[v], v});
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
    int Case = 0;
    while (t--)
    {
        Case++;
        cout << "Case " << Case << ":" << endl;
        vector<vector<pii>> graph(1001);
        int u, v, s;
        cin >> u >> v;
        for (int i = 0; i < v; i++)
        {
            int a, b, c;
            cin >> a >> b >> c;

            graph[a].push_back({b, c});
            graph[b].push_back({a, c});
        }
        vector<int> dist(u, INT_MAX);
        cin >> s;
        dijkstra(s, dist, graph);

        int sum = 0;
        for (int i = 0; i < u; i++)
        {
            if (dist[i] == INT_MAX)
            {
                cout << "Impossible" << endl;
                continue;
            }
            cout << dist[i] << endl;
        }
    }

    return 0;
}
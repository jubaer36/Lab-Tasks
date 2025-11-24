#include <iostream>
#include <vector>
#include <queue>
#include <cstring>

using namespace std;

const int MAX_NODES = 210;

vector<int> g[MAX_NODES];
int color[MAX_NODES];

bool bfs(int src, int numNodes)
{
    memset(color, -1, sizeof(color));
    queue<int> q;
    q.push(src);
    color[src] = 0;

    while (!q.empty())
    {
        int u = q.front();
        q.pop();

        for (int i = 0; i < g[u].size(); i++)
        {
            int v = g[u][i];
            if (color[v] == -1)
            {
                color[v] = 1 - color[u];
                q.push(v);
            }
            else if (color[v] == color[u])
            {
                return false;
            }
        }
    }
    return true;
}

int main()
{
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);

    int numNodes, numEdges;
    while (cin >> numNodes && numNodes != 0)
    {
        cin >> numEdges;
        for (int i = 0; i < MAX_NODES; ++i)
            g[i].clear();

        for (int i = 0; i < numEdges; ++i)
        {
            int u, v;
            cin >> u >> v;
            g[u].push_back(v);
            g[v].push_back(u);
        }

        if (bfs(0, numNodes))
        {
            cout << "BICOLORABLE." << endl;
        }
        else
        {
            cout << "NOT BICOLORABLE." << endl;
        }
    }

    return 0;
}
#include <bits/stdc++.h>
using namespace std;

#define ll long long
#define MAX 205

vector<int> adj[MAX];
vector<int> color(MAX, -1);

bool bfs(int src, int n)
{
    queue<int> q;
    int temp;
    q.push(src);
    color[src] = 0;
    while (!q.empty())
    {
        temp = q.front();
        q.pop();
        for (int i = 0; i < adj[temp].size(); i++)
        {
            int v = adj[temp][i];
            if (color[v] == -1)
            {
                color[v] = 1 - color[temp];
                q.push(v);
            }
            else if (color[v] == color[temp])
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
    while (true)
    {

        int n, l, a, b;
        cin >> n;
        if (n == 0)
            return 0;
        cin >> l;
        for (int i = 0; i < l; i++)
        {
            cin >> a >> b;
            adj[a].push_back(b);
            adj[b].push_back(a);
        }
        if (bfs(0, n))
        {
            cout << "BICOLORABLE." << endl;
        }
        else
            cout << "NOT BICOLORABLE." << endl;
    }
    return 0;
}
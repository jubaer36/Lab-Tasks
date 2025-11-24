#include <bits/stdc++.h>
using namespace std;

double dfs(int node, int &sum, int &count, vector<int> &visited, vector<int> &people, vector<vector<int>> &relation)
{
    visited[node] = true;
    count++;
    sum += people[node];

    for (auto it : relation[node])
    {
        if (!visited[it])
        {
            dfs(it, sum, count, visited, people, relation);
        }
    }
    return (double)sum / (double)count;
}

int main()
{

    int t, testcase = 1;
    cin >> t;
    while (t--)
    {
        vector<int> visited(1005, false);
        vector<int> people(1005);
        vector<vector<int>> relation(1005);
        set<float> s;
        int n, m, sum = 0, count = 0;
        cin >> n >> m;
        for (int i = 1; i <= n; i++)
        {
            cin >> people[i];
        }
        for (int i = 0; i < m; i++)
        {
            int a, b;
            cin >> a >> b;
            relation[a].push_back(b);
            relation[b].push_back(a);
        }

        for (int i = 1; i <= n; i++)

        {

            if (!visited[i])
            {

                count = 0;
                sum = 0;
                s.insert(dfs(i, sum, count, visited, people, relation));
            }
        }
        cout << "Case " << testcase << ": ";
        if (s.size() > 1)
        {
            cout << "No" << endl;
        }
        else
        {
            auto it = s.begin();
            float val = *it;
            if (val == (int)val)
                cout << "Yes" << endl;
            else
                cout << "No" << endl;
        }
        testcase++;
    }
}
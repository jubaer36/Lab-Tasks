#include <bits/stdc++.h>
using namespace std;

void Init(vector<int> &v);
void MakeSet(vector<int> &v, int u);
void Union(vector<int> &v, vector<pair<int, int>> &r, int a, int b);
int Find(vector<int> &v, int u);

void Init(vector<int> &v)
{
    for (int i = 1; i <= v.size(); i++)
    {
        MakeSet(v, i);
    }
}



void MakeSet(vector<int> &v, int u)
{
    v[u] = u;
}

void Union(vector<int> &v, vector<pair<int, int>> &r, int a, int b)
{
    int x = Find(v, a);
    int y = Find(v, b);
    if (x != y)
    {
        v[y] = x;
    }
    else
    {

        r.push_back(make_pair(a, b));
    }
}

int Find(vector<int> &v, int u)
{
    if (v[u] == u)
        return u;
    else
        return v[u] = Find(v, v[u]);
}

int main()
{
    int n, a, b, count = 0;
    cin >> n;
    vector<int> v(10000, 0);
    vector<pair<int, int>> r;
    set<int> s;
    Init(v);
    for (int i = 0; i < n - 1; i++)
    {
        cin >> a >> b;
        Union(v, r, a, b);
    }
    s.insert(Find(v, 1));

    for (int i = 2; i <= n; i++)
    {
        // cout << v[i] << endl;
        a = Find(v, i);
        if (s.count(a) == 0)
        {
            count++;
            s.insert(a);
        }
    }
    cout << count << endl;
  
    int i = 1;
    auto st = s.begin();
    int first = *st;
    st++;
    for (auto it : r)

    {
        if (i > count)
            break;
        count - i;
        cout << it.first << ' ' << it.second << " " << first << " " <<*st << endl;
        st++;
        i++;
    }
}

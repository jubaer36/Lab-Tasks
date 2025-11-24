#include <bits/stdc++.h>
using namespace std;

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        int n, val;
        bool possible = false;
        cin >> n;
        unordered_map<int, int> m;
        for (int i = 0; i < n; i++)
        {
            cin >> val;
            m[val]++;
            if (m[val] >= 3)
                possible = true;
        }
        if (!possible)
        {
        }
        if (possible)
        {
            cout << "YES" << endl;
        }
        else
            cout << "NO" << endl;
    }
}
int palindromeChecker(map<int, int> &m, int n)
{
}

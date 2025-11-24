#include <bits/stdc++.h>
using namespace std;
typedef long long ll;
ll f(vector<ll> &wt, vector<ll> &val, vector<vector<ll>> &dp, ll n, ll w);
vector<vector<ll>> dp(105, vector<ll>(1000000001, -1));
int main()
{
    ll n, cap;
    cin >> n >> cap;
    vector<ll> wt(n), val(n);

    for (ll i = 0; i < n; i++)
    {

        ll w1, v1;
        cin >> w1 >> v1;
        wt[i] = w1;
        val[i] = v1;
    }
    // for (auto x : wt)
    //     cout << x << ' ';
    // cout << endl;
    // for (auto x : val)
    //     cout << x << ' ';
    cout << f(wt, val, dp, n - 1, cap);
}

ll f(vector<ll> &wt, vector<ll> &val, vector<vector<ll>> &dp, ll n, ll cap)
{
    // cout << n << "   " << cap << endl;

    if (n < 0 || cap <= 0)
    {
        return 0;
    }
    if (dp[n][cap] != -1)
        return dp[n][cap];

    if (wt[n] > cap)
    {

        dp[n][cap] = f(wt, val, dp, n - 1, cap);
    }
    else
    {
        ll temp1 = f(wt, val, dp, n - 1, cap);
        ll temp2 = val[n] + f(wt, val, dp, n - 1, cap - wt[n]);
        dp[n][cap] = max(temp1, temp2);
    }
    // cout << dp[n][cap] << endl;
    return dp[n][cap];
}
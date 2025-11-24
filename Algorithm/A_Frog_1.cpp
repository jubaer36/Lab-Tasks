#include <bits/stdc++.h>
using namespace std;
typedef long long ll;

int foo(int *arr, int size);
vector<int> dp(100001, -1);
int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin >> n;
    int arr[n];
    for (int i = 0; i < n; ++i)
    {
        cin >> arr[i];
    }
    cout << foo(arr, n - 1);
}

int foo(int *arr, int n)
{
    if (n == 0)
    {
        return 0;
    }
    if (n == 1)
    {
        dp[n] = abs(arr[1] - arr[0]);
    }
    if (dp[n] != -1)
        return dp[n];
    int val1 = abs(arr[n] - arr[n - 1]) + foo(arr, n - 1);
    int val2 = abs(arr[n] - arr[n - 2]) + foo(arr, n - 2);
    dp[n] = min(val1, val2);
    return dp[n];
}

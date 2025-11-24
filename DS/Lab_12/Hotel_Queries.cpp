#include <bits/stdc++.h>
using namespace std;

void init(long long node, long long begin, long long end, vector<long long> &arr, vector<long long> &SegTree);
long long query(long long node, long long begin, long long end, long long i, vector<long long> &SegTree , vector<long long> &arr);

int main()
{
    long long n, q, pos, updatedValue, val, x, y;
    cin >> n >> q;
    vector<long long> input(n + 1, 0);
    vector<long long> arr(q + 1, 0);
    vector<long long> SegTree(n * 4, INT32_MIN);
    vector<long long> lazy(n * 4, 0);

    for (long long i = 1; i <= n; i++)
    {
        cin >> input[i];
    }
    init(1, 1, n, input, SegTree);
    for (int i = 1; SegTree[i]!=INT32_MIN; i++)
    {
        cout << SegTree[i] << ' ';
    }
    cout << endl;
    
    
    for (long long i = 1; i <= q; i++)
    {
        cin >> arr[i];
        cout << query(1, 1, n, i, SegTree, arr) << endl;
    }
    // for (int i = 1; i <= q; i++)
    // {
    //     cout << arr[i] << ' ';
    // }
    // cout << endl;
    
}

long long query(long long node, long long begin, long long end, long long i, vector<long long> &SegTree, vector<long long> &arr)
{
    if (arr[i] > SegTree[node])
        return 0;
    else if (arr[i] == SegTree[node])
        return i;
    else
    {
        long long left = node * 2;
        long long right = node * 2 + 1;
        long long mid = (begin + end) / 2;
        long long q1 = 0, q2 = 0;
        if (arr[i] <= SegTree[node])
        {
            q1 = query(left, begin, mid, i, SegTree, arr);
        }

        else
            q2 = query(right, mid + 1, end, i, SegTree, arr);
        SegTree[node] = max(q1, q2);
        return q1;
    }
}

void init(long long node, long long begin, long long end, vector<long long> &arr, vector<long long> &SegTree)
{
    if (begin == end)
    {
        SegTree[node] = arr[begin];
        return;
    }
    long long left = node * 2;
    long long right = node * 2 + 1;
    long long mid = (begin + end) / 2;
    init(left, begin, mid, arr, SegTree);
    init(right, mid + 1, end, arr, SegTree);
    SegTree[node] = max(SegTree[left], SegTree[right]);
}

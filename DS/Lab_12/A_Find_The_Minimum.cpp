#include <bits/stdc++.h>
using namespace std;

void init(long long node, long long begin, long long end, vector<long long> &input, vector<long long> &SegTree);
long long query(long long node, long long begin, long long end, long long i, long long j, vector<long long> &SegTree);
void update(long long node, long long begin, long long end, long long i, long long val, vector<long long> &SegTree);

int main()
{
    long long n, q, pos, updatedValue , val , x , y;
    cin >> n >> q;
    vector<long long> input(n + 1, 0);
    vector<long long> SegTree(n*4, INT32_MIN);
    vector<long long> lazy(n*4,0);
    for (long long i = 1; i <= n; i++)
    {
        cin >> input[i];
    }
    init(1, 1, n, input, SegTree);
    for (long long i = 0; i < q; i++)
    {
        long long choice;
        cin >> choice;
        if (choice == 1)
        {
            cin >> pos >> updatedValue;
            
            update(1,1,n,pos,updatedValue-input[pos],SegTree);
            input[pos] = updatedValue;
            
        }
        else if (choice == 2)
        {
            cin >> x >> y;
            cout << query(1,1,n,x,y,SegTree) << endl;

        }
        
        else
            break;
    }
}



long long query(long long node, long long begin, long long end, long long i, long long j, vector<long long> &SegTree)
{
    if (begin > j || end < i)
        return INT32_MIN;
    else if (begin >= i && end <= j)
        return SegTree[node];
    else
    {
        long long left = node * 2;
        long long right = node * 2 + 1;
        long long mid = (begin + end) / 2;
        long long q1 = query(left, begin, mid, i, j, SegTree);
        long long q2 = query(right, mid + 1, end, i, j, SegTree);
        return min(q1,q2);
    }
}


void init(long long node, long long begin, long long end, vector<long long> &input, vector<long long> &SegTree)
{
    if (begin == end)
    {
        SegTree[node] = input[begin];
        return;
    }
    long long left = node * 2;
    long long right = node * 2 + 1;
    long long mid = (begin + end) / 2;
    init(left, begin, mid, input, SegTree);
    init(right, mid + 1, end, input, SegTree);
    SegTree[node] = min(SegTree[left] , SegTree[right]);
}
void update(long long node, long long begin, long long end, long long i, long long val, vector<long long> &SegTree)
{
    if (begin > i || end < i)
        return;

    if (end == i && begin == i)
    {
        SegTree[node] += val;
    }
    else
    {
        long long left = node * 2;
        long long right = node * 2 + 1;
        long long mid = (begin + end) / 2;
        update(left, begin, mid, i, val, SegTree);
        update(right, mid + 1, end, i, val, SegTree);
        SegTree[node] = min(SegTree[left] , SegTree[right]);
    }
}



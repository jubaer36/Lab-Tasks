#include <iostream>
#include <vector>
using namespace std;

void init(int node, int begin, int end, vector<int> &input, vector<int> &SegTree);
int query(int node, int begin, int end, int i, int j, vector<int> &SegTree);
void update(int node, int begin, int end, int i, int val, vector<int> &SegTree);
void printInputArray(int n, vector<int> &input);

int main()
{
    int n, q, x, y;
    cin >> n >> q;
    vector<int> input(n + 1, 0);
    vector<int> SegTree(100, 0);
    for (int i = 1; i <= n; i++)
    {
        cin >> input[i];
    }
    init(1, 1, n, input, SegTree);

    for (int i = 0; i < q; i++)
    {
        int choice;
        cin >> choice;
        if (choice == 1)
        {
            cin >> x;
            cout << input[x] << ' ';
            update(1, 1, n, x, -input[x], SegTree);
            input[x] = 0;
            printInputArray(n, input);
        }
        else if (choice == 2)
        {
            cin >> x >> y;
            update(1, 1, n, x, y, SegTree);
            input[x] += y;
            printInputArray(n, input);
        }
        else if (choice == 3)
        {
            cin >> x >> y;
            cout << query(1, 1, n, x, y, SegTree) << endl;
        }
        else
            break;
    }
}

void printInputArray(int n, vector<int> &input)
{
    cout << "(";
    for (int i = 1; i <= n; i++)
    {
        cout << input[i] << ' ';
    }
    cout << ")";
    cout << endl;
}

int query(int node, int begin, int end, int i, int j, vector<int> &SegTree)
{
    if (begin > j || end < i)
        return 0;
    else if (begin >= i && end <= j)
        return SegTree[node];
    else
    {
        int left = node * 2;
        int right = node * 2 + 1;
        int mid = (begin + end) / 2;
        int q1 = query(left, begin, mid, i, j, SegTree);
        int q2 = query(right, mid + 1, end, i, j, SegTree);
        return q1 + q2;
    }
}

void update(int node, int begin, int end, int i, int val, vector<int> &SegTree)
{
    if (begin > i || end < i)
        return;

    if (end == i && begin == i)
    {
        SegTree[node] += val;
    }
    else
    {
        int left = node * 2;
        int right = node * 2 + 1;
        int mid = (begin + end) / 2;
        update(left, begin, mid, i, val, SegTree);
        update(right, mid + 1, end, i, val, SegTree);
        SegTree[node] = (SegTree[left] + SegTree[right]);
    }
}

void init(int node, int begin, int end, vector<int> &input, vector<int> &SegTree)
{
    if (begin == end)
    {
        SegTree[node] = input[begin];
        return;
    }
    int left = node * 2;
    int right = node * 2 + 1;
    int mid = (begin + end) / 2;
    init(left, begin, mid, input, SegTree);
    init(right, mid + 1, end, input, SegTree);
    SegTree[node] = (SegTree[left] + SegTree[right]);
}
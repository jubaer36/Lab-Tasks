#include <iostream>
#include <vector>
using namespace std;

void init(int node, int begin, int end, vector<int> &input, vector<int> &SegTree);
int query(int node, int begin, int end, int i, int j, vector<int> &SegTree);
void update(int node, int begin, int end, int i, int val, vector<int> &SegTree);
void printInputArray(int n, vector<int> &input);
void lazyUpdate(int node, int begin, int end, int i,int j, int val, vector<int> &SegTree , vector<int>&lazy);
void printSegmentTree(int n, vector<int> &segTree);
void printLazyTree(int n, vector<int> &lazy);

int main()
{
    int n, q, x, y , val;
    cin >> n >> q;
    vector<int> input(n + 1, 0);
    vector<int> SegTree(100, INT32_MIN);
    vector<int> lazy(100,0);
    for (int i = 1; i <= n; i++)
    {
        cin >> input[i];
    }
    init(1, 1, n, input, SegTree);
    printSegmentTree(n,SegTree);
    printLazyTree(n,lazy);
    cout << endl;
    for (int i = 0; i < q; i++)
    {
        int choice;
        cin >> choice;
        if (choice == 2)
        {
            cin >> x >> y >> val;
            lazyUpdate(1, 1, n, x, y,val, SegTree,lazy);
            input[x] += y;
            printSegmentTree(n,SegTree);
            printLazyTree(n,lazy);
            cout << endl;

        }
        else if (choice == 1)
        {
            cin >> x >> y;
            cout << query(1, 1, n, x, y, SegTree) << endl;
            lazyUpdate(1, 1, n, x, y,0, SegTree,lazy);
            printSegmentTree(n,SegTree);
            printLazyTree(n,lazy);
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
void printSegmentTree(int n, vector<int> &segTree)
{
    
    for (int i = 1; i < 2*n; i++)
    {
        cout << segTree[i] << ' ';
    }
    cout << endl;
}
void printLazyTree(int n, vector<int> &lazy)
{
    
    for (int i = 1; i < 2*n; i++)
    {
        cout << lazy[i] << ' ';
    }
    cout << endl;
}

int query(int node, int begin, int end, int i, int j, vector<int> &SegTree)
{
    if (begin > j || end < i)
        return INT32_MIN;
    else if (begin >= i && end <= j)
        return SegTree[node];
    else
    {
        int left = node * 2;
        int right = node * 2 + 1;
        int mid = (begin + end) / 2;
        int q1 = query(left, begin, mid, i, j, SegTree);
        int q2 = query(right, mid + 1, end, i, j, SegTree);
        return min(q1,q2);
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
    SegTree[node] = min(SegTree[left] , SegTree[right]);
}
void lazyUpdate(int node, int begin, int end, int i,int j, int val, vector<int> &SegTree , vector<int>&lazy){
    if (lazy[node] != 0)
    {
        SegTree[node]+=lazy[node];
        if(begin != end)
        {
            lazy[node*2] += lazy[node];
            lazy[node*2 + 1] += lazy[node];
        }
        lazy[node] = 0;
    }
    
    if (begin > j || end < i)
    {
        return;
    }
    if(begin >= i && end <= j){
        SegTree[node] += val;
        if(begin!= end){
            lazy[node*2] += val;
            lazy[node*2 + 1] += val;
        }
        return;
    }
    else{
        int left = node*2;
        int right = node*2+1;
        int mid = (begin+end)/2;
        lazyUpdate(left,begin,mid,i,j,val,SegTree,lazy);
        lazyUpdate(right,mid+1,end,i,j,val,SegTree,lazy);
        SegTree[node] = min(SegTree[left],SegTree[right]);
    }
    
}

#include <iostream>
#include <vector>
using namespace std;

void init(int node , int begin, int end, vector<int>&input, vector<int>&SegTree);
int query(int node , int begin , int end , int i , int j , vector<int>&SegTree);

int main(){
    int n,q , x , y;
    cin >> n >> q;
    vector<int>input(n+1,0);
    vector<int>SegTree(2*n+1,0);
    for (int i = 1; i <= n; i++)
    {
        cin >> input[i];
    }
    init(1,1,n,input,SegTree);
    // for (int i = 1; i < 2*n + 1; i++)
    // {
    //     cout << SegTree[i] << ' ';
    // }
    // cout << endl;
    
    for (int i = 0; i < q; i++)
    {
        cin >> x  >> y;
        // cout << x << y << endl;
        cout << query(1,1,n,x,y,SegTree) << endl;
    }
    

}

int query(int node , int begin , int end , int i , int j , vector<int>&SegTree){
    if(begin > j || end < i)return INT32_MIN;
    else if(begin >= i && end <= j)return SegTree[node] ;
    else{
        int left =  node*2;
        int right = node*2+1;
        int mid = (begin + end )/2;
        int q1 = query(left , begin , mid , i , j , SegTree);
        int q2 = query(right , mid+1 , end , i , j , SegTree);
        return min(q1,q2);

    }

}

void init(int node , int begin, int end, vector<int>&input, vector<int>&SegTree){
    if(begin == end){
        SegTree[node] = input[begin];
        return;
    }
    int left = node*2;
    int right = node*2 + 1;
    int mid = (begin + end)/2;
    init(left , begin , mid, input , SegTree);
    init(right, mid+1 , end, input , SegTree );
    SegTree[node] = min(SegTree[left] , SegTree[right]);

}
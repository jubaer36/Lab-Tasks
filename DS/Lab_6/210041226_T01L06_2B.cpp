#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

void build_max_heap(vector<int>& v, int& n);
void max_heapify(vector<int>& v, int i, int& n);
void heap_sort(vector<int>& v, int& n);

int main()
{
    vector<int> v;
    int val , N;
    while (cin >> val && val != -1)
    {
        v.push_back(val);
    }
    int n = v.size();
    N=n;
    build_max_heap(v,n);
    cout << "Max Heap: ";
    for(int i = 0; i < N ; i++){
        cout << v[i] << ' ';
    }
    cout << endl;
    cout << "Sorted: ";
    heap_sort(v, n);
    reverse(v.begin(),v.end());
    for(int i = 0; i < N ; i++){
        cout << v[i] << ' ';
    }
    //return 0;
}

void build_max_heap(vector<int>& v, int& n)
{
    for (int i = n / 2 - 1; i >= 0; i--)
    {
        max_heapify(v, i, n);
    }
}

void max_heapify(vector<int>& v, int i, int& n)
{
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    int largest = i;
    if (left < n && v[i] < v[left])
    {
        largest = left;
    }
    if (right < n && v[largest] < v[right])
    {
        largest = right;
    }
    if (largest != i)
    {
        swap(v[i], v[largest]);
        max_heapify(v, largest, n);
    }
}

void heap_sort(vector<int>& v, int& n)
{
    build_max_heap(v, n);
    for (int i = n - 1; i > 0; i--)
    {
        swap(v[0], v[i]);
        n--;
        max_heapify(v, 0, n);
    }
}
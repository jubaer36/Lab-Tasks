#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

void build_min_heap(vector<int> &v, int &n);
void min_heapify(vector<int> &v, int i, int &n);
int heap_minimum(vector<int> &v);
int heap_extract_min(vector<int> &v, int &n);
int heap_insert_min(vector<int> &v, int val, int &n);
void decrease_key_min(vector<int> &v, int p, int k);
void increase_key_min(vector<int> &v, int p, int k, int &n);

int main()
{
    vector<int> v;
    int val, n;
    while (cin >> val && val != -1)
    {
        v.push_back(val);
    }
    n = v.size();
    build_min_heap(v, n);
    cout << "Min Heap: ";
    for (int i = 0; i < n; i++)
    {
        cout << v[i] << ' ';
    }
    cout << endl;
    while (cin >> val)
    {
        if (val == 1)
        {
            cout << "Min: " << heap_minimum(v) << endl;
            for (int i = 0; i < n; i++)
            {
                cout << v[i] << ' ';
            }
            cout << endl;
        }
        else if (val == 2)
        {
            cout << "Extracting: " << heap_extract_min(v, n) << endl;
            for (int i = 0; i < n; i++)
            {
                cout << v[i] << ' ';
            }
            cout << endl;
        }
        else if (val == 3)
        {
            int x;
            cin >> x;
            cout << "Inserting " << heap_insert_min(v, x, n) << endl;
            for (int i = 0; i < n; i++)
            {
                cout << v[i] << ' ';
            }
            cout << endl;
        }
        else if (val == 4)
        {
            int pos, key;
            cin >> pos >> key;
            cout << "Increasing Key at " << pos;
            increase_key_min(v, pos, key, n);
            cout << endl;
            for (int i = 0; i < n; i++)
            {
                cout << v[i] << ' ';
            }
            cout << endl;
        }
        else if (val == 5)
        {
            int pos, key;
            cin >> pos >> key;
            cout << "Decreasing Key at " << pos;
            decrease_key_min(v, pos, key);
            cout << endl;
            for (int i = 0; i < n; i++)
            {
                cout << v[i] << ' ';
            }
            cout << endl;
        }
        else if (val > 5)
            break;
    }
    return 0;
}

void build_min_heap(vector<int> &v, int &n)
{
    for (int i = n / 2 - 1; i >= 0; i--)
    {
        min_heapify(v, i, n);
    }
}

void min_heapify(vector<int> &v, int i, int &n)
{
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    int smallest = i;
    if (left < n && v[i] > v[left])
    {
        smallest = left;
    }
    if (right < n && v[smallest] > v[right])
    {
        smallest = right;
    }
    if (smallest != i)
    {
        swap(v[i], v[smallest]);
        min_heapify(v, smallest, n);
    }
}

int heap_minimum(vector<int> &v)
{
    if (v.size() > 0)
        return v[0];
    return 0;
}

int heap_extract_min(vector<int> &v, int &n)
{
    int temp = v[0];
    swap(v[n - 1], v[0]);
    n--;
    min_heapify(v, 0, n);
    return temp;
}

int heap_insert_min(vector<int> &v, int val, int &n)
{
    n++;
    v[n - 1] = val;
    int i = n - 1;
    while (i > 0 && v[i] < v[i / 2])
    {
        swap(v[i], v[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
    min_heapify(v, i, n);
    return val;
}

void decrease_key_min(vector<int> &v, int p, int k)
{
    int i = p - 1;
    v[i] += k;
    while (i > 0 && v[i] < v[(i - 1) / 2])
    {
        swap(v[i], v[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

void increase_key_min(vector<int> &v, int p, int k, int &n)
{
    int i = p - 1;
    v[i] -= k;
    min_heapify(v, i, n);
}

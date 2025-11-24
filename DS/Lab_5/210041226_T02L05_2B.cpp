#include <iostream>
#include <deque>
#include <vector>

using namespace std;

int main()
{
    int t;
    cin >> t;
    while (t--)
    {
        int n, k, val;
        cin >> n >> k;
        vector<int> v;
        deque<int> d;
        
        for (int i = 0; i < n; i++)
        {
            cin >> val;
            v.push_back(val);
        }
        
        for (int i = 0; i < k; i++)
        {
            while (!d.empty() && v[i] >= v[d.back()])
            {
                d.pop_back();
            }
            d.push_back(i);
        }
        
        for (int i = k; i < n; i++)
        {   
            cout << v[d.front()] << ' ';

            if (!d.empty() && d.front() <= i - k)
            {
                d.pop_front();
            }

            while (!d.empty() && v[i] >= v[d.back()])
            {
                d.pop_back();
            }
            d.push_back(i);
            
        }
        cout << v[d.front()]<<endl;
    }
    return 0;
}
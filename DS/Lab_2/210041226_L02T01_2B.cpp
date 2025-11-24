#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int binarySearch(vector<int> &v, int target)
{
    int left = 0;
    int right = v.size() - 1;
    while (right >= left)
    {
        int mid = (left + right) / 2;
        if (v[mid] <= target)
        {
            left = mid + 1;
        }
        else
        {
            right = mid - 1;
        }
    }
    return left;
}

int main()
{
    int n, r;
    cin >> n >> r;

    vector<int> v(n);
    for (int i = 0; i < n; i++)
    {
        cin >> v[i];
    }

    sort(v.begin(), v.end());

    for (int i = 0; i < r; i++)
    {
        int power;
        cin >> power;

        int res = binarySearch(v, power);
        cout << res << endl;
    }

    return 0;
}

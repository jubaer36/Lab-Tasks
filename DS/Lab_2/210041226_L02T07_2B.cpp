#include <iostream>
#include <vector>
#include <utility>
#include <algorithm>

using namespace std;
string binarySearch(vector<pair<int, string>> &vp, int val, int len);
int main()
{
    int n, q, num, val;
    cin >> n >> q;
    vector<pair<int, string>> vp(n);
    string grade;
    for (int i = 0; i < n; i++)
    {
        cin >> num;
        cin >> grade;
        vp[i].first = num;
        vp[i].second = grade;
    }
    for (int i = 0; i < q; i++)
    {
        cin >> val;
        string result = binarySearch(vp, val, n);
        if(result.empty())result = "F";
        cout << result << endl;
    }
}

string binarySearch(vector<pair<int, string>> &vp, int val, int len)
{   
    // cout << "Val: " << val << endl;
    int left = 0;
    int right = len - 1;
    while (right >= left)
    {
        int mid = (right + left) / 2;
        if (vp[mid].first == val)
            return vp[mid].second;
        else if (vp[mid].first < val)
            left = mid + 1;
        else if (vp[mid].first > val)
            right = mid - 1;
    }
    return vp[right].second;
}
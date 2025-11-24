#include <iostream>
#include <stack>
#include <deque>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{

    int n;
    while (cin >> n && n)
    {
        deque<int> d;
        for (int i = 1; i <= n; i++)
        {
            d.push_back(i);
        }
        cout << "Discarded cards: ";
        for (int i = 1; i < n - 1; i++)
        {
            cout << d.front() << ", ";
            d.pop_front();
            d.push_back(d.front());
            d.pop_front();
        }
        cout << d.front() << endl;
        d.pop_front();
        d.push_back(d.front());
        d.pop_front();

        cout << "Remaining card: " << d.front() << endl;
    }

    return 0;
}
#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{

    int val, count, n = 0;
    priority_queue<int> p;
    while (1)
    {

        cin >> val;
        if (val < 0)
            break;
        p.push(val);
        n++;
        priority_queue<int> temp(p);
        count = 0;
        while (count < (n / 2 - 1))
        {
            temp.pop();
            count++;
        }
        if (n % 2)
        {
            printf("%.1f", (double)temp.top());
            cout << endl;
        }
        else
        {
            double x = temp.top();
            temp.pop();
            printf("%.1lf", ((x + temp.top()) / 2));
            cout << endl;
        }
    }

    return 0;
}
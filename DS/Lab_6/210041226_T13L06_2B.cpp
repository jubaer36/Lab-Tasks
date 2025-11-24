#include <iostream>
#include <queue>
#include <stdio.h>
using namespace std;

int main()
{

    priority_queue<int> p;

    long long n, val, count = 0;
    cin >> n;
    for (long long i = 0; i < n; i++)
    {
        cin >> val;
        p.push(val);
    }
    while (count < (n / 2 - 1))
    {
        p.pop();
        count++;
    }
    if (n % 2)
    {
        printf("%.1f",(double)p.top());
        cout << endl;
    }
    else
    {
        double x = p.top();
        p.pop();
        printf("%.1lf",((x+p.top())/2));
        cout << endl;
    }

    return 0;
}
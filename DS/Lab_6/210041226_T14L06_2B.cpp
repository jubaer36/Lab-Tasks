#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>
using namespace std;

int main()
{

    int n , val;

    cin >> n;
    priority_queue<int>p;
    for (int i = 0; i < n; i++)
    {
        cin >> val;
        p.push(val);
        if(p.size()>2){
            int y , z ,x = p.top();
            p.pop();
            y=p.top();p.pop();
            z=p.top();p.pop();
            cout << x*y*z << endl;
            p.push(x);
            p.push(y);
            p.push(z);


            
        }
        else cout << -1 << endl;
    }

    return 0;
}
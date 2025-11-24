#include <iostream>
#include <queue>

using namespace std;

int main(){
    int n , val , rem;
    cin >> n;
    rem = n;
    queue<int>s,f;

    for (int i = 0; i < n; i++)
    {
        cin >> val;
        s.push(val);

    }
    for (int i = 0; i < n; i++)
    {
        cin >> val;
        f.push(val);

    }
    for (int i = 0; i < 2*n; i++)
    {   
        if(s.front() == f.front()){
            s.pop();
            f.pop();
            rem--;
        }
        else{
            s.push(s.front());
            s.pop();
        }
    }
    if(rem<0)rem = 0;
    cout << rem << endl;
    
    
}
    
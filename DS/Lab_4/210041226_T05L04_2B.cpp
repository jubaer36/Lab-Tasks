#include<iostream>
#include<queue>

using namespace std;

int main(){
    int val = 0 ,k,n = 0 ,count = 0;
    queue<pair<int,int>>q;
    cin >> val;
    while (val!=-1)
    {   
        q.push(make_pair(val,n));
        n++;
        cin >> val;   
    }
    cin >> k;
    while (1)
    {
        pair<int ,int>temp;
        temp = q.front();
        q.pop();
        // cout << temp.first << ' ' << temp.second << endl;
        temp.first--;
        count++;
        if (temp.first <= 0)
        {   
           if (temp.second == k)break;

        }
        else q.push(temp);
        
        
    }
    cout << count << endl;
    
    
}
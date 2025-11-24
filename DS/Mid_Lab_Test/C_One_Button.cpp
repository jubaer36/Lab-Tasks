#include<bits/stdc++.h>


using namespace std;
int main(){
    string str;
    cin >> str;
    deque<char>dq;
    int count = 0;
    for (int i = 0; i < str.size(); i++)
    {
        if(str[i]=='<' && !dq.empty()){
            dq.pop_back();
            count--;
        }
        else{
            dq.push_back(str[i]);
            count++;
        }
    }
    for (int i = 0; i < count; i++)
    {
        cout << dq.front();
        dq.pop_front();
    }
    
    
}
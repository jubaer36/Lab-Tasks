#include <iostream>
#include <algorithm>
#include <vector>
#include <unordered_map>
using namespace std;
int main(){
    unordered_map<int , int >m , m2;
    vector<int>v;
    int val , req_sum;
    bool found = false;
    while (cin >> val && val != -1)
    {
        m[val]++;
        v.push_back(val);
    }
    cin >> req_sum;
    for(auto it:v){
        if(m.count(req_sum - it) >0){
            m2[min(it,req_sum-it)] = max(it,req_sum-it);
            // cout << '(' << it << ',' << req_sum - it << "), ";
            found = true;
        }
        
    }
    if(!found){
        cout << "No pairs found" << endl;
    }
    else{
        for(auto i: m2){
            cout << "("<<i.first << "," << i.second <<") ";
    
        }
    }
}
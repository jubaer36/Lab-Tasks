#include<iostream>
#include<vector>

using namespace std;

int main(){
    int val = 1 , max_val = 0;
    vector<int>v;
    while(1){
        cin >> val;
        if(val == -1)break;
        max_val = max(val,max_val);
        v.push_back(val);
    }

    float arr[max_val+1] , x;
    for(int i = 1 ; i <= max_val ; i++){
        cin >> x;
        arr[v[i-1]] = x;
    }
    
 
    for(int i = 1; i <= max_val ; i++){
        cout << arr[i] <<' ';
    }
    cout << endl;
}
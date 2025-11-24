#include<iostream>
#include<vector>
#include<algorithm>


using namespace std;

int main(){
    int len, n;
    cin >> len >> n;
    vector<pair<int, string>> v;
    for(int i=0; i<n; i++){
        string dna;
        int unsortedness = 0;
        cin >> dna;
        for(int i=0; i<len; i++){
            for(int j=i+1; j<len; j++){
                if(dna[i] > dna[j]) unsortedness++;
            }
        }
        v.push_back(make_pair(unsortedness, dna));
    }
    sort(v.begin(), v.end());
    for(auto x: v){
        cout << x.second <<" "<< x.first << endl;
    }
}
#include <bits/stdc++.h>
using namespace std;

int main(){
    string str;
    bool alreadyFound = false;
    deque<char>d;
    for (int i = 0; i < str.size(); i++)
    {   
        if(str[i]!= str.back()){
            d.push_back(str[i]);
        }
        else if(str[i] == str.back() && !alreadyFound){
            alreadyFound = true;
        }
    }
    
}
#include <iostream>
#include <algorithm>
#include <vector>
#include <unordered_map>
#include <sstream>
using namespace std;
int main()
{
    unordered_map<string, string> m;
    string line;
    while (getline(cin, line) && !line.empty())
    {
        istringstream iss(line);
        string word, meaning;
        iss >> meaning >> word;
        m[word] = meaning; 
        
    }
    // for (auto it : m)
    // { 
    //     cout << it.first << ' ' << it.second << endl;
    // }
    string word;
    while (getline(cin , word) && word!="")
    {
        if(m.count(word)){
            cout << m[word] << endl;
        }
        else cout << "eh" << endl;
    }
    
    
}
#include <iostream>
#include <algorithm>
#include <vector>
#include <unordered_map>
#include <sstream>
#include <cctype>
using namespace std;
int main()
{
    unordered_map<string, int> m;
    string line;
    while (getline(cin, line) && !line.empty())
    {
        istringstream iss(line);
        string word, actual_word;
        while (iss >> word)
        {   
            actual_word = "";
            for (char c : word)
            {
                if (isalpha(c))
                {
                    actual_word += c;
                }
            }
            if(actual_word != ""){
                m[actual_word]++;
            }
        }
    }
    for (auto it : m)
    {
        if(it.second > 1)
        cout << it.first << ' ' << it.second << endl;
    }
}
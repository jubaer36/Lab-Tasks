#include <bits/stdc++.h>
using namespace std;
long long power(long long base , long long exponent);
int main()
{
    string str, pattern;
    int a = 's';
    int b = 'p';
    const long long base = 26;
    cin >> str >> pattern;
    long long patternHash = 0, substrHash = 0, count = 0;
    for (long long i = 0; i < pattern.size(); i++)
    {
        patternHash += (pattern[i] * power(base, pattern.size() - i - 1));
    }
    // cout << patternHash << endl;

    for (long long i = 0; i < pattern.size(); i++)
    {
        substrHash += (str[i] * power(base, pattern.size() - i - 1));
    }
    // cout << substrHash << endl;
    if (substrHash == patternHash)
    {
        count++;
    }
    for (long long i = pattern.size(); i < str.size(); i++)
    {
        substrHash = substrHash - str[i - pattern.length()] * power(base, pattern.length() - 1);
        substrHash *= base;
        substrHash += str[i];
        if (substrHash == patternHash)
        {
            count++;
        }
        // cout << substrHash <<endl;
    }
    cout << count << endl;
}

long long power(long long base , long long exponent){
    long long result = (pow(base,exponent));
    // result = result%19734581;
    return result;

}
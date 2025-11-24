#include <iostream>
#include <string>

using namespace std;

int main()
{
    string str;
    getline(cin, str);
    int sz, i, j, val, max_val = 0;
    cin >> sz;
    int arr[sz] = {0};
    for (i = 0, j = 0; i < str.length(); i++)
    {
        if (str[i] >= '0' && str[i] <= '9')
        {
            val = str[i] - '0';
            arr[val - 1]++;
            max_val = max(val, max_val);
        }
    }

    for (int i = 0; i < max_val; i++)
    {
        if (arr[i])
        {
            cout << "Push"
                 << " ";
        }
        else
            cout << "Push Pop" << ' ';
    }
}

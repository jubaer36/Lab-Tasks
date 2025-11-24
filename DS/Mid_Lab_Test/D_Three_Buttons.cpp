#include <iostream>
#include <deque>
#include <string>

using namespace std;

int main()
{
    int t;
    cin >> t;
    cin.ignore();
    while (t--)
    {
        string ln;
        deque<char> d;
        getline(cin, ln);
        auto it = d.begin();

        for (int i = 0; i < ln.size(); i++)
        {
            if (ln[i] == '[')
            {
                it = d.begin();
            }
            else if (ln[i] == ']')
            {
                it = d.end();
            }
            else if (ln[i] == '<')
            {
                if (it != d.begin())
                {
                    it--;
                    it = d.erase(it);
                }
            }
            else
            {

                it = d.insert(it, ln[i]);
                it++;
            }
        }

        while (!d.empty())
        {
            cout << d.front();
            d.pop_front();
        }
        cout << endl;
    }

    return 0;
}
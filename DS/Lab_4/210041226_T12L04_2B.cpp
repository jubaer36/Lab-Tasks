#include <iostream>
#include <deque>
#include <string>

using namespace std;

int main()
{

    string ln;
    deque<char> d;
    while ((getline(cin, ln) && ln != ""))
    {
        bool front = false;
        auto it = d.begin();
        for (int i = 0; i < ln.size(); i++)
        {
            if (ln[i] == '[')
            {
                front = true;
                it = d.begin();
                
            }
            else if (ln[i] == ']')
            {
                front = false;
            }
            else
            {
                if (front)
                {   
                    it = d.insert(it,ln[i]);
                    it++;
                }
                else{
                    d.push_back(ln[i]);
                }
                    
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
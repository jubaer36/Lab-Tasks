#include <iostream>
#include <cmath>
#include <vector>
using namespace std;
class HashMap
{
public:
    int t_sz;
    int max_attempt;
    int elements_count;
    vector<int> table;
    HashMap(int sz) : t_sz(sz), max_attempt(6), elements_count(0) { table.assign(sz, -1); }
    int linearProbing(int key)
    {
        int idx = key % t_sz;
        int attempt = 1 , i = 1;
        while (1)
        {
            if (attempt > max_attempt)
            {
                cout << "Input Abandoned" << endl;
                return -1;
            }
            if (table[idx] == -1)
                break;
            cout << "Collision: Index-" << idx << endl;
            idx = (key + i) % t_sz;
            attempt++;
            i++;
        }
        return idx;
    }
    int quadraticProbing(int key)
    {
        int idx = key % t_sz;
        int attempt = 1 , i  = 1;
        while (1)
        {
            if (attempt > max_attempt)
            {
                cout << "Input Abandoned" << endl;
                return -1;
            }
            if (table[idx] == -1)
                break;

            cout << "Collision: Index-" << idx << endl;
            idx = (key + i * i) % t_sz;
            attempt++;
            i++;
        }
        return idx;
    }
    int doubleHashing(int key){
        int idx = key%t_sz;
        int secondHash = t_sz - (key%t_sz);
        int attempt = 1 , i = 1;
        while (1)
        {
            if(attempt > max_attempt){
                cout << "Input Abandoned" << endl;
                return -1;
            }
            if(table[idx] == -1)break;
            cout << "Collision: Index-" << idx << endl;
            idx = (key + secondHash*i)%t_sz;
            attempt++;
            i++;
        }
        return idx;
        
    }
    void insert(int val, int option)
    {
        float load_factor;
        if (option == 1)
        {
            int index = linearProbing(val);
            if (index != -1)
            {   
                // cout << "liner";
                elements_count++;
                table[index] = val;
                load_factor= (float)elements_count / (float)t_sz;
                cout << "Inserted : Index-" << index<<"(L-F=" << load_factor << ')' << endl; 
            }
        }
        else if (option == 2)
        {
            int index = quadraticProbing(val);
            if (index != -1)
            {
                elements_count++;
                table[index] = val;
                load_factor= (float)elements_count / (float)t_sz;
                cout << "Inserted : Index-" << index<<"(L-F=" << load_factor << ')' << endl;
            }
        }
        else if (option == 3)
        {
            int index = doubleHashing(val);
            if (index != -1)
            {
                elements_count++;
                table[index] = val;
                load_factor= (float)elements_count / (float)t_sz;
                cout << "Inserted : Index-" << index<<"(L-F=" << load_factor << ')' << endl;
            }
        }

        
    }
};

int main()
{
    int optn, n, q , val;
    cin >> optn >> n >> q;
    HashMap m(n);
    for (int i = 0; i < q; i++)
    {   
        cin >> val;
        m.insert(val,optn);
        // cout << val << endl;
    }
    
}
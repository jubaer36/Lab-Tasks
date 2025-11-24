#include <iostream>
#include <stack>

using namespace std;

void enqueue(stack<int> &stk1, stack<int> &stk2,stack<int>&tempStk, int x, int &sz , int max_sz);
void dequeue(stack<int> &stk1, stack<int> &stk2,stack<int>&tempStk ,int &sz);

int main()
{
    stack<int> stk1, stk2, tempStk;
    int t, val,max_sz, x, sz = 0;
    cin >> max_sz >> t;
    while (t--)
    {
        cin >> val;
        if (val == 1)
        {
            cin >> x;
            enqueue(stk1, stk2,tempStk, x, sz,max_sz);
        }
        else if (val == 2)
        {
            dequeue(stk1, stk2,tempStk, sz );
        }
    }
}

void enqueue(stack<int> &stk1, stack<int> &stk2,stack<int> &tempStk, int x, int &sz, int max_sz)
{



    cout << "Size: ";
    sz++;
    if(sz > max_sz){
            sz--;
        cout << sz << " Elements: ";
        cout << "Overflow"<<endl;
        return;
    }
    cout << sz << " Elements: ";
    stk2 ={};
    stk1.push(x);
    while (!stk1.empty())
    {
        tempStk.push(stk1.top());
        stk2.push(stk1.top());
        stk1.pop();
    }
    while(!tempStk.empty()){
        stk1.push(tempStk.top());
        cout << tempStk.top() <<' ';
        tempStk.pop();
    }

    cout << endl;
}






void dequeue(stack<int> &stk1, stack<int> &stk2,stack<int>&tempStk ,int &sz)
{
    sz--;
    cout << "Size: " << sz <<" Elements: ";
    stk2.pop();
    stk1={};
    if(stk2.empty())cout << "Null";
    else{
        while(!stk2.empty()){
            stk1.push(stk2.top());
            cout << stk2.top() << ' ';
            stk2.pop();

        }
    }
    cout << endl;
}

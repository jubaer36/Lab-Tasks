#include <iostream>
using namespace std;

int front = 0, rear = 0, sz = 0, max_sz = 10;
int deq[10];

bool isEmpty();
bool isFull();
bool pushFront(int x);
bool popFront();
bool pushBack(int x);
bool popBack();
void printdeq();

int main()
{
    int val, x;
    while (cin >> val && val != 6)
    {
        switch (val)
        {
        case 1:
            cin >> x;
            cout << "Push Front: ";
            if (!pushFront(x))
                cout << "Overflow" << endl;
            else
                printdeq();
            break;
        case 2:
            cin >> x;
            cout << "Push Back: ";

            if (!pushBack(x))
                cout << "Overflow" << endl;
            else
                printdeq();
            break;
        case 3:
            cout << "Pop Front: ";
            if (!popFront())
                cout << "Underflow" << endl;
            else
            {
                printdeq();
            }
            cout << endl;
            break;
        case 4:
            cout << "Pop Back: ";
            if (!popBack())
                cout << "Underflow" << endl;
            else
            {
                printdeq();
            }
            cout << endl;
            break;
        case 5:
            cout << "Size: " << sz << endl;
            break;
        case 6:
            break;
        }
    }

    return 0;
}

bool isEmpty()
{
    return sz == 0;
}

bool isFull()
{
    return sz == max_sz;
}

bool pushFront(int x)
{
    if (isFull())
        return false;
    front = (front - 1 + max_sz) % max_sz;
    deq[front] = x;
    sz++;
    return true;
}

bool popFront()
{
    if (isEmpty())
        return false;
    front = (front + 1) % max_sz;
    sz--;
    return true;
}

bool popBack()
{
    if (isEmpty())
        return false;
    rear = (rear - 1 + max_sz) % max_sz;
    sz--;
    return true;
}

bool pushBack(int x)
{
    if (isFull())
        return false;
    deq[rear] = x;
    rear = (rear + 1) % max_sz;
    sz++;
    return true;
}

void printdeq()
{
    int i = front;
    int count = 0;
    while (count < sz)
    {
        cout << deq[i] << ' ';
        i = (i + 1) % max_sz;
        count++;
    }
    cout << endl;
}

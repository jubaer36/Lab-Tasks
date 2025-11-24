#include <iostream>
using namespace std;

int front = 0, rear = 0, sz = 0, max_size;

bool isEmpty(int *queue);
bool isFull(int *queue);
bool circularEnq(int *queue, int x);
bool circularDeq(int *queue);
void printQueue(int *queue);

int main()
{
    int val = 3, x;
    cin >> max_size;
    int queue[max_size];
    while (val != -1)
    {
        cin >> val;
        switch (val)
        {
        case 1:
            cin >> x;
            cout << "EnQueue: ";
            if (!circularEnq(queue, x))
                cout << "Overflow" << endl;
            else
                printQueue(queue);
            break;
        case 2:
            cout << "DeQueue: ";
            if (!circularDeq(queue))
                cout << "Underflow" << endl;
            else
                printQueue(queue);
            break;
        case 3:
            cout << "isEmpty: ";
            if (isEmpty(queue))
                cout << "True";
            else
                cout << "False";
            cout << endl;
            break;
        case 4:
            cout << "isFull: ";
            if (isFull(queue))
                cout << "True";
            else
                cout << "False";
            cout << endl;
            break;
        case 5:
            cout << "Size: " << sz << endl;
            break;
        case 6:
            cout << "Front: " << queue[front] << endl;
            break;
        case -1:
            cout << "Exit" << endl;
            break;
        }
    }
    return 0;
}

bool isEmpty(int *queue)
{
    if (sz == 0)
        return true;
    return false;
}

bool isFull(int *queue)
{
    if (sz == max_size)
        return true;
    return false;
}

bool circularEnq(int *queue, int x)
{
    if (isFull(queue))
        return false;

    queue[rear] = x;
    rear = (rear + 1) % max_size;
    sz++;
    return true;
}

bool circularDeq(int *queue)
{
    if (isEmpty(queue))
        return false;
    front = (front + 1) % max_size;
    sz--;
    return true;
}

void printQueue(int *queue)
{
    for (int i = 0; i < sz; i++)
    {
        cout << queue[(front + i) % max_size] << ' ';
    }
    cout << endl;
}

#include <iostream>
using namespace std;

int top = -1;

int push(int stack[] , int val , int size);
int pop(int stack[]);
bool isFull(int size);
bool isEmpty();
int Top(int stack[]);
int size();
void printStack(int stack[]);

int main(){
    int length , a , b;
    cin >> length;
    int stack[length];
    while (1)
    {
        cin >> a;
        if(a==1){
            cin >> b;
            if(push(stack , b , length)){   //If pushed print the stack
                printStack(stack);
            }
            else cout << "Overflow" << endl;
        }
        else if(a==2){
            int popped = pop(stack);
            if (popped == -1)
            {
                cout << "Underflow" << endl;
            }
            else {
                printStack(stack);
            }
            
            
        }
        else if(a==3){
            if (isEmpty())
            {
                cout << "True" << endl;
            }
            else cout << "False" << endl;
            
        }
        else if(a==4){
            if (isFull(length))
            {
                cout << "True" << endl;
            }
            else cout << "False" << endl;
            
        }
        else if (a==5)
        {
            cout << size() << endl;
            // printStack(stack);
        }
        else if(a==6){
            if (top==-1)
            {
                cout << "Underflow" << endl;
            }
            else cout << Top(stack) << endl;
            
        }
        else if(a==-1)break;
        

    }
    
}


int push(int stack[] , int val , int size){
    if (top == size - 1)
    {
        return 0;               // return 0 when  overflow
    }
    top++;
    stack[top] = val;
    return 1;                   //return 1 when pushed
    
}

int pop(int stack[]){
    if (top==-1)
    {
        return -1 ;               // return -1 when underflow
    }
    return stack[top--];
    
}

bool isEmpty(){
    if (top == -1)
    {
        return true;
    }
    return false;
    
}

bool isFull(int size){
    if (top == size -1)
    {
        return true;
    }
    return false;
    
}

int size(){
    return top+1; 
}

int Top(int stack[]){
    return stack[top];
}
void printStack(int stack[]){
    for (int i = 0; i <= top; i++)
    {
        cout << stack[i] << ' ';
    }
    cout << endl;
    
}




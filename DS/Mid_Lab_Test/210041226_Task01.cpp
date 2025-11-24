#include <bits/stdc++.h>
using namespace std;

class Node
{
public:
    int data;
    Node *left;
    Node *right;
    Node *parent;
    Node(int data = 0)
    {
        left = nullptr;
        right = nullptr;
        parent = nullptr;
        this->data = data;
    }
};

class Tree
{
public:
    Tree()
    {
        root = nullptr;
    }
    Node *root;
    void insert(int data)
    {
        Node *newNode = new Node(data);
        Node *temp = root;
        Node *target = nullptr;
        if (root == nullptr)
        {
            root = newNode;
            return;
        }

        while (temp != nullptr)
        {
            target = temp;
            if (temp->data > data)
                temp = temp->left;
            else
                temp = temp->right;
        }
        newNode->parent = target;

        if (data < target->data)
            target->left = newNode;
        else
            target->right = newNode;
    }
    void even_order_traversal(Node *temp)
    {
        if (temp == nullptr)
            return;
        even_order_traversal(temp->right);

        even_order_traversal(temp->left);
        cout << temp->data << endl;
    }
};

int main()
{
    int n, val;
    cin >> n;
    Tree t;
    stack<int> stk;
    for (int i = 0; i < n; i++)
    {
        cin >> val;

        stk.push(val);
    }
    for (int i = 0; i < n; i++)
    {
        val = stk.top();
        t.insert(val);
        stk.pop();
    }
    t.even_order_traversal(t.root);
}
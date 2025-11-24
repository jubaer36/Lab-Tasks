#include <iostream>
#include <vector>
using namespace std;

class Node
{
public:
    int data;
    Node *left;
    Node *right;
    Node *parent;
    int height;
    Node(int val) : data(val), left(nullptr), right(nullptr), parent(nullptr),height(0) {}
};

class BinaryTree
{
public:
    Node *root;
    BinaryTree() : root(nullptr) {}
    void insert(int data);
    Node *search(int data, Node *start);
    int find_height(Node *parent);
    void print(Node *start);
    void update_height(Node * start);
};

int BinaryTree::find_height(Node *parent)
{
    if (parent == nullptr)
        return -1;
    return parent->height;
}

Node *BinaryTree::search(int data, Node *start)
{
    while (start != nullptr)
    {
        if (start->data == data)
            return start;
        if (start->data > data)
        {
            start = start->left;
        }
        else
            start = start->right;
    }
    return start;
}

void BinaryTree::insert(int data)
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
    

  
    
    while (target != nullptr)
    {
        int leftHeight = (target->left) ? target->left->height : 0;
        int rightHeight = (target->right) ? target->right->height : 0;
        target->height = 1 + max(leftHeight, rightHeight);
        target = target->parent;
    }
}

void BinaryTree::print(Node *start)
{
    if (start == nullptr)
        return;
    print(start->left);
    cout << start->data << ' ';
    print(start->right);
}

int main()
{
    BinaryTree bt;
    int n, val, cmd;
    
    while (cin >> cmd && cmd < 5)
    {
        if (cmd == 1)           // Take 1 as the input command to insert new values 
        {
            cin >> n;
            for (int i = 0; i < n; i++)
            {
                cin >> val;
                bt.insert(val);
            }
            bt.print(bt.root);
            cout << endl;
        }
        else if (cmd == 3)
        {
            cin >> val;
            Node *temp = bt.search(val, bt.root);
            if (temp)
            {
                cout << "Present" << endl;
                cout << "Parent(";
                if(temp->parent){
                    cout << temp->parent->data <<"), ";
                }
                else cout << "null), "<< endl;
                cout << "Left(";
                if (temp->left)
                    cout << temp->left->data << ")";
                else
                    cout << "null), ";
                cout << "Right(";
                if (temp->right)
                    cout << temp->right->data << ") " << endl;
                else
                    cout << "null)" << endl;
            }
            else cout << "Not Present" << endl;
        }
        else if (cmd == 4)
        {   
            cin >> val;
            cout << "Height: " << bt.find_height(bt.search(val , bt.root)) << endl;
        }
        else
            break;
    }
}
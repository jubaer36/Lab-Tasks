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
    Node(int val) : data(val), left(nullptr), right(nullptr), parent(nullptr), height(0) {}
};

class BinaryTree
{
public:
    Node *root;
    BinaryTree() : root(nullptr) {}
    void insert(int data , Node* start);
    void print(Node *start);
    Node *search(int data, Node *start);
    int update_height(Node* target);
    int balance_factor(Node* target);
    void iterative_insert(int data);
    
};
int BinaryTree::balance_factor(Node* target){
    int leftHeight = (target->left)?target->left->height:-1;
    int rightHeight = (target->right)?target->right->height:-1;
    return leftHeight - rightHeight;
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
void BinaryTree::iterative_insert(int data)
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
    update_height(root);
}


void BinaryTree::insert(int data, Node* start)
{
    if (start == nullptr)
    {
        Node* newNode = new Node(data);
        if (root == nullptr)
        {
            root = newNode;
            return;
        }
        else if (data < start->parent->data)
        {
            start->parent->left = newNode;
            newNode->parent = start->parent; 
        }
        else
        {
            start->parent->right = newNode;
            newNode->parent = start->parent;
        }
        update_height(root);
        

    }
    else if (data > start->data)
    {
        if (start->right == nullptr)
        {
            Node* newNode = new Node(data);
            start->right = newNode;
            newNode->parent = start; 
            
        }
        else
        {
            insert(data, start->right);
        }
    }
    else
    {
        if (start->left == nullptr)
        {
            Node* newNode = new Node(data);
            start->left = newNode;
            newNode->parent = start;
        }
        else
        {
            insert(data, start->left);
        }
    }
}

int BinaryTree::update_height(Node* target) {
    if (target == nullptr) {
        return -1;
    }
    int leftHeight = update_height(target->left);
    int rightHeight = update_height(target->right);
    target->height = 1 + max(leftHeight, rightHeight);
    return target->height;
}

void BinaryTree::print(Node *start)
{
    if (start == nullptr)
        return;
    print(start->left);
    cout << start->data <<"(" << balance_factor(start)<<")" << " ";
    print(start->right);
}

int main()
{
    BinaryTree bt;
    int n, val;
    while (cin >> val && val !=-1)
    {
        bt.iterative_insert(val);
        bt.print(bt.root);
        cout << endl;
    }
    
    
    
    
    

    
    cout << endl;
}
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
    void print(Node *start);
    Node *search(int data, Node *start);
    int update_height(Node *target);
    int balance_factor(Node *target);
    Node *iterative_insert(int data);
    void balance_node(Node *imbalancedNode, int bf, Node *newNode);
    void left_rotate(Node *y);
    void right_rotate(Node *y);
};
int BinaryTree::balance_factor(Node *target)
{
    int leftHeight = (target->left) ? target->left->height : -1;
    int rightHeight = (target->right) ? target->right->height : -1;
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
Node *BinaryTree::iterative_insert(int data)
{
    Node *newNode = new Node(data);
    Node *temp = root;
    Node *target = nullptr;
    if (root == nullptr)
    {
        root = newNode;
        return newNode;
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
        update_height(target);
        target = target->parent;
    }
    return newNode;
}
void BinaryTree::left_rotate(Node *y)
{
    Node *x = y->right;
    Node *t1 = x->left;
    if (y == root)
    {
        root = x;
    }
    else
    {
        if (y == y->parent->left)
        {
            y->parent->left = x;
        }
        else
            y->parent->right = x;
    }
    x->left = y;
    x->parent = y->parent;
    y->right = t1;
    if (t1 != nullptr)
        t1->parent = y;
    y->parent = x;
    Node *temp = y;
    while (temp != nullptr)
    {
        update_height(temp);
        temp = temp->parent;
    }
}
void BinaryTree::right_rotate(Node *y)
{
    Node *x = y->left;
    Node *t2 = x->right;
    if (y == root)
    {
        root = x;
    }
    else
    {
        if (y == y->parent->left)
        {
            y->parent->left = x;
        }
        else
            y->parent->right = x;
    }
    x->right = y;
    x->parent = y->parent;
    y->parent = x;
    y->left = t2;
    if (t2 != nullptr)
        t2->parent = y;
    Node *temp = y;
    while (temp != nullptr)
    {
        update_height(temp);
        temp = temp->parent;
    }
}

int BinaryTree::update_height(Node *target)
{
    if (target == nullptr)
    {
        return -1;
    }
    int leftHeight = update_height(target->left);
    int rightHeight = update_height(target->right);
    target->height = 1 + max(leftHeight, rightHeight);
    return target->height;
}

void BinaryTree::balance_node(Node *imbalancedNode, int bf, Node *heavyChild)
{   
    
    if (bf > 1 && balance_factor(heavyChild) > 0)
    {
        cout << "LL case" << endl;
        cout << "right_rotate(" << imbalancedNode->data << ")" << endl;
        right_rotate(imbalancedNode);
    }
    else if (bf > 1 && balance_factor(heavyChild) < 0)
    {

        cout << "LR case" << endl;
        cout << "left_rotate(" << heavyChild->data << ")" << endl;
        cout << "right_rotate(" << imbalancedNode->data << ")" << endl;

        left_rotate(heavyChild);
        right_rotate(imbalancedNode);
    }
    else if (bf < -1 && balance_factor(heavyChild) < 0)
    {
        cout << "RR case" << endl;
        cout << "left_rotate(" << imbalancedNode->data << ")" << endl;
        left_rotate(imbalancedNode);
    }
    else if (bf < -1 && balance_factor(heavyChild) > 0)
    {
        cout << "RL case" << endl;
        cout << "right_rotate(" << heavyChild->data << ")" << endl;
        cout << "left_rotate(" << imbalancedNode->data << ")" << endl;
        right_rotate(heavyChild);
        left_rotate(imbalancedNode);
    }
    else
    {
    }
    Node *temp = imbalancedNode;
    while (temp != nullptr)
    {
        update_height(temp);
        temp = temp->parent;
    }
    
}

void BinaryTree::print(Node *start)
{
    if (start == nullptr)
        return;
    print(start->left);
    cout <<start->data << "(" << balance_factor(start) << ") ";
    print(start->right);
}

int main()
{
    BinaryTree bt;
    int n, val;
    bool balanced = true;
    while (cin >> val && val != -1)
    {

        Node *temp = bt.iterative_insert(val);
        balanced = true;
        Node *heavyChild;
        while (temp != nullptr)
        {
            int bf = bt.balance_factor(temp);
            if (bf > 1 || bf < -1)
            {
                balanced = false;
                bt.print(bt.root);
                cout << endl;
                cout << "Imbalance at node: " << temp->data << endl;
                if (bf > 1)
                {
                    heavyChild = temp->left;
                }
                else
                    heavyChild = temp->right;
                // cout << "heavy Child: " << heavyChild->data << endl;
                bt.balance_node(temp, bf, heavyChild);
                cout << "Status: ";
                bt.print(bt.root);
                cout << endl;
                cout << "Root=" <<bt.root->data << endl;
                break;
            }
            temp = temp->parent;
        }
        if(balanced){
            bt.print(bt.root);
                cout << endl;
                cout << "Balanced" << endl;
                cout << "Root=" << bt.root->data << endl;
        }
    }
}
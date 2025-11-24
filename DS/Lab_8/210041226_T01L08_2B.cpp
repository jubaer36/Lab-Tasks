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
    Node(int val) : data(val), left(nullptr), right(nullptr), parent(nullptr) {}
};

class BinaryTree
{
public:
    Node *root;
    int height;
    BinaryTree() : root(nullptr), height(-1) {}
    void insert(int data);
    Node *search(int data, Node *start);
    void sort_tree(Node *start, vector<int> &v);
};

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
}

void BinaryTree::sort_tree(Node *start, vector<int> &v)
{
    if (start == nullptr)
        return;
    sort_tree(start->left, v);
    v.push_back(start->data);
    sort_tree(start->right, v);
}
Node *BinaryTree::search(int data, Node *start)
{
    while (start != nullptr)
    {
        if (start->data >= (data - 3) && start->data <= (data + 3))
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


int main()
{
    BinaryTree bt;
    int val;
    vector<int> v;
    while (cin >> val && val != -1)
    {
        if (!bt.search(val, bt.root))
        {
            bt.insert(val);
        }
        else{
            cout << "Reservation Failed    " ;
        }
        v.clear();
        bt.sort_tree(bt.root, v);
        for (auto it : v)
        {
            cout << it << ' ';
        }
        cout << endl;
    }

    
}
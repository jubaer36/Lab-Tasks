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
    int subtree_size;
    Node(int val) : data(val), left(nullptr), right(nullptr), parent(nullptr),subtree_size(0) {}
};

class BinaryTree
{
public:
    Node *root;
    int height;
    BinaryTree() : root(nullptr), height(-1) {}
    void insert(int data);
    void print(Node* start);
    Node* search(int data, Node *start);
    int numCountBefore(int x);
};


void BinaryTree::print(Node *start)
{
    if (start == nullptr)
        return;
    print(start->left);
    cout << start->data << ' ';
    print(start->right);
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

int BinaryTree::numCountBefore(int x){
    Node* found = search(x,root);
    if(!found)return 0;
    int right_child_subtree_sz = found->right?found->right->subtree_size+1:0;
    while (1)
    {
        if(found->parent == nullptr)break;
        if(found->parent->data < x)
        {
            found = found->parent;
        }
        else break;
    }
    return found->subtree_size - right_child_subtree_sz;
    
        
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
        temp->subtree_size++;
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

int main()
{
    BinaryTree bt;
    int n, val;
    vector<int>arr = {50 , 75 , 25 , 29 , 45 , 60 , 10};
    for (int i = 0; i < arr.size(); i++)
    {
        bt.insert(arr[i]);
    }
    
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> val;
        
        
        cout<<bt.numCountBefore(val) << endl;
    }
    // cout << bt.subtree_size(bt.root,0) << endl;
}
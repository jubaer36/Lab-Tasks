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
    void insert(int data);
    void print(Node *start);
    Node *lca(int a, int b);
    int maxNumInPath(int a, int b);
};

int BinaryTree::maxNumInPath(int a, int b)
{
    int max_num = b;
    Node *temp = lca(a, b);

    while (temp->data!=b)
        {   
            max_num = max(max_num , temp->data);
            if(temp->data > b)temp = temp->left;
            else if(temp->data < b) temp = temp->right;
            else break;
        }
    return max_num;
}
Node *BinaryTree::lca(int a, int b)
{
    Node *start = root;
    while (1)
    {
        if (a > start->data && b > start->data)
        {
            start = start->right;
        }
        else if (a < start->data && b < start->data)
        {
            start = start->left;
        }
        else
            return start;
    }
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
    int n, val, a, b;

    int arr[] = {50, 75, 25, 29, 45, 60, 10, 80};
    for (int i = 0; i < 8; i++)
    {
        bt.insert(arr[i]);
    }
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> a >> b;
        // cout << "Ancestor: " << bt.lca(a,b)->data << ' '<<"max_num : ";
        cout << bt.maxNumInPath(a, b) << endl;
    }

    cout << endl;
}
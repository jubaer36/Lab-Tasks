#include <iostream>
#include <vector>
#include <queue>
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
    int find_height(Node *parent);
    void inorder_print(Node *start);
    void preorder_print(Node *start);
    void postorder_print(Node *start);
    void levelorder_print(Node *start);
};

int BinaryTree::find_height(Node *parent)
{
    if (parent == nullptr)
        return -1;
    int left_height = find_height(parent->left);
    int right_height = find_height(parent->right);
    return max(left_height, right_height) + 1;
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
}

void BinaryTree::inorder_print(Node *start)
{
    if (start == nullptr)
        return;
    inorder_print(start->left);
    cout << start->data << "(";
    if (start->parent)
        cout << start->parent->data << ") ";
    else
        cout << "null) ";
    inorder_print(start->right);
}
void BinaryTree::preorder_print(Node *start)
{
    if (start == nullptr)
        return;
    cout << start->data << "(";
    if (start->parent)
        cout << start->parent->data << ") ";
    else
        cout << "null) ";
    preorder_print(start->left);

    preorder_print(start->right);
}
void BinaryTree::postorder_print(Node *start)
{
    if (start == nullptr)
        return;

    postorder_print(start->left);

    postorder_print(start->right);
    cout << start->data << "(";
    if (start->parent)
        cout << start->parent->data << ") ";
    else
        cout << "null) ";
}
void BinaryTree::levelorder_print(Node *start)
{
    if (start == nullptr)
        return;
    queue<Node *> q;
    q.push(start);
    while (!q.empty())
    {
        Node *temp = q.front();
        q.pop();
        cout << temp->data << "(";
        if (temp->parent)
            cout << temp->parent->data << ") ";
        else
            cout << "null) ";
        if (temp->left)
            q.push(temp->left);
        if (temp->right)
            q.push(temp->right);
    }
}

int main()
{
    BinaryTree bt;
    int n, val, cmd;

    while (cin >> cmd && cmd < 5)
    {
        if (cmd == 0)
        {
            cin >> n;
            for (int i = 0; i < n; i++)
            {
                cin >> val;
                bt.insert(val);
            }
        }

        else if (cmd == 1)
        {
            cout << "Inorder Print: " << endl;
            bt.inorder_print(bt.root);
            cout << endl;
        }
        else if (cmd == 2)
        {
            cout << "Preorder Print: " << endl;
            bt.preorder_print(bt.root);
            cout << endl;
        }
        else if (cmd == 3)
        {
            cout << "Postorder Print: " << endl;
            bt.postorder_print(bt.root);
            cout << endl;
        }
        else if (cmd == 4)
        {
            cout << "Levelorder Print: " << endl;
            bt.levelorder_print(bt.root);
            cout << endl;
        }
        else
            break;
    }
}

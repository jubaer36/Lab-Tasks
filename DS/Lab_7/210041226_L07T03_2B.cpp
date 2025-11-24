#include <iostream>
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

class Tree
{
public:
    Node *root;
    int height;
    Tree() : root(nullptr), height(-1) {}
    void insert(int data, int parent_data, int child_pos);
    Node *search(int data, Node *start);
    void remove(int data, Node *start);
    int find_height(Node *start);
    void print_tree(Node *start);
};

void Tree::insert(int data, int parent_data, int child_pos)
{
    Node *child = new Node(data);
    if (root == nullptr)
    {
        root = child;
        root->parent = nullptr;
        return;
    }
    Node *found = search(parent_data, root);
    if (found)
    {
        if (child_pos == 1)
        {
            child->parent = found;
            found->left = child;
        }
        else if (child_pos == 2)
        {
            child->parent = found;
            found->right = child;
        }
    }
}

int Tree::find_height(Node *start)
{
    int left_height = 0, right_height = 0;
    if (start == nullptr)
        return -1;
    left_height = find_height(start->left);
    right_height = find_height(start->right);
    return max(left_height, right_height) + 1;
}

Node *Tree::search(int data, Node *start)
{
    if (start == nullptr)
    {
        return nullptr;
    }
    if (start != nullptr && start->data == data)
        return start;
    Node *left_found = search(data, start->left);
    if (left_found != nullptr)
        return left_found;
    Node *right_found = search(data, start->right);
    return right_found;
}

void Tree::remove(int data, Node *start)
{
    if (start == nullptr)
    {
        cout << "Nothing to remove " << endl;
    }
    Node *found = search(data, start);
    if (found)
    {   
        if(found->parent->left == found)
            found->parent->left = nullptr;
        else 
            found->parent->right = nullptr;
        found->left = nullptr;
        found->right = nullptr;
        free(found);
    }
}

void Tree::print_tree(Node *start)
{
    if (start == nullptr)
    {
        return;
    }
    cout << start->data << ' ';
    print_tree(start->left);
    print_tree(start->right);
}

int main()
{

    // Take 1 as the command to insert then the number of inputs as n
    Tree tr;
    int cmd, n, x;

    while (1)
    {
        cin >> cmd;
        if (cmd == 1)
        {

            cin >> n;
            while (n--)
            {
                int a, b, c;
                cin >> a >> b >> c;
                tr.insert(a, b, c);
            }
            tr.print_tree(tr.root);
            cout << endl;
        }

        else if (cmd == 2)
        {
            cin >> x;
            tr.remove(x, tr.root);
            tr.print_tree(tr.root);
            cout << endl;
        }

        else if (cmd == 3)
        {
            cin >> x;
            Node *found = tr.search(x, tr.root);
            if (!found)
            {
                cout << "Not Present";
            }
            else
            {
                cout << "Present, Left(";
                if (found->left)
                {
                    cout << found->left->data << "), Right(";
                }
                else
                    cout << "null), Right(";
                if (found->right)
                {
                    cout << found->right->data << ")";
                }
                else
                    cout << "Null)";
            }
            cout << endl;
        }

        else if (cmd == 4)
        {
            cout << "Height: " << tr.find_height(tr.root) << endl;
            // tr.print_tree(tr.root);
            // cout << endl;
        }
        else
            break;
    }
}
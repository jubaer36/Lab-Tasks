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
    void remove(int val , Node* start);
    Node* search(int data, Node *start);
    Node* find_max(Node *start);
    Node* find_successor(Node *start);
    Node* find_min(Node *start);
    void levelorder_print(Node *start);

   
};

void BinaryTree::levelorder_print(Node *start)
{
    if (start == nullptr){
        return;}
    queue<Node *> q;
    q.push(start);
    while (!q.empty())
    {
        Node *temp = q.front();
       // cout << " lol ";
        q.pop();
        cout << temp->data << ' ';
        if (temp->left)
            q.push(temp->left);
        if (temp->right)
            q.push(temp->right);
    }
}
Node* BinaryTree::find_min(Node *start){
    while (start->left!=nullptr)
    {
        start = start->left;
    }
    return start;
    
}
Node* BinaryTree::find_successor(Node *start){
    if(start == find_max(root)){
        return nullptr;
    }
    else if(start->right != nullptr){
        return find_min(start->right);
    }
    else{
        Node* y = start->parent;
        while (y->parent!= nullptr && start->data > y->data)
        {
            y = y->parent;
        }
        return y;
        
    }
}
Node* BinaryTree::find_max(Node *start){
    while (start->right!=nullptr)
    {
        start = start->right;
    }
    return start;
}

void BinaryTree::remove(int val , Node* start){
    cout << "lol\n";
    Node *target = search(val ,start);
    if (target == nullptr)
    {
        return;
    }

    Node *target_parent = target->parent;

    if (target->left == nullptr && target->right == nullptr)
    {   
        // cout << "working";
        if (target_parent == nullptr)
        {
            delete root;
            root = nullptr;
        }
        else if (target_parent->left == target)
        {
            target_parent->left = nullptr;
            delete target;
        }
        else
        {
            target_parent->right = nullptr;
            delete target;
        }
    }
    else if (target->left== nullptr || target->right == nullptr)
    {   
        // cout << "working";
        Node *child = (target->left != nullptr) ? target->left : target->right;

        if (target_parent == nullptr)
{
    delete root;
    root = child; 
    if (child != nullptr) {
        child->parent = nullptr;
    }
}

        else if (target_parent->left == target)
        {
            target_parent->left = child;
            child->parent = target_parent;
            delete target;
        }
        else
        {
            target_parent->right = child;
            child->parent = target_parent;
            delete target;
        }
    }
    else
    {   
        // cout << "working";
        // cout << 's';
        Node * target_successor = find_successor(target);
            if(target->parent == nullptr)
            {
                target_successor->left = target->left;
                target->left->parent = target_successor;
                target->right->parent = nullptr;
                root = target->right;
                delete target;
            }
            else if(target == target_parent->right)
            {
                target_parent->right = target->right;
            }
            else
            {
                target_parent->left = target->right;
            }
            target->right->parent = target_parent;
            target_successor->left = target->left;
            target->left->parent = target_successor;
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
    vector<int>arr = {50, 75, 25, 29, 45, 60, 90, 10, 80, 100, 84, 88};
    for (int i = 0; i < arr.size(); i++)
    {
        bt.insert(arr[i]);
    }
    
    cin >> n;
    for (int i = 0; i < n; i++)
    {
        cin >> val;
        bt.remove(val,bt.root);
        //cout << i+1 <<" "<<n<< "    ";
        bt.levelorder_print(bt.root);
        cout << endl;
        
    }
}
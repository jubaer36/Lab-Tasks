#include<iostream>
using namespace std;

class Node{
    public:
        int data;
        Node* left;
        Node* right;
        int height;
        Node* parent;
        Node(int data)
        {
            this->data = data;
            this->left = NULL;
            this->right = NULL;
            this->height = 0;
            this->parent = NULL;
        }
};

Node* root = NULL;
Node* lastInsertedNode = NULL;

int updataHeight(Node* &x)
{
    if(x==NULL)
    return -1;

    x->height = max(updataHeight(x->left),updataHeight(x->right))+1;
    return x->height;
}

int balanceFactor(Node* &x)
{
    int heightLeft;
    int heightRight;

    if(x->left == NULL)
    heightLeft = -1;
    else
    heightLeft = x->left->height;

    if(x->right == NULL)
    heightRight = -1;
    else
    heightRight = x->right->height;

    return (heightLeft - heightRight);
   
}

void printAVL(Node* &x)
{
    
    if(x!=NULL)
    {
        
        printAVL(x->left);

        int bf = balanceFactor(x);

        cout<<x->data<<"("<<bf<<")"<<" ";

        printAVL(x->right);
    }

}

void insertion(Node* &currentNode, int key)
{
    if(root == NULL)
    {
        Node* temp = new Node(key);

        root = temp;

        lastInsertedNode = root;
    }
    else if(currentNode->data < key)
    {
        if(currentNode->right == NULL)
        {
            Node* temp = new Node(key);
            currentNode->right = temp;
            temp->parent = currentNode;
            lastInsertedNode = temp;
        }
        else
        {
            insertion(currentNode->right,key);
        }
    }
    else
    {
        if(currentNode->left == NULL)
        {
            Node* temp = new Node(key);
            currentNode->left = temp;
            temp->parent = currentNode;
            lastInsertedNode = temp;
        }
        else
        {
            insertion(currentNode->left,key);
        }
    }
}
int main()
{
    int key; cin>>key;

    while (key!=-1)
    {
        insertion(root,key);
        updataHeight(root);
        printAVL(root);
        cout<<endl;
        
        
        
        cin>>key;
    }
    

}
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


Node* imbalancedHeavyChild(Node* &x)
{
    if(x==NULL || x->parent == NULL)
    return lastInsertedNode;

    else
    {
        Node* parent;
        parent = x->parent;
        int BF_of_parent = balanceFactor(parent);

        if(BF_of_parent<-1 || BF_of_parent>1)
        return x;
        else
        imbalancedHeavyChild(parent);

    }
}

// void right_rotation(Node* z)
// {
    
//     Node* y;
//     y = z->left;
//     Node* parent ;
//     parent= z->parent;
    

//     int side = 0;
    
//     if(z == parent->left)
//     side++;

//     if(y->right !=NULL)
//     {
//         z->left = y->right;
//     y->right->parent = z;}

    

    

//     if(side)
//     {
//         if(parent!=NULL)
//         {parent->left = y;
//         y->parent = parent;}
//         else
//         {
//             y->parent = NULL;
//         }
//     }
//     else
//     {
//         parent->right = y;
//         y->parent = parent;
//     }

//     y->right = z;
//     z->parent = y;

//     if(y->parent == NULL)
//     root=y;
    

       
// }

// void left_rotation(Node* &z)
// {
//     Node* y ;
//     y= z->right;
//     Node* parent;
//     parent = z->parent;

//     int side = 0;
//     if(z== parent->left)
//     side++;

//     if(y->left!=NULL)
//    {z->right = y->left;
//     y->left->parent = z;}


//     if(side)
//     {
//         if(parent!=NULL)
//         {parent->left = y;
//         y->parent = parent;}
//         else
//         {
//             y->parent = NULL;
//         }
//     }
//     else
//     {
//         parent->right = y;
//         y->parent = parent;
//     }

//     y->left = z;
//     z->parent = y;

//     if(y->parent == NULL)
//     root=y;
// }

void right_rotation(Node* z)
{
    Node* y = z->left;
    Node* parent = z->parent;
    int isLeftChild = (parent && z == parent->left);

    z->left = y->right;
    if (z->left)
        z->left->parent = z;

    y->right = z;
    z->parent = y;

    if (parent) {
        if (isLeftChild)
            parent->left = y;
        else
            parent->right = y;
    } else {
        root = y;
    }

    y->parent = parent;
}

void left_rotation(Node* z)
{
    Node* y = z->right;
    Node* parent = z->parent;
    int isLeftChild = (parent && z == parent->left);

    z->right = y->left;
    if (z->right)
        z->right->parent = z;

    y->left = z;
    z->parent = y;

    if (parent) {
        if (isLeftChild)
            parent->left = y;
        else
            parent->right = y;
    } else {
        root = y;
    }

    y->parent = parent;
}


void AVL_balance(Node* &x)
{
    string AVL_case;

    Node* parent;
    parent = x->parent;

    if(x== parent->left && x->data >= lastInsertedNode->data )
    AVL_case = "LL";
    else if(x== parent->right && x->data < lastInsertedNode->data)
    AVL_case = "RR";
    else if( x == parent->left && x->data < lastInsertedNode->data)
    AVL_case = "LR";
    else 
    AVL_case = "RL";

    cout<<AVL_case<<" case "<<endl;

    if(AVL_case == "LL")
    {
        cout<<"Right_rotate"<<"("<<parent->data<<")"<<endl;
        right_rotation(parent);
    }
    else if(AVL_case == "RR")
    {
        cout<<"Left_rotate"<<"("<<parent->data<<")"<<endl;
        left_rotation(parent);
    }
    else if( AVL_case == "LR")
    {
        cout<<"Left_rotate"<<"("<<x->data<<"), "<<"Right_rotate"<<"("<<parent->data<<")"<<endl;
        left_rotation(x);
        right_rotation(parent);
    }
    else
    {
        cout<<"Right_rotate"<<"("<<x->data<<"), "; cout<<"Left_rotate"<<"("<<parent->data<<")"<<endl;
        right_rotation(x);
        left_rotation(parent);
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
        
        Node* heavychild;
        heavychild = imbalancedHeavyChild(lastInsertedNode);
        
        
        if(heavychild == lastInsertedNode)
        {
            cout<<"Balanced"<<endl<<"Root=";
            cout<<root->data<<endl;
        }
        else
        {
            cout<<"Imbalance at node: "<<heavychild->parent->data<<endl;
            AVL_balance(heavychild);
            updataHeight(root);
            cout<<"Status: ";
            printAVL(root);
            cout<<endl;
            cout<<"Root="<<root->data<<endl;
            

        }
        
        
        cin>>key;
    }
    

}
#include <iostream>
#include <queue>

using namespace std;

struct Node {
    int data;
    int subtree_size = 0;
    Node* parent;
    Node* left;
    Node* right;
    Node(int val) : data(val), parent(nullptr), left(nullptr), right(nullptr) {}
};

class BST {
private:
    Node* head = nullptr;

public:
    Node* getHead() {
        return head;
    }

    void insert(int val) {
        Node* new_node = new Node(val);
        if (!head) {
            head = new_node;
        } else {
            Node* temp = head;
            while (temp) {
                temp->subtree_size++;
                if (new_node->data < temp->data) {
                    if (temp->left == nullptr) {
                        new_node->parent = temp;
                        temp->left = new_node;
                        break;
                    }
                    temp = temp->left;
                } else {
                    if (temp->right == nullptr) {
                        new_node->parent = temp;
                        temp->right = new_node;
                        break;
                    }
                    temp = temp->right;
                }
            }
        }
    }

    Node* bstSearch(int key){
        Node* temp = head;
        while(temp->data != key || temp != nullptr){
            if(temp->data > key){
                temp = temp->left;
            }
            else if(temp->data < key){
                temp = temp->right;
            }
            else{
                return temp;
            }
        }
        return nullptr;
    }

    Node* findInOrderSuccessor(Node* node) {
        while (node->left) {
            node = node->left;
        }
        return node;
    }

    void remove(int val) {
        Node* z = bstSearch(val);
        Node* zp = z->parent;
        
        if (z->left == nullptr && z->right == nullptr) {
            if (zp) {
                if (zp->left == z) {
                    zp->left = nullptr;
                } else {
                    zp->right = nullptr;
                }
            } 
            else{
                head = nullptr;
            }
            delete z;
        } else if (z->left == nullptr || z->right == nullptr) {
            Node* child = (z->left) ? z->left : z->right;
            if (zp) {
                if (zp->left == z) {
                    zp->left = child;
                } else {
                    zp->right = child;
                }
                child->parent = zp;
            } 
            else {
                head = child;
                child->parent = nullptr;
            }
            delete z;
        } 
        else{
            Node *successorParent = z;
            Node *successor = z->right;
            while (successor->left != nullptr)
            {
                successorParent = successor;
                successor = successor->left;
            }

            z->data = successor->data;

            if (successorParent == z)
                successorParent->right = successor->right;
            else
                successorParent->left = successor->right;

            delete successor;
        }
    }


    void levelOrderTraversal() {
        queue<Node*> q;
        if (!head) {
            return;
        }

        q.push(head);
        while (!q.empty()) {
            Node* temp = q.front();
            q.pop();
            cout << temp->data << " ";
            if (temp->left) {
                q.push(temp->left);
            }
            if (temp->right) {
                q.push(temp->right);
            }
        }
        cout << endl;
    }
};

int main() {
    BST tree;
    int arr[] = {50, 75, 25, 29, 45, 60, 90, 10, 80, 100, 84, 88};
    for (int i = 0; i < 12; i++) {
        tree.insert(arr[i]);
    }

    int n;
    cin >> n;

    for (int i = 0; i<n; i++) {
        int x;
        cin >> x;
        tree.remove(x);
        tree.levelOrderTraversal();
    }

    return 0;
}

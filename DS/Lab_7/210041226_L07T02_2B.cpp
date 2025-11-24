#include <iostream>
using namespace std;

class Node

{

public:
    int data;
    Node *next;
    Node *prev;

    Node(int val) : data(val), next(nullptr), prev(nullptr) {}
};

class body
{
public:
    int length;
    Node *head;
    Node *tail;
    body()
    {
        head = nullptr;
        tail = nullptr;
        length = 0;
    }
    Node *create_node(int data);
    void insert_front(int data);
    void insert_back(int data);
    void insert_after_val(int val, int data);
    void update_node(int data, int val);
    Node *find_val(int val);
    void remove_head();
    void remove_element(int data);
    void remove_end();
    void print_list();
};

Node *body::create_node(int data)
{
    Node *newNode = new Node(data);
    return newNode;
}

Node* body::find_val(int val)
{
    Node* temp = head;

    while (temp != nullptr)
    {
        if (temp->data == val)
        {
            return temp;
        }
        temp = temp->next;
    }
    cout << "Value not found " <<endl;
    return nullptr;
}


// 1
void body::insert_front(int data)
{
    Node *newNode = create_node(data);
    if (length < 1)
    {
        head = newNode;
        tail = newNode;
        length++;
        return;
    }
    else
    {
        newNode->next = head;
        head->prev = newNode;
        head = newNode;
    }
    length++;
}

// 2
void body::insert_back(int data)
{
    Node *newNode = create_node(data);
    if (length < 1)
    {
        head = newNode;
        tail = newNode;
        length++;
        return;
    }
    else
    {
        newNode->prev = tail;
        tail->next = newNode;
        tail = newNode;
    }
    length++;
}

// 3
void body::insert_after_val(int val, int data)
{
    Node *found = find_val(val);
    Node *newNode = create_node(data);
    if (found == tail)
    {
        insert_back(data);
    }
    else if (found)
    {
        newNode->prev = found;
        newNode->next = found->next;
        found->next = newNode;
        length++;
    }
}

// 4
void body::update_node(int data, int val)
{
    Node *found = find_val(val);
    if (found)
    {
        found->data = data;
    }
}

// 5
void body::remove_head()
{
    if (length == 0)
    {
        cout << "Underflow" << endl;
        return;
    }
    if (length == 1)
    {
        head = nullptr;
        tail = nullptr;
        length--;
        return;
    }
    head = head->next;
    head->prev = nullptr;
    length--;
}

// 6
void body::remove_element(int data)
{

    
    Node *found = find_val(data);
    if (length == 1 && found)
    {
        head = nullptr;
        tail = nullptr;
        length--;
        return;
    }
    if (found == head && head != nullptr)
    {
        remove_head();
    }
    else if (found == tail && tail != nullptr)
    {
        remove_end();
    }
    else if (found)
    {
        found->prev->next = found->next;
        found->next->prev = found->prev;
        length--;
    }

    return;
}

// 7
void body::remove_end()
{
    if (length == 0)
    {
        cout << "Underflow" << endl;
        return;
    }
    if (length == 1)
    {
        head = nullptr;
        tail = nullptr;
        length--;
        return;
    }
    tail = tail->prev;
    tail->next = nullptr;
    length--;
}

void body::print_list()
{
    if (length == 0)
    {
        cout << "Head = "
             << "Null"
             << ", Tail = Null"
             << ", Empty" << endl;
        return;
    }
    cout << "Size: " << length << "   Head : " << head->data << "    Tail: " << tail->data << endl;
    cout << "Elements: ";
    Node *temp = head;
    for (int i = 0; i < length; i++, temp = temp->next)
    {
        cout << temp->data << ' ';
    }
    cout << endl;
}

int main()
{
    body ll;
    while (1)
    {
        int choice;
        cin >> choice;

        switch (choice)
        {
        case 1:
        {
            int data;
            cin >> data;
            ll.insert_front(data);
            ll.print_list();
            break;
        }
        case 2:
        {
            int data;
            cin >> data;
            ll.insert_back(data);
            ll.print_list();
            break;
        }
        case 3:
        {
            int value, data;
            cin >> value >> data;
            ll.insert_after_val(data, value);
            ll.print_list();
            break;
        }
        case 4:
        {
            int oldValue, newValue;
            cin >> oldValue >> newValue;
            ll.update_node(oldValue, newValue);
            ll.print_list();
            break;
        }
        case 5:
            ll.remove_head();
            ll.print_list();
            break;
        case 6:
        {
            int value;
            cin >> value;
            ll.remove_element(value);
            ll.print_list();
            break;
        }
        case 7:
            ll.remove_end();
            ll.print_list();
            break;
        case 8:

            return 0;
        }
    }

    return 0;
    // body ll;
    // ll.insert_front(4);
    // ll.print_list();
    // ll.insert_front(4);
    // ll.print_list();
    // ll.insert_back(500);
    // ll.print_list();
    // ll.insert_front(5);
    // ll.print_list();
    // ll.insert_after_val(8, 5);
    // ll.print_list();
    // ll.insert_after_val(9, 6);
    // ll.print_list();
    // ll.insert_after_val(10, 4);
    // ll.print_list();
    // ll.update_node(56, 501);

    // ll.print_list();
    // cout << "removing starts" << endl;
    // ll.remove_head();
    // ll.print_list();
    // ll.remove_end();
    // ll.print_list();
    // ll.remove_element(10);

    // ll.print_list();
}

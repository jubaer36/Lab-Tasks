#include <iostream>
#include <string>
#include <sstream>
using namespace std;

class Node{
    public:
        bool endmark;
        Node* next[26];
        Node()
        {
            endmark = false;
            
            for(int i=0;i<26;i++)
                next[i] = NULL;
        }
};

void insert(Node* &root , string myString)
{
    Node* current  = root;

    for(int i=0;i<myString.length();i++)
    {
        int index = myString[i] - 'a';

        if(current->next[index] ==  NULL)
           current->next[index] = new Node();
        
        current = current->next[index];
    }

    current->endmark = true;
}

bool search(Node* &root, string myString)
{
    Node* current = root;

    for(int i=0;i<myString.length();i++)
    {
        int index = myString[i]-'a';

        if(current->next[index] == NULL)
            return false;
        
        current = current->next[index];
        
    }

    return current->endmark;
}

void display(Node* &current, char myString[], int level)
{
    if(current->endmark == true)
    {
        myString[level] = '\0';
        cout<<myString<<" ";
    }

    for(int i=0;i<26;i++)
    {
        if(current->next[i] != NULL)
        {
            myString[level] = 'a'+i;

            display(current->next[i],myString,level+1);
        }
    }
}

int main()
{
    Node* root = new Node();

    string line;
    char word[500];
    getline(cin, line);
    stringstream iss(line);

    while (iss >> word)
    {   
        // cout << word << endl;
        insert(root , &word[0]);
    }
    display(root, word, 0);
}
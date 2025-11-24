#include <iostream>
#include <string>
#include <sstream>
#define alphabet_size 26
using namespace std;
class Node
{

public:
    bool endmark;
    Node *next[alphabet_size];
    Node()
    {   
        endmark = false;
        for (size_t i = 0; i < alphabet_size; i++)
        {
            next[i] = nullptr;
        }
    }
};
class Trie
{
public:
    Node *root;
    Trie()
    {
        root = new Node();
    }
    void insert(string &str, int len);
    bool search(string &str, int len);
    void display(Node *curr,char str[], int level);
};

void Trie::insert(string &str, int len)
{
    Node *curr = root;
    for (int i = 0; i < len; i++)
    {
        int idx = str[i] - 'a';
        if (curr->next[idx] == nullptr)
        {
            curr->next[idx] = new Node();
        }
        curr = curr->next[idx];
    }
    curr->endmark = true;
}
bool Trie::search(string &str, int len)
{
    Node *curr = root;
    for (int i = 0; i < len; i++)
    {
        int idx = str[i] - 'a';
        if (curr->next[idx] == nullptr)
        {
            return false;
        }
        curr = curr->next[idx];
    }
    return curr->endmark;
}
void Trie::display(Node *curr, char str[], int level)
{
    if (curr->endmark == true)
    {
        str[level] = '\0';
        cout << str << ' ';
    }
    for (int i = 0; i < alphabet_size; i++)
    {
        if (curr->next[i]!=nullptr)
        {
            str[level] = 'a'+i;
            display((curr->next[i]),str,level+1);
        }
        
    }
}
int main()
{
    Trie t;

    string line;
    string word;
    char res[500];
    getline(cin, line);
    stringstream iss(line);

    while (iss >> word)
    {   
        // cout << word << endl;
        t.insert(word, word.length());
    }
    
    t.display(t.root,res, 0);

    cout << endl;
    line = "";
    getline(cin , line);
    stringstream is(line);
    while(is >> word){
        cout <<boolalpha<<t.search(word,word.length()) << " ";
    }
}
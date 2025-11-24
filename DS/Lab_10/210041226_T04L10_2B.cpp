#include <iostream>
#include <string>
#include <sstream>
#include <cctype>
#include <string>
#include <algorithm>
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
    Node *search(string &str, int len);
    void counter(Node *curr, char str[], int level, int &count);
    int prefix_count(string str);
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
Node *Trie::search(string &str, int len)
{
    Node *curr = root;
    for (int i = 0; i < str.size(); i++)
    {
        int idx = str[i] - 'a';
        if (curr->next[idx] == nullptr)
        {
            return nullptr;
        }
        curr = curr->next[idx];
    }
    return curr;
}

int Trie::prefix_count(string word)
{
    char res[500];
    int count = 0;
    Node *curr = search(word, word.length());
    if (curr != nullptr)
    {
        counter(curr, res, word.length(), count);
    }
    return count;
}

void Trie::counter(Node *curr, char str[], int level, int &count)
{
    if (curr == nullptr)
        return;
    if (curr->endmark == true)
    {
        str[level] = '\0';
        // cout << str << ' ';
        count++;
    }
    for (int i = 0; i < alphabet_size; i++)
    {
        if (curr->next[i] != nullptr)
        {
            str[level] = 'a' + i;
            counter((curr->next[i]), str, level + 1, count);
        }
    }
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
void toLowerCase(string &s)
{
    transform(s.begin(), s.end(), s.begin(), ::tolower);
}
int main()
{
    Trie t;
    int n, q;
    cin >> n >> q;
    string word;

    for (int i = 0; i < n; i++)
    {
        cin >> word;
        toLowerCase(word);
        t.insert(word, word.length());
    }
    

    for (int i = 0; i < q; i++)
    {
        cin >> word;
        toLowerCase(word);
        cout << t.prefix_count(word) << endl;
    }
}
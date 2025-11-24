#include<iostream>
#include<string>
#include<algorithm>
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

Node* search(Node* &root, string myString)
{
    Node* current = root;

    for(int i=0;i<myString.length();i++)
    {
        int index = myString[i]-'a';

        if(current->next[index] == NULL)
            return NULL;
        
        current = current->next[index];
         
    }
    

    return current;
}

void display(Node* &current, char myString[], int level,int &count)
{
    if(current->endmark == true)
    {
        myString[level] = '\0';
        
        count++;
    }

    for(int i=0;i<26;i++)
    {
        if(current->next[i] != NULL)
        {
            myString[level] = 'a'+i;

            display(current->next[i],myString,level+1,count);
        }
    }
}



int prefixCount(Node* &root, string &prefixString)
{
    Node* prefixNode = search(root,prefixString);

    int count = 0 ;
    char tempString[500];

    if(prefixNode != NULL)
    display(prefixNode,tempString,0,count);

    return count;

}

int main()
{
    Node* root = new Node();

    int n,q; cin>>n>>q;

    for(int i=0;i<n;i++)
    {
        string myString; cin>>myString;
        transform(myString.begin(),myString.end(),myString.begin(), ::tolower);
        insert(root,myString);
    }

    for(int i=0;i<q;i++)
    {
        string prefixString; cin>>prefixString;
        transform(prefixString.begin(),prefixString.end(),prefixString.begin(),::tolower);

        int num = prefixCount(root,prefixString);

        cout<<num<<endl;


    }
}



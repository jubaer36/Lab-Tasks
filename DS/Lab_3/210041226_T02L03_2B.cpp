#include <iostream>
#include <stack>
#include <string>

using namespace std;

int findError(string full_line, int line_num, stack<string> &stk);

int main()
{
    int length, errorAtLine = -1;
    stack<string> stk;
    cin >> length;
    cin.ignore();
    for (int k = 0; k < length; k++)
    {

        string full_line;
        getline(cin, full_line);
        if (errorAtLine == -1)
            errorAtLine = findError(full_line, k , stk);
    }
    cin.ignore();
    if (errorAtLine != -1)
    {
        cout << "Error at line " << errorAtLine << endl;
    }
    else
        cout << "No error" << endl;
}


// Function for finding errors
int findError(string full_line, int line_num, stack<string> &stk)
{
    int errorAtLine = -1;
    string block;
    for (int i = 0; i < full_line.length(); i++)
    {
        if (full_line[i] == '<')
        {
            for (int j = i; j < full_line.length(); j++)
            {

                if (full_line[j] == '>')
                {
                    if (full_line[i + 1] == '/')
                    {
                        block = full_line.substr(i + 2, j - i - 2);
                        if (!stk.empty() && stk.top() != block)
                        {

                            errorAtLine = line_num + 1;
                            return errorAtLine;
                        }
                        else
                            stk.pop();
                    }
                    else
                    {
                        block = full_line.substr(i + 1, j - i - 1);
                        stk.push(block);
                    }
                    break;
                }
            }
        }
    }
    return errorAtLine;
}
